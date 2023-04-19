`timescale 1ns / 1ps
module regfile(
    input clk,              //下降沿有效
    input rst,              //高电平有效
    input we,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
);
    wire [31:0] w;
    wire [31:0] array_reg [31:0];
    assign w=32'b00000000000000000000000000000001<<waddr;
    assign array_reg[0] = 32'b0;
    pcreg r1 (clk,rst,we&w[1],wdata,array_reg[1]);
    pcreg r2 (clk,rst,we&w[2],wdata,array_reg[2]);
    pcreg r3 (clk,rst,we&w[3],wdata,array_reg[3]);
    pcreg r4 (clk,rst,we&w[4],wdata,array_reg[4]);
    pcreg r5 (clk,rst,we&w[5],wdata,array_reg[5]);
    pcreg r6 (clk,rst,we&w[6],wdata,array_reg[6]);
    pcreg r7 (clk,rst,we&w[7],wdata,array_reg[7]);
    pcreg r8 (clk,rst,we&w[8],wdata,array_reg[8]);
    pcreg r9 (clk,rst,we&w[9],wdata,array_reg[9]);
    pcreg r10 (clk,rst,we&w[10],wdata,array_reg[10]);
    pcreg r11 (clk,rst,we&w[11],wdata,array_reg[11]);
    pcreg r12 (clk,rst,we&w[12],wdata,array_reg[12]);
    pcreg r13 (clk,rst,we&w[13],wdata,array_reg[13]);
    pcreg r14 (clk,rst,we&w[14],wdata,array_reg[14]);
    pcreg r15 (clk,rst,we&w[15],wdata,array_reg[15]);
    pcreg r16 (clk,rst,we&w[16],wdata,array_reg[16]);
    pcreg r17 (clk,rst,we&w[17],wdata,array_reg[17]);
    pcreg r18 (clk,rst,we&w[18],wdata,array_reg[18]);
    pcreg r19 (clk,rst,we&w[19],wdata,array_reg[19]);
    pcreg r20 (clk,rst,we&w[20],wdata,array_reg[20]);
    pcreg r21 (clk,rst,we&w[21],wdata,array_reg[21]);
    pcreg r22 (clk,rst,we&w[22],wdata,array_reg[22]);
    pcreg r23 (clk,rst,we&w[23],wdata,array_reg[23]);
    pcreg r24 (clk,rst,we&w[24],wdata,array_reg[24]);
    pcreg r25 (clk,rst,we&w[25],wdata,array_reg[25]);
    pcreg r26 (clk,rst,we&w[26],wdata,array_reg[26]);
    pcreg r27 (clk,rst,we&w[27],wdata,array_reg[27]);
    pcreg r28 (clk,rst,we&w[28],wdata,array_reg[28]);
    pcreg r29 (clk,rst,we&w[29],wdata,array_reg[29]);
    pcreg r30 (clk,rst,we&w[30],wdata,array_reg[30]);
    pcreg r31 (clk,rst,we&w[31],wdata,array_reg[31]);
    assign rdata1=array_reg[raddr1];
    assign rdata2=array_reg[raddr2];
endmodule