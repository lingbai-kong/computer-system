`timescale 1ns / 1ps
module pcreg#(parameter initvalue=32'h00000000)(
    input CLK,                  //下降沿有效
    input rst,                  //高电平有效
    input ena,
    input [31:0] data_in,
    output [31:0] data_out
);
    wire [31:0]un;
    Ansynchronous#(initvalue[31]) m31 (CLK,data_in[31],ena,~rst,data_out[31],un[31]);
    Ansynchronous#(initvalue[30]) m30 (CLK,data_in[30],ena,~rst,data_out[30],un[30]);
    Ansynchronous#(initvalue[29]) m29 (CLK,data_in[29],ena,~rst,data_out[29],un[29]);
    Ansynchronous#(initvalue[28]) m28 (CLK,data_in[28],ena,~rst,data_out[28],un[28]);
    Ansynchronous#(initvalue[27]) m27 (CLK,data_in[27],ena,~rst,data_out[27],un[27]);
    Ansynchronous#(initvalue[26]) m26 (CLK,data_in[26],ena,~rst,data_out[26],un[26]);
    Ansynchronous#(initvalue[25]) m25 (CLK,data_in[25],ena,~rst,data_out[25],un[25]);
    Ansynchronous#(initvalue[24]) m24 (CLK,data_in[24],ena,~rst,data_out[24],un[24]);
    Ansynchronous#(initvalue[23]) m23 (CLK,data_in[23],ena,~rst,data_out[23],un[23]);
    Ansynchronous#(initvalue[22]) m22 (CLK,data_in[22],ena,~rst,data_out[22],un[22]);
    Ansynchronous#(initvalue[21]) m21 (CLK,data_in[21],ena,~rst,data_out[21],un[21]);
    Ansynchronous#(initvalue[20]) m20 (CLK,data_in[20],ena,~rst,data_out[20],un[20]);
    Ansynchronous#(initvalue[19]) m19 (CLK,data_in[19],ena,~rst,data_out[19],un[19]);
    Ansynchronous#(initvalue[18]) m18 (CLK,data_in[18],ena,~rst,data_out[18],un[18]);
    Ansynchronous#(initvalue[17]) m17 (CLK,data_in[17],ena,~rst,data_out[17],un[17]);
    Ansynchronous#(initvalue[16]) m16 (CLK,data_in[16],ena,~rst,data_out[16],un[16]);
    Ansynchronous#(initvalue[15]) m15 (CLK,data_in[15],ena,~rst,data_out[15],un[15]);
    Ansynchronous#(initvalue[14]) m14 (CLK,data_in[14],ena,~rst,data_out[14],un[14]);
    Ansynchronous#(initvalue[13]) m13 (CLK,data_in[13],ena,~rst,data_out[13],un[13]);
    Ansynchronous#(initvalue[12]) m12 (CLK,data_in[12],ena,~rst,data_out[12],un[12]);
    Ansynchronous#(initvalue[11]) m11 (CLK,data_in[11],ena,~rst,data_out[11],un[11]);
    Ansynchronous#(initvalue[10]) m10 (CLK,data_in[10],ena,~rst,data_out[10],un[10]);
    Ansynchronous#(initvalue[9]) m9 (CLK,data_in[9],ena,~rst,data_out[9],un[9]);
    Ansynchronous#(initvalue[8]) m8 (CLK,data_in[8],ena,~rst,data_out[8],un[8]);
    Ansynchronous#(initvalue[7]) m7 (CLK,data_in[7],ena,~rst,data_out[7],un[7]);
    Ansynchronous#(initvalue[6]) m6 (CLK,data_in[6],ena,~rst,data_out[6],un[6]);
    Ansynchronous#(initvalue[5]) m5 (CLK,data_in[5],ena,~rst,data_out[5],un[5]);
    Ansynchronous#(initvalue[4]) m4 (CLK,data_in[4],ena,~rst,data_out[4],un[4]);
    Ansynchronous#(initvalue[3]) m3 (CLK,data_in[3],ena,~rst,data_out[3],un[3]);
    Ansynchronous#(initvalue[2]) m2 (CLK,data_in[2],ena,~rst,data_out[2],un[2]);
    Ansynchronous#(initvalue[1]) m1 (CLK,data_in[1],ena,~rst,data_out[1],un[1]);
    Ansynchronous#(initvalue[0]) m0 (CLK,data_in[0],ena,~rst,data_out[0],un[0]); 
endmodule