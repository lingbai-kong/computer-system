`timescale 1ns / 1ps
module Ansynchronous#(parameter initvalue=1'b0)(
    input CLK,
    input D,
    input ena,
    input RST_n,
    output reg Q1,
    output Q2
);
    assign Q2=~Q1;
    always@(negedge CLK or negedge RST_n)
    begin
    if(!RST_n)
    begin
        Q1<=initvalue;
    end
    else if(ena)
    begin
        Q1<=D;
    end
    end
endmodule