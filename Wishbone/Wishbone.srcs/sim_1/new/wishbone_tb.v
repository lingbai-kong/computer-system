`timescale 1ns/1ps
module wishbone_tb;
    reg clk;
    reg rst;
    
    reg [31:0] m_data_i; 
    wire [31:0] m_data_o;
    reg [31:0] m_addr_i;
    reg [3:0] m_sel_i;
    reg m_we_i;
    reg m_cyc_i;
	reg m_stb_i;
	wire m_ack_o;
	wire m_err_o;
	wire m_rty_o;
	
	reg[31:0] s_data_i;
	wire[31:0] s_data_o;
	wire[31:0] s_addr_o;
	wire[3:0] s_sel_o; 
	wire s_we_o;
	wire s_cyc_o;
	wire s_stb_o; 
	reg s_ack_i;
	wire s_err_i;
	wire s_rty_i;
	
	initial clk<=0;
	always #5 clk<=~clk;
	wb_conmax_top wb(
	   .clk_i(clk),
	   .rst_i(rst),
	   .m0_data_i(m_data_i),
	   .m0_data_o(m_data_o),
	   .m0_addr_i(m_addr_i),
	   .m0_sel_i(m_sel_i),
	   .m0_we_i(m_we_i),
	   .m0_cyc_i(m_cyc_i),
	   .m0_stb_i(m_stb_i),
	   .m0_ack_o(m_ack_o),
	   .m0_err_o(m_err_o),
	   .m0_rty_o(m_rty_o),
	   
	   .s2_data_i(s_data_i),
	   .s2_data_o(s_data_o),
	   .s2_addr_o(s_addr_o),
	   .s2_sel_o(s_sel_o),
	   .s2_we_o(s_we_o),
	   .s2_cyc_o(s_cyc_o),
	   .s2_stb_o(s_stb_o),
	   .s2_ack_i(s_ack_i),
	   .s2_err_i(s_err_i),
	   .s2_rty_i(s_rty_i)	   
	);
	initial
	begin
	   rst<=1;
	   #20;
	   rst<=0;
	   #10;
	   m_data_i<=32'h12345678;
	   m_addr_i<=32'h20000000;
	   m_sel_i<=4'b1111;
	   m_we_i<=1'b1;
	   m_cyc_i<=1'b1;
	   m_stb_i<=1'b1;
	   s_data_i<=32'h87654321;
	   #100;
	   s_ack_i<=1'b1;
	   #10;
	   m_cyc_i<=1'b0;
	end
endmodule