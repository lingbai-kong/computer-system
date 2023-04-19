`timescale 1ns/1ps
module PipeMWreg(
    input clk,
    input rst,
    input stall,
    input mux_rf_DMEM,
    input rf_wena,
    input [4:0] rf_waddr,
    input hi_ena,
    input [31:0] hi_idata,
    input lo_ena,
    input [31:0] lo_idata,
    input [31:0] exe_out,
    input [31:0] DMEM_rdata,
    output reg D_mux_rf_DMEM,
    output reg D_rf_wena,
    output reg [4:0] D_rf_waddr,
    output reg D_hi_ena,
    output reg [31:0] D_hi_idata,
    output reg D_lo_ena,
    output reg [31:0] D_lo_idata,
    output reg [31:0] D_exe_out,
    output reg [31:0] D_DMEM_rdata
);
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            D_mux_rf_DMEM<=1'b0;
            D_rf_wena<=0;
            D_rf_waddr<=5'b0;
            D_hi_ena<=0;
            D_hi_idata<=32'b0;
            D_lo_ena<=0;
            D_lo_idata<=32'b0;
            D_exe_out<=32'b0;
            D_DMEM_rdata<=32'b0;
        end
        else if(~stall)
        begin
            D_mux_rf_DMEM<=mux_rf_DMEM;
            D_rf_wena<=rf_wena;
            D_rf_waddr<=rf_waddr;
            D_hi_ena<=hi_ena;
            D_hi_idata<=hi_idata;
            D_lo_ena<=lo_ena;
            D_lo_idata<=lo_idata;
            D_exe_out<=exe_out;
            D_DMEM_rdata<=DMEM_rdata;
        end
    end
endmodule