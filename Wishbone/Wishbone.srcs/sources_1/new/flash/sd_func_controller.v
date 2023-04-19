//2021.5.16修正了当CPU频率调高时，取指失效的问题，解决办法是将rd信号和wr信号清零的位置放在byte_counter计满256的位置
//2021.5.17修复了inner_address
module sd_func_controller(
    input CLK100MHZ, 
    input rst,
    input CLK25MHZ,
    input locked,
    
    input SD_CD,
    output SD_RESET, 
    output SD_SCK, 
    output SD_CMD, 
    inout [3:0] SD_DAT, 
    
    output [31:0] s_odata,
	input [31:0] s_idata,
	input [31:0] s_addr,
	input [3:0] s_sel, 
	input s_we,
	input s_cyc,
	input s_stb, 
	output reg s_ack,
	output reg s_err,
	output reg s_rty,
	output o_dirty,//for debbug
	output [3:0] st,
	output [31:0] bt,
	output [4:0] signal_controller_status,
	output read
    );    
    wire [31:0] inner_address;
    wire [8:0] span_address;
    
    wire spiClk;
    wire spiMiso;
    wire spiMosi;
    wire spiCS;
    // MicroSD SPI/SD Mode/Nexys 4
    // 1: Unused / DAT2 / SD_DAT[2]
    // 2: CS / DAT3 / SD_DAT[3]
    // 3: MOSI / CMD / SD_CMD
    // 4: VDD / VDD / ~SD_RESET
    // 5: SCLK / SCLK / SD_SCK
    // 6: GND / GND / - 
    // 7: MISO / DAT0 / SD_DAT[0]
    // 8: UNUSED / DAT1 / SD_DAT[1]
    assign SD_DAT[2] = 1;
    assign SD_DAT[3] = spiCS;
    assign SD_CMD = spiMosi;
    assign SD_RESET = 0;
    assign SD_SCK = spiClk;
    assign spiMiso = SD_DAT[0];
    assign SD_DAT[1] = 1;
    
    reg rd;
    wire [7:0] dout;
    wire byte_available;
    
    reg wr;
    reg [7:0] din;
    wire ready_for_next_byte;
    
    wire ready;
    wire [31:0] sd_address; //02_00是第二个扇区
    
    
    sd_signal_controller signal_controller(
        .cs(spiCS), 
        .mosi(spiMosi), 
        .miso(spiMiso),
        .sclk(spiClk),
        
        .rd(rd),
        .dout(dout),
        .byte_available(byte_available),
        
        .wr(wr),
        .din(din),
        .ready_for_next_byte(ready_for_next_byte),
        
        .reset(rst),
        .ready(ready),
        .address(sd_address), 
        .clk(CLK25MHZ), 
        .status(signal_controller_status)
    );
    
    
    reg [6:0] mem_address;
    reg [31:0] mem_idata;
    reg mem_wena;
    wire [31:0] mem_odata;
    reg [22:0] mem_head_address;
    reg mem_dirty;
    reg mem_load;
    sd_buf BUF(
        .a(mem_address),
        .d(mem_idata),
        .clk(CLK100MHZ),
        .we(mem_wena),
        .spo(mem_odata)
    );
    
    reg [31:0] byte_counter;
    reg [31:0] new_byte_counter;
    reg finish;
    reg first;
    
    parameter IDLE=8'd0;
    parameter READ=8'd1;
    parameter WRITE=8'd2;
    parameter SAVE=8'd3;
    parameter LOAD=8'd4;
    reg [7:0] state;
    reg [7:0] return_state;
    always@(posedge CLK100MHZ or posedge rst)
    begin
        if(rst)
        begin
            s_ack<=1'b0;
            s_err<=1'b0;
            s_rty<=1'b0;
            
            rd<=1'b0;
            wr<=1'b0;
            mem_wena<=1'b0;
            mem_head_address<=23'b0;
            mem_dirty<=1'b0;
            mem_load<=1'b0;
            byte_counter<=32'b0;
            new_byte_counter<=32'b0;
            finish<=1'b0;
            first<=1'b0;
            state<=IDLE;
            return_state<=IDLE;
        end
        else
        begin
            case(state)
            IDLE:begin
                s_ack<=1'b0;
                s_err<=1'b0;
                s_rty<=1'b0;
                
                rd<=1'b0;
                wr<=1'b0;
                mem_wena<=1'b0;
                byte_counter<=32'b0;
                new_byte_counter<=32'b0;
                finish<=1'b0;
                first<=1'b0;
                if(~ready)
                begin
                    state<=IDLE;
                end
                else if(s_cyc&s_stb&~s_we)
                begin
                    state<=READ;
                end
                else if(s_cyc&s_stb&s_we)
                begin
                    state<=WRITE;
                end
                else
                begin
                    state<=IDLE;
                end
            end
            READ:begin
                if(inner_address[31:9]==mem_head_address&&mem_load)
                begin
                    mem_wena<=1'b0;
                    s_ack<=1'b1;
                    state<=IDLE;
                end
                else if(mem_dirty)
                begin
                    wr<=1'b1;
                    mem_wena<=1'b0;
                    byte_counter<=32'b0;
                    new_byte_counter<=32'b0;
                    finish<=1'b0;
                    first<=1'b1;
                    state<=SAVE;
                    return_state<=READ;
                end
                else
                begin
                    rd<=1'b1;
                    mem_wena<=1'b0;
                    byte_counter<=32'b0;
                    new_byte_counter<=32'b0;
                    finish<=1'b0;
                    state<=LOAD;
                    return_state<=READ;
                end
            end
            WRITE:begin
                if(inner_address[31:9]==mem_head_address&&mem_load)
                begin
                    if(~finish)
                    begin
                        mem_wena<=1'b1;
                        mem_dirty<=1'b1;
                        finish<=1'b1;
                        state<=WRITE;
                    end
                    else
                    begin
                        mem_wena<=1'b0;
                        s_ack<=1'b1;
                        state<=IDLE;
                    end
                end
                else if(mem_dirty)
                begin
                    wr<=1'b1;
                    mem_wena<=1'b0;
                    byte_counter<=32'b0;
                    new_byte_counter<=32'b0;
                    finish<=1'b0;
                    first<=1'b1;
                    state<=SAVE;
                    return_state<=WRITE;
                end
                else
                begin
                    rd<=1'b1;
                    mem_wena<=1'b0;
                    byte_counter<=32'b0;
                    new_byte_counter<=32'b0;
                    finish<=1'b0;
                    state<=LOAD;
                    return_state<=WRITE;
                end
            end
            SAVE:begin
                if(byte_counter>=512)
                begin
                    rd<=1'b1;
                    wr<=1'b0;
                    byte_counter<=32'b0;
                    new_byte_counter<=32'b0;
                    finish<=1'b0;
                    mem_dirty<=1'b0;
                    state<=LOAD;
                end
                else if(ready_for_next_byte)
                begin
                    if(first)
                    begin
                        byte_counter<=32'b0;
                        finish<=1'b1;
                        first<=1'b0;
                        state<=SAVE;
                    end
                    else if(~finish)
                    begin
                        byte_counter<=byte_counter+1;
                        finish<=1'b1;
                        state<=SAVE;
                    end
                    else
                    begin
                        state<=SAVE;
                    end
                end
                else
                begin
                    finish<=1'b0;
                    state<=SAVE;
                end
            end
            LOAD:begin
                if(byte_counter>=512)
                begin
                    mem_wena<=1'b0;
                    mem_head_address<=inner_address[31:9];
                    mem_dirty<=1'b0;
                    mem_load<=1'b1;
                    rd<=1'b0;
                    state<=return_state;
                end
                else if(byte_available)
                begin
                    if(~finish)
                    begin
                        mem_wena<=1'b1;
                        new_byte_counter<=byte_counter+1;
                        finish<=1'b1;
                        state<=LOAD;
                    end
                    else
                    begin
                        mem_wena<=1'b0;
                        byte_counter<=new_byte_counter;
                        state<=LOAD;
                    end
                end
                else
                begin
                    mem_wena<=1'b0;
                    finish<=1'b0;
                    state<=LOAD;
                end
            end
            endcase
        end
    end
    always@(*)
    begin
        if(rst)
        begin
            mem_address<=7'b0;
        end
        else
        begin
            case(state)
            IDLE,READ,WRITE:mem_address<=span_address[8:2];
            SAVE,LOAD:mem_address<=byte_counter[8:2];
            endcase
        end
    end
    always@(*)
    begin
        if(rst)
        begin
            mem_idata<=32'b0;
        end
        else begin
            case(state)
            IDLE,READ,SAVE:mem_idata<=32'b0;
            WRITE:mem_idata<={(s_sel[3]? s_idata[31:24]:mem_odata[31:24]),(s_sel[2]? s_idata[23:16]:mem_odata[23:16]),(s_sel[1]? s_idata[15:8]:mem_odata[15:8]),(s_sel[0]? s_idata[7:0]:mem_odata[7:0])};
            LOAD:begin
                case(byte_counter[1:0])
                2'b00:mem_idata<={dout,mem_odata[23:0]};
                2'b01:mem_idata<={mem_odata[31:24],dout,mem_odata[15:0]};
                2'b10:mem_idata<={mem_odata[31:16],dout,mem_odata[7:0]};
                2'b11:mem_idata<={mem_odata[31:8],dout};
                endcase
            end
            endcase
        end
    end
    always@(*)
    begin
        if(rst)
        begin
            din<=8'b0;
        end
        else
        begin
            case(byte_counter[1:0])
            2'b00:din<=mem_odata[31:24];
            2'b01:din<=mem_odata[23:16];
            2'b10:din<=mem_odata[15:8];
            2'b11:din<=mem_odata[7:0];
            endcase
        end
    end
    assign s_odata=mem_odata;
    assign inner_address={4'b0,s_addr[27:0]};
    assign span_address=inner_address[8:0];
    assign sd_address=wr? {mem_head_address,9'b0}:{inner_address[31:9],9'b0};
    assign o_dirty=mem_dirty;
    assign st=state[3:0];
    assign bt=byte_counter;
    assign read=rd;
endmodule