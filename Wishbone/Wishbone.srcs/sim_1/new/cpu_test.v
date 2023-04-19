`timescale 1ns/1ps
module cpu_test;
    reg clk;
    reg rst;
    
    wire [31:0] im_data_i; 
    wire [31:0] im_data_o;
    wire [31:0] im_addr_i;
    wire [3:0] im_sel_i;
    wire im_we_i;
    wire im_cyc_i;
	wire im_stb_i;
	reg im_ack_o;
	reg im_err_o;
	reg im_rty_o;
	
	wire [31:0] dm_data_i; 
    reg [31:0] dm_data_o;
    wire [31:0] dm_addr_i;
    wire [3:0] dm_sel_i;
    wire dm_we_i;
    wire dm_cyc_i;
	wire dm_stb_i;
	reg dm_ack_o;
	reg dm_err_o;
	reg dm_rty_o;
    
    wire [5:0] int_i;
    wire timer_int;
    wire [31:0] debug;
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
        .debug(debug)
    );
    
    wire [31:0] trans_addr;
    
    dist_mem_gen_0 imem(.a(trans_addr[11:2]),.spo(im_data_o));
    
    initial clk<=0;
    always #5 clk<=~clk;
    
    initial
    begin
    rst<=1;
    im_ack_o<=0;
    im_err_o<=0;
    im_rty_o<=0;
    dm_data_o<=32'h64125810;
    dm_ack_o<=0;
    dm_err_o<=0;
    dm_rty_o<=0;
    #10;
    rst<=0;
    #100;
    end
    
    always
    begin
        #1000;
        if(im_cyc_i&im_stb_i)
        begin 
            im_ack_o<=1;
        end
        else
        begin
            im_ack_o<=0;
        end
    end
    
    always
    begin
        #1000;
        if(dm_cyc_i&dm_stb_i)
        begin
            dm_ack_o<=1;
        end
        else
        begin
            dm_ack_o<=0;
        end
    end
    
    assign trans_addr=im_addr_i-32'h00400000+32'h30000000;
endmodule