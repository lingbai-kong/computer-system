`timescale 1ns/1ps
module PipeMEM(
    input i_DMEM_ena,
    input i_DMEM_wena,
    input [3:0] i_data_type,
    input i_CBW_sign,
    input i_CHW_sign,
    input [31:0] i_DMEM_wdata,
    input [31:0] i_alu_out,
    input [31:0] i_exe_out,
    input [31:0] i_DMEM_rdata,
    output [31:0] o_exe_out,
    output o_DMEM_ena,
    output o_DMEM_wena,
    output [31:0] o_DMEM_addr,
    output reg [31:0] o_DMEM_rdata,
    output [31:0] o_DMEM_wdata,
    output [3:0] o_sel
);
    parameter Wdata=4'd0,Hdata=4'd1,Bdata=4'd2,Ldata=4'd3,Rdata=4'd4;
    wire [31:0] rdata32;
    wire [15:0] rdata16;
    wire [7:0] rdata8;
    wire [31:0] D_CBW;
    wire [31:0] D_CHW;
    cpmem CPMEM(
        .data_type(i_data_type),
        .exact_addr(i_alu_out),
        .appr_addr(o_DMEM_addr),
        .rdata32(rdata32),
        .rdata16(rdata16),
        .rdata8(rdata8),
        .rdata(i_DMEM_rdata),
        .wdata32(i_DMEM_wdata),
        .wdata16(i_DMEM_wdata[15:0]),
        .wdata8(i_DMEM_wdata[7:0]),
        .wdata(o_DMEM_wdata),
        .sel(o_sel)
    );
    extend8 CBW(
        .a(rdata8),
        .sign(i_CBW_sign),
        .b(D_CBW)
    );
    extend16 CHW (
        .a(rdata16),
        .sign(i_CHW_sign),       
        .b(D_CHW)
    );
    always@(*)
    begin
        case(i_data_type)
            Wdata,Ldata,Rdata:begin
                o_DMEM_rdata<=rdata32;
            end
            Hdata:begin
                o_DMEM_rdata<=D_CHW;
            end
            Bdata:begin
                o_DMEM_rdata<=D_CBW;
            end
        endcase
    end
    assign o_DMEM_ena=i_DMEM_ena;
    assign o_DMEM_wena=i_DMEM_wena;
    assign o_exe_out=i_exe_out;
endmodule