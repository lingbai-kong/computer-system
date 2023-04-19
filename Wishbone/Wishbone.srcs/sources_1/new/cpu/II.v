`timescale 1ns / 1ps
//2021.5.15 ĞŞÕı´íÎó
module ii(
    input [3:0] a,
    input [25:0] b,
    output [31:0] r
    );
    assign r = {a, b, 2'b00};
endmodule