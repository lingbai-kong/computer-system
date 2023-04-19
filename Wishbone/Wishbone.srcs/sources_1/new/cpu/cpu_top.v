`include "cpu_defines.v"
module cpu_top(
    input CLK100MHZ,
    input rst,
    
    input [31:0] im_idata,
	output [31:0] im_odata,
	output [31:0] im_addr,
	output [3:0] im_sel, 
	output im_we,
	output reg im_cyc,
	output reg im_stb, 
	input im_ack,
	input im_err,
	input im_rty,
	
	input [31:0] dm_idata,
	output [31:0] dm_odata,
	output [31:0] dm_addr,
	output [3:0] dm_sel, 
	output reg dm_we,
	output reg dm_cyc,
	output reg dm_stb, 
	input dm_ack,
	input dm_err,
	input dm_rty,
	
	input [5:0] int_i,
	output timer_int,
	
	output [31:0] debug,
	output stall,
	output [3:0] st
);
    wire CLK5MHZ;
    //clk_wiz_5MHZ wiz(.clk_in(CLK100MHZ),.clk_out(CLK5MHZ));
//    wire CLK1;
//    wire CLK2;
    time_divider#(50000) Divider_slow1 (.I_CLK(CLK100MHZ),.rst(rst),.O_CLK(CLK5MHZ));
    //time_divider#(5000) Divider_slow2 (.I_CLK(CLK100MHZ),.rst(rst),.O_CLK(CLK2));
    
    reg iCPU_stall;
    wire oCPU_im_ena;
    wire oCPU_im_we;//useless
    wire [31:0] oCPU_im_addr;
    reg [31:0] iCPU_im_dout;
    
    wire oCPU_dm_ena;
    wire oCPU_dm_we;
    wire [31:0] oCPU_dm_addr;
    wire [3:0] oCPU_dm_sel;
    reg [31:0] iCPU_dm_dout;
    wire [31:0] oCPU_dm_din;
    cpu CPU(
        .clk(CLK5MHZ),
        .rst(rst),
        .stall(iCPU_stall),
        
        .IM_ena(oCPU_im_ena),
        .IM_w(oCPU_im_we),
        .pc(oCPU_im_addr),
        .inst(iCPU_im_dout),
        
        .DM_ena(oCPU_dm_ena),
        .DM_w(oCPU_dm_we),
        .addr(oCPU_dm_addr),
        .sel(oCPU_dm_sel),
        .rdata(iCPU_dm_dout),
        .wdata(oCPU_dm_din),
        
        .int_i(int_i),
        .timer_int(timer_int)
    );
    
    parameter INIT=4'd8,iIDLE=4'd0,iREAD=4'd1,WRITE=4'd2,OK1=4'd3,OK2=4'd4,OK3=4'd5,dIDLE=4'd6,dREAD=4'd7;
    reg [3:0] state;
    parameter startLoop=16'd256;
    reg [16:0] counter;    
    always@(posedge CLK100MHZ or posedge rst)
    begin
        if(rst)
        begin
            im_cyc<=1'b0;
            im_stb<=1'b0;
            iCPU_im_dout<=32'b0;
            
            dm_we<=1'b0;
            dm_cyc<=1'b0;
            dm_stb<=1'b0;
            iCPU_dm_dout<=32'b0;
            
            iCPU_stall<=1'b1;
            state<=INIT;
            
            counter<=16'b0;
        end
        else
        begin
            case(state)
            INIT:begin
                if(counter>=startLoop)
                begin
                    state<=iIDLE;
                end
                else
                begin
                    counter<=counter+16'd1;
                    state<=INIT;
                end
            end
            iIDLE:begin
                im_cyc<=1'b0;
                im_stb<=1'b0;
                iCPU_stall<=1'b1;
                state<=iREAD;
            end
            iREAD:begin
                im_cyc<=1'b1;
                im_stb<=1'b1;
                if(im_ack)
                begin
                    iCPU_im_dout<=im_idata;
                    state<=dIDLE;
                end
                else
                begin
                    state<=iREAD;
                end
            end
            dIDLE:begin
                im_cyc<=1'b0;
                im_stb<=1'b0;
                dm_cyc<=1'b0;
                dm_stb<=1'b0;
                if(oCPU_dm_ena&&~oCPU_dm_we)
                begin
                    dm_we<=1'b0;
                    state<=dREAD;
                end
                else if(oCPU_dm_ena&&oCPU_dm_we)
                begin
                    dm_we<=1'b1;
                    state<=WRITE;
                end
                else
                begin
                    dm_we<=1'b0;
                    state<=OK1;
                end
            end
            dREAD:begin
                dm_cyc<=1'b1;
                dm_stb<=1'b1;
                if(dm_ack)
                begin
                    iCPU_dm_dout<=dm_idata;
                    state<=OK1;
                end
                else
                begin
                    state<=dREAD;
                end
            end
            WRITE:begin
                dm_cyc<=1'b1;
                dm_stb<=1'b1;
                if(dm_ack)
                begin
                    state<=OK1;
                end
                else
                begin
                    state<=WRITE;
                end
            end
            OK1:begin
                im_cyc<=1'b0;
                im_stb<=1'b0;
				dm_cyc<=1'b0;
                dm_stb<=1'b0;
                if(~CLK5MHZ)
                begin
                    iCPU_stall<=1'b0;
                    state<=OK2;
                end
                else
                begin
                    state<=OK1;
                end
            end
            OK2:begin
                if(CLK5MHZ)
                begin
                    state<=OK3;
                end
                else
                begin
                    state<=OK2;
                end
            end
            OK3:begin
                if(~CLK5MHZ)
                begin
                    state<=iIDLE;
                end
                else
                begin
                    state<=OK3;
                end
            end
            endcase
        end
    end
    assign im_odata=32'b0;
    assign im_addr=oCPU_im_addr+`IMEM_addr_corr;
    assign im_sel=4'b1111;
    assign im_we=1'b0;
    assign dm_addr=oCPU_dm_addr-`DMEM_addr_corr;
    assign dm_odata=oCPU_dm_din;
    assign dm_sel=oCPU_dm_sel;
    assign debug=iCPU_im_dout;
    assign stall=iCPU_stall;
    assign st=state;
endmodule