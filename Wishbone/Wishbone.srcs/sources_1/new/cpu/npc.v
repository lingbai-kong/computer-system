`timescale 1ns / 1ps
module npc(
    input [31:0] a,
    output [31:0] r
    );
    assign r = a+4;
endmodule