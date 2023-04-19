`timescale 1ns/1ps
module div(
    input [31:0]s_dividend, //被除数
    input [31:0]s_divisor,  //除数
    output [31:0]s_q,       //商
    output [31:0]s_r        //余数
);
    wire [31:0]u_dividend;
    wire [31:0]u_divisor;
    wire [31:0]u_q;
    wire [31:0]u_r;
    complement32 c_dividend(s_dividend[31],s_dividend,u_dividend);
    complement32 c_divisor(s_divisor[31],s_divisor,u_divisor);
    divu divison_unit(u_dividend,u_divisor,u_q,u_r);
    wire s_same;
    assign s_same = ~(s_dividend[31] ^ s_divisor[31]);
    complement32 c_q(~s_same,u_q,s_q);
    complement32 c_r(s_dividend[31],u_r,s_r);
endmodule

module divu(
    input [31:0]dividend,   //被除数
    input [31:0]divisor,    //除数
    output [31:0]q,         //商
    output [31:0]r          //余数
);
    wire [63:0] answer0;
    wire [63:0] answer1;
    wire [63:0] next1_answer1;
    wire [63:0] next2_answer1;
    wire [63:0] answer2;
    wire [63:0] next1_answer2;
    wire [63:0] next2_answer2;
    wire [63:0] answer3;
    wire [63:0] next1_answer3;
    wire [63:0] next2_answer3;
    wire [63:0] answer4;
    wire [63:0] next1_answer4;
    wire [63:0] next2_answer4;
    wire [63:0] answer5;
    wire [63:0] next1_answer5;
    wire [63:0] next2_answer5;
    wire [63:0] answer6;
    wire [63:0] next1_answer6;
    wire [63:0] next2_answer6;
    wire [63:0] answer7;
    wire [63:0] next1_answer7;
    wire [63:0] next2_answer7;
    wire [63:0] answer8;
    wire [63:0] next1_answer8;
    wire [63:0] next2_answer8;
    wire [63:0] answer9;
    wire [63:0] next1_answer9;
    wire [63:0] next2_answer9;
    wire [63:0] answer10;
    wire [63:0] next1_answer10;
    wire [63:0] next2_answer10;
    wire [63:0] answer11;
    wire [63:0] next1_answer11;
    wire [63:0] next2_answer11;
    wire [63:0] answer12;
    wire [63:0] next1_answer12;
    wire [63:0] next2_answer12;
    wire [63:0] answer13;
    wire [63:0] next1_answer13;
    wire [63:0] next2_answer13;
    wire [63:0] answer14;
    wire [63:0] next1_answer14;
    wire [63:0] next2_answer14;
    wire [63:0] answer15;
    wire [63:0] next1_answer15;
    wire [63:0] next2_answer15;
    wire [63:0] answer16;
    wire [63:0] next1_answer16;
    wire [63:0] next2_answer16;
    wire [63:0] answer17;
    wire [63:0] next1_answer17;
    wire [63:0] next2_answer17;
    wire [63:0] answer18;
    wire [63:0] next1_answer18;
    wire [63:0] next2_answer18;
    wire [63:0] answer19;
    wire [63:0] next1_answer19;
    wire [63:0] next2_answer19;
    wire [63:0] answer20;
    wire [63:0] next1_answer20;
    wire [63:0] next2_answer20;
    wire [63:0] answer21;
    wire [63:0] next1_answer21;
    wire [63:0] next2_answer21;
    wire [63:0] answer22;
    wire [63:0] next1_answer22;
    wire [63:0] next2_answer22;
    wire [63:0] answer23;
    wire [63:0] next1_answer23;
    wire [63:0] next2_answer23;
    wire [63:0] answer24;
    wire [63:0] next1_answer24;
    wire [63:0] next2_answer24;
    wire [63:0] answer25;
    wire [63:0] next1_answer25;
    wire [63:0] next2_answer25;
    wire [63:0] answer26;
    wire [63:0] next1_answer26;
    wire [63:0] next2_answer26;
    wire [63:0] answer27;
    wire [63:0] next1_answer27;
    wire [63:0] next2_answer27;
    wire [63:0] answer28;
    wire [63:0] next1_answer28;
    wire [63:0] next2_answer28;
    wire [63:0] answer29;
    wire [63:0] next1_answer29;
    wire [63:0] next2_answer29;
    wire [63:0] answer30;
    wire [63:0] next1_answer30;
    wire [63:0] next2_answer30;
    wire [63:0] answer31;
    wire [63:0] next1_answer31;
    wire [63:0] next2_answer31;
    wire [63:0] answer32;
    wire [63:0] next1_answer32;
    wire [63:0] next2_answer32;
    assign answer0 = {32'h00000000,dividend};
    assign next1_answer1 = {answer0[62:0],1'b0};
    assign next2_answer1 = next1_answer1 - {divisor[31:0],32'h00000000} + 1;
    assign answer1 = next1_answer1[63:32] >= divisor? next2_answer1:next1_answer1;
    assign next1_answer2 = {answer1[62:0],1'b0};
    assign next2_answer2 = next1_answer2 - {divisor[31:0],32'h00000000} + 1;
    assign answer2 = next1_answer2[63:32] >= divisor? next2_answer2:next1_answer2;
    assign next1_answer3 = {answer2[62:0],1'b0};
    assign next2_answer3 = next1_answer3 - {divisor[31:0],32'h00000000} + 1;
    assign answer3 = next1_answer3[63:32] >= divisor? next2_answer3:next1_answer3;
    assign next1_answer4 = {answer3[62:0],1'b0};
    assign next2_answer4 = next1_answer4 - {divisor[31:0],32'h00000000} + 1;
    assign answer4 = next1_answer4[63:32] >= divisor? next2_answer4:next1_answer4;
    assign next1_answer5 = {answer4[62:0],1'b0};
    assign next2_answer5 = next1_answer5 - {divisor[31:0],32'h00000000} + 1;
    assign answer5 = next1_answer5[63:32] >= divisor? next2_answer5:next1_answer5;
    assign next1_answer6 = {answer5[62:0],1'b0};
    assign next2_answer6 = next1_answer6 - {divisor[31:0],32'h00000000} + 1;
    assign answer6 = next1_answer6[63:32] >= divisor? next2_answer6:next1_answer6;
    assign next1_answer7 = {answer6[62:0],1'b0};
    assign next2_answer7 = next1_answer7 - {divisor[31:0],32'h00000000} + 1;
    assign answer7 = next1_answer7[63:32] >= divisor? next2_answer7:next1_answer7;
    assign next1_answer8 = {answer7[62:0],1'b0};
    assign next2_answer8 = next1_answer8 - {divisor[31:0],32'h00000000} + 1;
    assign answer8 = next1_answer8[63:32] >= divisor? next2_answer8:next1_answer8;
    assign next1_answer9 = {answer8[62:0],1'b0};
    assign next2_answer9 = next1_answer9 - {divisor[31:0],32'h00000000} + 1;
    assign answer9 = next1_answer9[63:32] >= divisor? next2_answer9:next1_answer9;
    assign next1_answer10 = {answer9[62:0],1'b0};
    assign next2_answer10 = next1_answer10 - {divisor[31:0],32'h00000000} + 1;
    assign answer10 = next1_answer10[63:32] >= divisor? next2_answer10:next1_answer10;
    assign next1_answer11 = {answer10[62:0],1'b0};
    assign next2_answer11 = next1_answer11 - {divisor[31:0],32'h00000000} + 1;
    assign answer11 = next1_answer11[63:32] >= divisor? next2_answer11:next1_answer11;
    assign next1_answer12 = {answer11[62:0],1'b0};
    assign next2_answer12 = next1_answer12 - {divisor[31:0],32'h00000000} + 1;
    assign answer12 = next1_answer12[63:32] >= divisor? next2_answer12:next1_answer12;
    assign next1_answer13 = {answer12[62:0],1'b0};
    assign next2_answer13 = next1_answer13 - {divisor[31:0],32'h00000000} + 1;
    assign answer13 = next1_answer13[63:32] >= divisor? next2_answer13:next1_answer13;
    assign next1_answer14 = {answer13[62:0],1'b0};
    assign next2_answer14 = next1_answer14 - {divisor[31:0],32'h00000000} + 1;
    assign answer14 = next1_answer14[63:32] >= divisor? next2_answer14:next1_answer14;
    assign next1_answer15 = {answer14[62:0],1'b0};
    assign next2_answer15 = next1_answer15 - {divisor[31:0],32'h00000000} + 1;
    assign answer15 = next1_answer15[63:32] >= divisor? next2_answer15:next1_answer15;
    assign next1_answer16 = {answer15[62:0],1'b0};
    assign next2_answer16 = next1_answer16 - {divisor[31:0],32'h00000000} + 1;
    assign answer16 = next1_answer16[63:32] >= divisor? next2_answer16:next1_answer16;
    assign next1_answer17 = {answer16[62:0],1'b0};
    assign next2_answer17 = next1_answer17 - {divisor[31:0],32'h00000000} + 1;
    assign answer17 = next1_answer17[63:32] >= divisor? next2_answer17:next1_answer17;
    assign next1_answer18 = {answer17[62:0],1'b0};
    assign next2_answer18 = next1_answer18 - {divisor[31:0],32'h00000000} + 1;
    assign answer18 = next1_answer18[63:32] >= divisor? next2_answer18:next1_answer18;
    assign next1_answer19 = {answer18[62:0],1'b0};
    assign next2_answer19 = next1_answer19 - {divisor[31:0],32'h00000000} + 1;
    assign answer19 = next1_answer19[63:32] >= divisor? next2_answer19:next1_answer19;
    assign next1_answer20 = {answer19[62:0],1'b0};
    assign next2_answer20 = next1_answer20 - {divisor[31:0],32'h00000000} + 1;
    assign answer20 = next1_answer20[63:32] >= divisor? next2_answer20:next1_answer20;
    assign next1_answer21 = {answer20[62:0],1'b0};
    assign next2_answer21 = next1_answer21 - {divisor[31:0],32'h00000000} + 1;
    assign answer21 = next1_answer21[63:32] >= divisor? next2_answer21:next1_answer21;
    assign next1_answer22 = {answer21[62:0],1'b0};
    assign next2_answer22 = next1_answer22 - {divisor[31:0],32'h00000000} + 1;
    assign answer22 = next1_answer22[63:32] >= divisor? next2_answer22:next1_answer22;
    assign next1_answer23 = {answer22[62:0],1'b0};
    assign next2_answer23 = next1_answer23 - {divisor[31:0],32'h00000000} + 1;
    assign answer23 = next1_answer23[63:32] >= divisor? next2_answer23:next1_answer23;
    assign next1_answer24 = {answer23[62:0],1'b0};
    assign next2_answer24 = next1_answer24 - {divisor[31:0],32'h00000000} + 1;
    assign answer24 = next1_answer24[63:32] >= divisor? next2_answer24:next1_answer24;
    assign next1_answer25 = {answer24[62:0],1'b0};
    assign next2_answer25 = next1_answer25 - {divisor[31:0],32'h00000000} + 1;
    assign answer25 = next1_answer25[63:32] >= divisor? next2_answer25:next1_answer25;
    assign next1_answer26 = {answer25[62:0],1'b0};
    assign next2_answer26 = next1_answer26 - {divisor[31:0],32'h00000000} + 1;
    assign answer26 = next1_answer26[63:32] >= divisor? next2_answer26:next1_answer26;
    assign next1_answer27 = {answer26[62:0],1'b0};
    assign next2_answer27 = next1_answer27 - {divisor[31:0],32'h00000000} + 1;
    assign answer27 = next1_answer27[63:32] >= divisor? next2_answer27:next1_answer27;
    assign next1_answer28 = {answer27[62:0],1'b0};
    assign next2_answer28 = next1_answer28 - {divisor[31:0],32'h00000000} + 1;
    assign answer28 = next1_answer28[63:32] >= divisor? next2_answer28:next1_answer28;
    assign next1_answer29 = {answer28[62:0],1'b0};
    assign next2_answer29 = next1_answer29 - {divisor[31:0],32'h00000000} + 1;
    assign answer29 = next1_answer29[63:32] >= divisor? next2_answer29:next1_answer29;
    assign next1_answer30 = {answer29[62:0],1'b0};
    assign next2_answer30 = next1_answer30 - {divisor[31:0],32'h00000000} + 1;
    assign answer30 = next1_answer30[63:32] >= divisor? next2_answer30:next1_answer30;
    assign next1_answer31 = {answer30[62:0],1'b0};
    assign next2_answer31 = next1_answer31 - {divisor[31:0],32'h00000000} + 1;
    assign answer31 = next1_answer31[63:32] >= divisor? next2_answer31:next1_answer31;
    assign next1_answer32 = {answer31[62:0],1'b0};
    assign next2_answer32 = next1_answer32 - {divisor[31:0],32'h00000000} + 1;
    assign answer32 = next1_answer32[63:32] >= divisor? next2_answer32:next1_answer32;
    assign q = answer32[31:0];
    assign r = answer32[63:32];
endmodule
//CODE GENERATOR WITH PYTHON
//print("wire [63:0] answer0;")
//for i in range(1,33):
//    print("wire [63:0] answer"+str(i)+";")
//    print("wire [63:0] next1_answer"+str(i)+";")
//    print("wire [63:0] next2_answer"+str(i)+";")
//print("assign answer0 = {32'h00000000,dividend};")
//for i in range(1,33):
//    print("assign next1_answer"+str(i)+" = {answer"+str(i-1)+"[62:0],1'b0};")
//    print("assign next2_answer"+str(i)+" = next1_answer"+str(i)+" - {divisor[31:0],32'h00000000} + 1;")
//    print("assign answer"+str(i)+" = next1_answer"+str(i)+"[63:32] >= divisor? next2_answer"+str(i)+":next1_answer"+str(i)+";")
//print("assign q = answer32[31:0];")
//print("assign r = answer32[63:32];")