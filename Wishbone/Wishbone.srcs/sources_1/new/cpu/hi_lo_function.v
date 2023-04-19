`timescale 1ns/1ps
module hi_lo_function(
    input [31:0] hi_odata,
    input [31:0] lo_odata,
    input [31:0] hi_new,
    input [31:0] lo_new,
    input [3:0] hi_lo_func,
    output [31:0] hi_wdata,
    output [31:0] lo_wdata
);
    parameter hi_lo_func_NONE=4'd0,hi_lo_func_MADD=4'd1,hi_lo_func_MADDU=4'd2,hi_lo_func_MSUB=4'd3,hi_lo_func_MSUBU=4'd4;
    wire [63:0] u_data1;
    wire [63:0] u_data2;
    wire signed [63:0] s_data1;
    wire signed [63:0] s_data2;
    reg signed [63:0] data_result;
    assign u_data1={hi_odata,lo_odata};
    assign u_data2={hi_new,lo_new};
    assign s_data1={hi_odata,lo_odata};
    assign s_data2={hi_new,lo_new};
    assign hi_wdata=data_result[63:32];
    assign lo_wdata=data_result[31:0];
    always@(*)
    begin
        case(hi_lo_func)
            hi_lo_func_NONE:data_result<=u_data2;
            hi_lo_func_MADD:data_result<=s_data1+s_data2;
            hi_lo_func_MADDU:data_result<=u_data1+u_data2;
            hi_lo_func_MSUB:data_result<=s_data1-s_data2;
            hi_lo_func_MSUBU:data_result<=u_data1-u_data2;
        endcase
    end
endmodule