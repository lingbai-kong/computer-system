`timescale 1ns / 1ps
module LLbit_reg(
	input clk,
	input rst,
	input flush,
	//Ð´¶Ë¿Ú
	input LLbit_i,
	input we,
	//¶Á¶Ë¿Ú1
	output reg LLbit_o
	
);
    always @ (posedge clk) begin
        if (rst) begin
            LLbit_o <= 1'b0;
        end 
        else if(flush) begin
            LLbit_o <= 1'b0;
        end 
        else if(we) begin
            LLbit_o <= LLbit_i;
        end
    end
endmodule