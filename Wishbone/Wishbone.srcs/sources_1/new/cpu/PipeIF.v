`timescale 1ns/1ps
module PipeIF(
    input [31:0] pc,
    input [31:0] rs,
    input [31:0] ext18,
    input [31:0] II,
    input [31:0] epc,
    input [7:0] pcmux,
    input branch_predict_fail,
    input [31:0] branch_fail_pc,
    output [31:0] pc4,
    output [31:0] npc
);
    wire [31:0] mux_npc;
    npc NPC(
        .a(pc),
        .r(pc4)
    );
    mux_pc MUX_PC(
        .pc4(pc4),
        .rs(rs),
        .ext18(ext18),
        .II(II),
        .epc(epc),
        .mux(pcmux),
        .out(mux_npc)
    );
    assign npc=branch_predict_fail? branch_fail_pc:mux_npc;
endmodule