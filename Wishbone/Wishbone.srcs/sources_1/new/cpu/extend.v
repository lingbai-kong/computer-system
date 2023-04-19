`timescale 1ns/1ps
module extend1(
    input a,
    output [31:0] b
);
    assign b = {31'b0,a};
endmodule
module extend5(
    input [4:0] a,
    output [31:0] b
);
    assign b = {27'b0,a};
endmodule
module extend8(
    input [7:0] a,
    input sign,
    output [31:0] b
);
    assign b = sign ? {{24{a[7]}},a} : {24'b0,a};
endmodule
module extend16(
    input [15:0] a,
    input sign,             //1±íÊ¾ÓÐ·ûºÅ
    output [31:0] b
);
    assign b = sign ? {{16{a[15]}},a} : {16'b0,a};
endmodule
module extend18 (
    input [15:0] a,
    output [31:0] b
);
    assign b = {{(32 - 18){a[15]}},a,2'b00};
endmodule