`timescale 1ns/1ps
module PipeEMreg(
    input clk,
    input rst,
    input stall,
    input DMEM_ena,
    input DMEM_wena,
    input [3:0] data_type,
    input CBW_sign,
    input CHW_sign,
    input mux_rf_DMEM,
    input [31:0] rf_rdata2,
    input rf_wena,
    input [4:0] rf_waddr,
    input hi_ena,
    input [31:0] hi_idata,
    input lo_ena,
    input [31:0] lo_idata,
    input [31:0] alu_out,
    input [31:0] exe_out,
    output reg D_DMEM_ena,
    output reg D_DMEM_wena,
    output reg [3:0] D_data_type, 
    output reg D_CBW_sign,
    output reg D_CHW_sign,
    output reg D_mux_rf_DMEM,
    output reg [31:0] D_rf_rdata2,
    output reg D_rf_wena,
    output reg [4:0] D_rf_waddr,
    output reg D_hi_ena,
    output reg [31:0] D_hi_idata,
    output reg D_lo_ena,
    output reg [31:0] D_lo_idata,
    output reg [31:0] D_alu_out,
    output reg [31:0] D_exe_out
);
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            D_DMEM_ena<=0;
            D_DMEM_wena<=0;
            D_data_type<=4'b0;
            D_CBW_sign<=1'b0;
            D_CHW_sign<=1'b0;
            D_mux_rf_DMEM<=1'b0;
            D_rf_rdata2<=32'b0;
            D_rf_wena<=0;
            D_rf_waddr<=5'b0;
            D_hi_ena<=0;
            D_hi_idata<=32'b0;
            D_lo_ena<=0;
            D_lo_idata<=32'b0;
            D_alu_out<=32'b0;
            D_exe_out<=32'b0;
        end
        else if(~stall)
        begin
            D_DMEM_ena<=DMEM_ena;
            D_DMEM_wena<=DMEM_wena;
            D_data_type<=data_type;
            D_CBW_sign<=CBW_sign;
            D_CHW_sign<=CHW_sign;
            D_mux_rf_DMEM<=mux_rf_DMEM;
            D_rf_rdata2<=rf_rdata2;
            D_rf_wena<=rf_wena;
            D_rf_waddr<=rf_waddr;
            D_hi_ena<=hi_ena;
            D_hi_idata<=hi_idata;
            D_lo_ena<=lo_ena;
            D_lo_idata<=lo_idata;
            D_alu_out<=alu_out;
            D_exe_out<=exe_out;
        end
    end
endmodule