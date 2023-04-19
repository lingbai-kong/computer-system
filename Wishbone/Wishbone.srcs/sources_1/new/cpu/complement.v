`timescale 1ns/1ps
module complement32(
    input sign,         //�������
    input [31:0] x,     //����Դ��
    output [31:0] y     //�������
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