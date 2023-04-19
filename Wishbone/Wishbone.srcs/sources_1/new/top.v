module top(
    input clk,
    input rst,
    input [15:0] sw,
    output [15:0] led,
    
    output ddr2_ck_p,
    output ddr2_ck_n,
    output ddr2_cke,
    output ddr2_cs_n,
    output ddr2_ras_n,
    output ddr2_cas_n,
    output ddr2_we_n,
    output [1:0] ddr2_dm,
    output [2:0] ddr2_ba,
    output [12:0] ddr2_addr,
    inout [15:0] ddr2_dq,
    inout [1:0] ddr2_dqs_p,
    inout [1:0] ddr2_dqs_n,
    output ddr2_odt,
    
    output TXD,
    input RXD,
    input CTS,
    output RTS,
    
    input SD_CD,
    output SD_RESET, 
    output SD_SCK, 
    output SD_CMD, 
    inout [3:0] SD_DAT,
    
    output [7:0] o_seg,
	output [7:0] o_sel
);  
    wire CLK200MHZ;
    wire CLK200MHZlocked;
    clk_wiz_200MHZ wiz200mhz(.clk_in(clk),.reset(rst),.clk_out(CLK200MHZ),.locked(CLK200MHZlocked));
    wire CLK25MHZ;
    wire CLK25MHZlocked;
    clk_wiz_25MHZ wiz25mhz(.clk_in(clk),.reset(rst),.clk_out(CLK25MHZ),.locked(CLK25MHZlocked));
    
    wire [31:0] im_data_i; 
    wire [31:0] im_data_o;
    wire [31:0] im_addr_i;
    wire [3:0] im_sel_i;
    wire im_we_i;
    wire im_cyc_i;
	wire im_stb_i;
	wire im_ack_o;
	wire im_err_o;
	wire im_rty_o;
	
	wire [31:0] dm_data_i; 
    wire [31:0] dm_data_o;
    wire [31:0] dm_addr_i;
    wire [3:0] dm_sel_i;
    wire dm_we_i;
    wire dm_cyc_i;
	wire dm_stb_i;
	wire dm_ack_o;
	wire dm_err_o;
	wire dm_rty_o;
    
    wire [5:0] int_i;
    wire timer_int;
    wire [31:0] debug;
    wire stall;
    wire [3:0] cpu_state;
    cpu_top CPU(
        .CLK100MHZ(clk),
        .rst(rst),
        
        .im_idata(im_data_o),
        .im_odata(im_data_i),
        .im_addr(im_addr_i),
        .im_sel(im_sel_i), 
        .im_we(im_we_i),
        .im_cyc(im_cyc_i),
        .im_stb(im_stb_i), 
        .im_ack(im_ack_o),
        .im_err(im_err_o),
        .im_rty(im_rty_o),
        
        .dm_idata(dm_data_o),
        .dm_odata(dm_data_i),
        .dm_addr(dm_addr_i),
        .dm_sel(dm_sel_i), 
        .dm_we(dm_we_i),
        .dm_cyc(dm_cyc_i),
        .dm_stb(dm_stb_i), 
        .dm_ack(dm_ack_o),
        .dm_err(dm_err_o),
        .dm_rty(dm_rty_o),
        
        .int_i(int_i),
        .timer_int(timer_int),
        .debug(debug),
        .stall(stall),
        .st(cpu_state)
    );
    
    wire [31:0] ddr_odata;
    wire [31:0] ddr_idata;
    wire [31:0] ddr_addr;
    wire [3:0] ddr_sel;
    wire ddr_we;
    wire ddr_cyc;
    wire ddr_stb;
    wire ddr_ack;
    wire ddr_err;
    wire ddr_rty;
    
    wire ddr_rdy;
    assign ddr_rdy=1;
    wire [7:0] ddr_state;
    ddr2_func_controller DDR2(
        .CLK100MHZ(clk), 
        .rst(rst),
        .CLK200MHZ(CLK200MHZ),
        .locked(CLK200MHZlocked),
        
        .ddr2_ck_p(ddr2_ck_p),
		.ddr2_ck_n(ddr2_ck_n),
		.ddr2_cke(ddr2_cke),
		.ddr2_cs_n(ddr2_cs_n),
		.ddr2_ras_n(ddr2_ras_n),
		.ddr2_cas_n(ddr2_cas_n),
		.ddr2_we_n(ddr2_we_n),
		.ddr2_dm(ddr2_dm),
		.ddr2_ba(ddr2_ba),
		.ddr2_addr(ddr2_addr),
		.ddr2_dq(ddr2_dq),
		.ddr2_dqs_p(ddr2_dqs_p),
		.ddr2_dqs_n(ddr2_dqs_n),
		.ddr2_odt(ddr2_odt),
		
		.s_odata(ddr_odata),
        .s_idata(ddr_idata),
        .s_addr(ddr_addr),
        .s_sel(ddr_sel), 
        .s_we(ddr_we),
        .s_cyc(ddr_cyc),
        .s_stb(ddr_stb), 
        .s_ack(ddr_ack),
        .s_err(ddr_err),
        .s_rty(ddr_rty),
        
        .st(ddr_state)
    );
    wire [31:0] uart_odata;
    wire [31:0] uart_idata;
    wire [31:0] uart_addr;
    wire [3:0] uart_sel;
    wire uart_we;
    wire uart_cyc;
    wire uart_stb;
    wire uart_ack;
    wire uart_err;//useless
    wire uart_rty;//useless
    wire uart_int;
    
    wire DTR;//UART支持硬流控 useless
    wire DSR;//UART支持硬流控 useless
    wire RI;
    wire DCD;
    uart_top UART(
        .wb_clk_i(clk),
        .wb_rst_i(rst),
        
        .wb_adr_i(uart_addr[4:0]),
        .wb_dat_i(uart_idata),
        .wb_dat_o(uart_odata),
        .wb_we_i(uart_we),
        .wb_stb_i(uart_stb),
        .wb_cyc_i(uart_cyc),
        .wb_sel_i(uart_sel),
        .wb_ack_o(uart_ack),
        .int_o(uart_int),
        
        .stx_pad_o(TXD),
        .srx_pad_i(RXD),
        .rts_pad_o(),
        .cts_pad_i(1'b0),
        .dtr_pad_o(),
        .dsr_pad_i(1'b0),
        .ri_pad_i(1'b0),
        .dcd_pad_i(1'b0)
    );
    
    wire [31:0] gpio_odata;
    wire [31:0] gpio_idata;
    wire [31:0] gpio_addr;
    wire [3:0] gpio_sel;
    wire gpio_we;
    wire gpio_cyc;
    wire gpio_stb;
    wire gpio_ack;
    wire gpio_err;
    wire gpio_rty;//useless
    wire gpio_int;
    
    wire [31:0] io_in;
    assign io_in[16]=ddr_rdy;
    assign io_in[15:0]=sw;
    wire [31:0] io_out;
    wire [31:0] io_en;
    gpio_top GPIO(
        .wb_clk_i(clk),
        .wb_rst_i(rst),
        .wb_cyc_i(gpio_cyc),
        .wb_adr_i(gpio_addr[7:0]),
        .wb_dat_i(gpio_idata),
        .wb_sel_i(gpio_sel),
        .wb_we_i(gpio_we),
        .wb_stb_i(gpio_stb),
        .wb_dat_o(gpio_odata),
        .wb_ack_o(gpio_ack),
        .wb_err_o(gpio_err), 
        .wb_inta_o(gpio_int),
        
        .ext_pad_i(io_in),
        .ext_pad_o(io_out),
        .ext_padoe_o(io_en)
    );
    
    wire [31:0] sd_odata;
    wire [31:0] sd_idata;
    wire [31:0] sd_addr;
    wire [3:0] sd_sel;
    wire sd_we;
    wire sd_cyc;
    wire sd_stb;
    wire sd_ack;
    wire sd_err;
    wire sd_rty;
    
    wire [3:0] sd_state;
    wire [31:0] sd_byte_counter;
    wire [4:0] sd_signal_state;
    sd_func_controller SD(
        .CLK100MHZ(clk), 
        .rst(rst),
        .CLK25MHZ(CLK25MHZ),
        .locked(CLK25MHZlocked),
        
        .SD_CD(SD_CD),
        .SD_RESET(SD_RESET), 
        .SD_SCK(SD_SCK), 
        .SD_CMD(SD_CMD), 
        .SD_DAT(SD_DAT), 
        
        .s_odata(sd_odata),
        .s_idata(sd_idata),
        .s_addr(sd_addr),
        .s_sel(sd_sel), 
        .s_we(sd_we),
        .s_cyc(sd_cyc),
        .s_stb(sd_stb), 
        .s_ack(sd_ack),
        .s_err(sd_err),
        .s_rty(sd_rty),
        
        .st(sd_state),
        .bt(sd_byte_counter),
        .signal_controller_status(sd_signal_state),
        .read(led[3])
    );

    wb_conmax_top WISHBONE(
	   .clk_i(clk),
	   .rst_i(rst),
	   
	   .m0_data_i(im_data_i),
	   .m0_data_o(im_data_o),
	   .m0_addr_i(im_addr_i),
	   .m0_sel_i(im_sel_i),
	   .m0_we_i(im_we_i),
	   .m0_cyc_i(im_cyc_i),
	   .m0_stb_i(im_stb_i),
	   .m0_ack_o(im_ack_o),
	   .m0_err_o(im_err_o),
	   .m0_rty_o(im_rty_o),
	   
	   .m1_data_i(dm_data_i),
	   .m1_data_o(dm_data_o),
	   .m1_addr_i(dm_addr_i),
	   .m1_sel_i(dm_sel_i),
	   .m1_we_i(dm_we_i),
	   .m1_cyc_i(dm_cyc_i),
	   .m1_stb_i(dm_stb_i),
	   .m1_ack_o(dm_ack_o),
	   .m1_err_o(dm_err_o),
	   .m1_rty_o(dm_rty_o),
	   
	   .s0_data_i(ddr_odata),
	   .s0_data_o(ddr_idata),
	   .s0_addr_o(ddr_addr),
	   .s0_sel_o(ddr_sel),
	   .s0_we_o(ddr_we),
	   .s0_cyc_o(ddr_cyc),
	   .s0_stb_o(ddr_stb),
	   .s0_ack_i(ddr_ack),
	   .s0_err_i(ddr_err),
	   .s0_rty_i(ddr_rty),
	   
	   .s1_data_i(uart_odata),
	   .s1_data_o(uart_idata),
	   .s1_addr_o(uart_addr),
	   .s1_sel_o(uart_sel),
	   .s1_we_o(uart_we),
	   .s1_cyc_o(uart_cyc),
	   .s1_stb_o(uart_stb),
	   .s1_ack_i(uart_ack),
	   .s1_err_i(uart_err),
	   .s1_rty_i(uart_rty),
	   
	   .s2_data_i(gpio_odata),
	   .s2_data_o(gpio_idata),
	   .s2_addr_o(gpio_addr),
	   .s2_sel_o(gpio_sel),
	   .s2_we_o(gpio_we),
	   .s2_cyc_o(gpio_cyc),
	   .s2_stb_o(gpio_stb),
	   .s2_ack_i(gpio_ack),
	   .s2_err_i(gpio_err),
	   .s2_rty_i(gpio_rty),//useless
	   
	   .s3_data_i(sd_odata),
	   .s3_data_o(sd_idata),
	   .s3_addr_o(sd_addr),
	   .s3_sel_o(sd_sel),
	   .s3_we_o(sd_we),
	   .s3_cyc_o(sd_cyc),
	   .s3_stb_o(sd_stb),
	   .s3_ack_i(sd_ack),
	   .s3_err_i(sd_err),
	   .s3_rty_i(sd_rty)
	);
	reg [31:0] show_data;
	seg7x16 SEG(
        .clk(clk),
        .reset(rst),
        .cs(1),
        .i_data(show_data),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );
    always@(*)
    begin
        case(sw[3:0])
        4'd0:show_data<=sd_odata;
        4'd1:show_data<=im_data_o;
        4'd2:show_data<=im_addr_i;
        4'd3:begin
            if(dm_cyc_i&&dm_stb_i&&dm_addr_i==32'h0)
            show_data<=dm_data_i;
        end
        4'd4:show_data<=cpu_state;
        4'd5:show_data<=ddr_state;
        4'd6:show_data<=sd_state;
        4'd7:show_data<=sd_byte_counter;
        4'd8:show_data<=sd_signal_state;
        4'd9:show_data<=dm_data_o;
        endcase
    end
    assign led[0]=im_ack_o;
    assign led[1]=dm_ack_o;
    assign led[2]=stall;
    assign led[15]=CLK200MHZlocked;
    assign led[14]=CLK25MHZlocked;
	assign m_data_i={28'hfff_ffff,sw[3:0]};
	assign m_addr_i={2'b00,sw[9:8],22'b0,sw[7:4],2'b0};
	assign m_sel_i=sw[13:10];
	assign m_we_i=sw[15];
	assign m_cyc_i=sw[14];
	assign m_stb_i=sw[14];

    assign int_i={3'b0,gpio_int,uart_int,timer_int};
endmodule