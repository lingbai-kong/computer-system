`timescale 1ns/1ps
module PipeIR(
    input clk,
    input rst,
    input stall,
    input [31:0] pc4,
    input [31:0] inst,
    input blockade,
    output reg [31:0] D_pc4,
    output reg [31:0] D_inst,
    output reg D_blockade
);
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            D_pc4<=32'b0;
            D_inst<=32'b0;
            D_blockade<=1;
        end
        else if(~stall)
        begin
            D_pc4<=pc4;
            D_inst<=inst;
            D_blockade<=blockade;
        end
    end
endmodule