`timescale 1ns/1ps
module PipeWB(
    input mux_rf_DMEM,
    input [31:0] exe_out,
    input [31:0] DMEM_rdata,
    output [31:0] rf_wdata
);
    mux2_32 MUX_RF_DMEM(
        .a(exe_out),
        .b(DMEM_rdata),
        .choose(mux_rf_DMEM),
        .c(rf_wdata)
    );
endmodule