`timescale 1ns/1ps
module alu(
    input[31:0] a,
    input[31:0] b,
    input[3:0] aluc,
    output[31:0] r,
    output zero,
    output carry,
    output negative,
    output overflow
    );
    wire [0:5] c;
    wire [0:1] o;
    wire[31:0] t0;
    wire[31:0] t1;
    wire[31:0] t2;
    wire[31:0] t3;
    wire[31:0] t4;
    wire[31:0] t5;
    wire[31:0] t6;
    wire[31:0] t7;
    wire[31:0] t8;
    wire[31:0] t9;
    wire[31:0] t10;
    wire[31:0] t11;
    wire[31:0] t12;
    wire[31:0] t13;
    ADDU m0 (a,b,t0,c[0]);
    ADD m1 (a,b,t1,o[0]);
    SUBU m2 (a,b,t2,c[1]);
    SUB m3 (a,b,t3,o[1]);
    AND m4 (a,b,t4);
    OR m5 (a,b,t5);
    XOR m6 (a,b,t6);
    NOR m7 (a,b,t7);
    LUI m8 (a,b,t8);
    SLT m9 (a,b,t9);
    SLTU m10 (a,b,t10,c[2]);
    SRA m11 (a,b,t11,c[3]);
    SLLSLR m12 (a,b,t12,c[4]);
    SRL m13 (a,b,t13,c[5]);
    alu_selector m14(t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,aluc,c,o,r,carry,overflow);
    assign zero=((r==0)&&(aluc[3:1]!=3'b101))||((a==b)&&(aluc[3:1]==3'b101));
    assign negative=((r[31]==1)||(aluc==4'b1011)&&(r[0]==1));
endmodule
module ADDU(
    input [31:0] a,
    input [31:0] b,
    output[31:0] r,
    output carry
    );
    reg [32:0] t;
    always@(*)
    begin
        t<=a+b;
    end
    assign r=t[31:0];
    assign carry=t[32];
endmodule
module ADD(
    input signed [31:0] a,
    input signed [31:0] b,
    output reg signed [31:0] r,
    output overflow
    );
    always@(*)
    begin
       r<=a+b;
    end
    assign overflow=((a[31]==0)&&(b[31]==0)&&(r[31]==1))||((a[31]==1)&&(b[31]==1)&&(r[31]==0));
endmodule
module SUBU(
    input [31:0] a,
    input [31:0] b,
    output[31:0] r,
    output carry
    );
    assign r=a-b;
    assign carry=a<b;
endmodule
module SUB(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r,
    output overflow
    );
    reg [31:0] t;
    always@(*)
    begin
        t<=a-b;
    end
    assign r=t[31:0];
    assign overflow=((a[31]==0)&&(b[31]==1)&&(t[31]==1))||((a[31]==1)&&(b[31]==0)&&(t[31]==0));
endmodule
module AND(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=a&b;
endmodule
module OR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=a|b;
endmodule
module XOR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=a^b;
endmodule
module NOR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=~(a|b);
endmodule
module LUI(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r={b[15:0],16'b0};
endmodule
module SLT(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r
    );
    assign r=(a<b)? 1:0;
endmodule
module SLTU(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output carry
    );
    assign r=(a<b)? 1:0;
    assign carry=(a<b)? 1:0;
endmodule
module SRA(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r,
    output carry
    );
    integer i;
    always@(*) 
    begin
        i<=a-1;
    end
    assign r=b>>>a[4:0];
    assign carry=i<=31? b[i]:b[31];
endmodule
module SLLSLR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output carry
    );
    integer i;
    always@(*) 
    begin
        i<=a-1;
    end
    assign r=b<<a[4:0];
    assign carry=i<=31? b[31-i]:0;
endmodule
module SRL(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output carry
    );
    integer i;
    always@(*) 
    begin
        i<=a-1;
    end
    assign r=b>>a[4:0];
    assign carry=i<=31? b[i]:0;
endmodule
module alu_selector(
    input[31:0] t0,
    input[31:0] t1,
    input[31:0] t2,
    input[31:0] t3,
    input[31:0] t4,
    input[31:0] t5,
    input[31:0] t6,
    input[31:0] t7,
    input[31:0] t8,
    input[31:0] t9,
    input[31:0] t10,
    input[31:0] t11,
    input[31:0] t12,
    input[31:0] t13,
    input[3:0] aluc,
    input[0:5] c,
    input[0:1] o,
    output reg[31:0] r,
    output reg carry,
    output reg overflow
    );
    always@(*)
    begin
    casex(aluc)
        4'b0000:begin r<=t0;carry<=c[0];end
        4'b0010:begin r<=t1;overflow<=o[0];end
        4'b0001:begin r<=t2;carry<=c[1];end
        4'b0011:begin r<=t3;overflow<=o[1];end
        4'b0100:r<=t4;
        4'b0101:r<=t5;
        4'b0110:r<=t6;
        4'b0111:r<=t7;
        4'b100x:r<=t8;
        4'b1011:r<=t9;
        4'b1010:begin r<=t10;carry<=c[2];end
        4'b1100:begin r<=t11;carry<=c[3];end
        4'b111x:begin r<=t12;carry<=c[4];end
        4'b1101:begin r<=t13;carry<=c[5];end
        default:$display("Unspecified control signals");
    endcase
    end
endmodule