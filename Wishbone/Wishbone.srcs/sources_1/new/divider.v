`timescale 1ns / 1ps
module time_divider#(parameter index=5)(
    input I_CLK,
    input rst,
    output O_CLK
);
    reg out;
    integer i;
    always@(posedge I_CLK or posedge rst)
    begin
    if(rst)
        begin
        out=0;
        i=0;
        end
    else
        begin
        if(i==index)
            begin
            i=0;
            out=~out;
            end
        i=i+1;
        end
    end
    assign O_CLK=out;
endmodule