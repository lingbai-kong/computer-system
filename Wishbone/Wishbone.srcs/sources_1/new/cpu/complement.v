`timescale 1ns/1ps
module complement32(
    input sign,         //输入符号
    input [31:0] x,     //输入源码
    output [31:0] y     //输出补码
);
    assign y = sign? ((~x) + 1):x;
endmodule

module complement64(
    input sign,
    input [63:0] x,
    output [63:0] y
);
    assign y = sign? ((~x) + 1):x;
endmodule