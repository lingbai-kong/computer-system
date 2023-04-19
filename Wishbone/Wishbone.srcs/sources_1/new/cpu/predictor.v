`timescale 1ns/1ps
module predictor(
    input rst,
    input success,
    input fail,
    output branch_predict
);
    parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
    reg [1:0] state=s2;
    assign branch_predict=state[1];
    always@(posedge rst or posedge success or posedge fail)
    begin
        if(rst)
            state<=s2;
        else
        begin
            case(state)
            s0:begin
                if(success)
                    state<=s0;
                else if(fail)
                    state<=s1;
            end
            s1:begin
                if(success)
                    state<=s0;
                else if(fail)
                    state<=s2;
            end
            s2:begin
                if(success)
                    state<=s3;
                else if(fail)
                    state<=s1;
            end
            s3:begin
                if(success)
                    state<=s3;
                else if(fail)
                    state<=s2;
            end
            endcase
        end
    end
endmodule