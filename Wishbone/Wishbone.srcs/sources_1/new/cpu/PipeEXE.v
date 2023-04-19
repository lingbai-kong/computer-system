`timescale 1ns/1ps
module PipeEXE(
    input clk,
    input [31:0] pc4,
    input [7:0] mux_rf,
    input [7:0] mux_alu,
    input [7:0] mux_hi,
    input [7:0] mux_lo,
    input i_rf_wena,
    input [3:0] mov_cond,
    input [31:0] rf_rdata1,
    input [31:0] rf_rdata2,
    input [31:0] hi_odata,
    input [31:0] lo_odata,
    input [3:0] hi_lo_func,
    input EXT1_n_c,
    input [31:0] ext5,
    input [31:0] ext16,
    input [31:0] cpr,
    input [3:0] alu_aluc,
    input branch_inst,
    input branch_predict,
    input [3:0] branch_flag,
    output reg o_rf_wena,
    output [31:0] alu_out,
    output [31:0] exe_out,
    output [31:0] hi_idata,
    output [31:0] lo_idata,
    output reg branch_predict_success,
    output reg branch_predict_fail
);
    parameter branch_NONE=4'd0,branch_BEQ=4'd1,branch_BNE=4'd2,branch_BGEZ=4'd3,
    branch_BGTZ=4'd5,branch_BLEZ=4'd6,branch_BLTZ=4'd7;
    parameter mov_cond_NONE=4'd0,mov_cond_N=4'd1,mov_cond_Z=4'd2;
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire alu_zero;
    wire alu_carry;
    wire alu_negative;
    wire alu_overflow;
    wire [63:0] mult_out;
    wire [63:0] multu_out;
    wire [31:0] div_q;
    wire [31:0] div_r;
    wire [31:0] divu_q;
    wire [31:0] divu_r;
    wire [31:0] hi_new;
    wire [31:0] lo_new;
    wire [31:0] D_CLZ;
    wire [31:0] D_CLO;
    wire [31:0] D_EXT1_n;
    wire [31:0] D_EXT1_c;
    wire [31:0] D_EXT1;
    mux_alu MUX_ALU(
        .rs(rf_rdata1),
        .rt(rf_rdata2),
        .ext5(ext5),
        .ext16(ext16),
        .pc(pc4),
        .mux(mux_alu),
        .a(alu_a),
        .b(alu_b)
    );
    alu ALU(
        .a(alu_a),
        .b(alu_b),
        .aluc(alu_aluc),
        .r(alu_out),
        .zero(alu_zero),
        .carry(alu_carry),
        .negative(alu_negative),
        .overflow(alu_overflow)
    );
    mult MULT(
        .s_a(rf_rdata1),
        .s_b(rf_rdata2),
        .s_z(mult_out)
    );
    multu MULTU(
        .a(rf_rdata1),
        .b(rf_rdata2),
        .z(multu_out)
    );
    div DIV(
        .s_dividend(rf_rdata1),
        .s_divisor(rf_rdata2),
        .s_q(div_q),
        .s_r(div_r)
    );
    divu DIVU(
        .dividend(rf_rdata1),
        .divisor(rf_rdata2),
        .q(divu_q),
        .r(divu_r)
    );
    clz CLZ(
        .in(rf_rdata1),
        .out(D_CLZ)
    );
    clo CLO(
        .in(rf_rdata1),
        .out(D_CLO)
    );
    mux_rf MUX_RF(
        .alu(alu_out),
        .ext1(D_EXT1),
        .pc(pc4+32'd4),
        .clz(D_CLZ),
        .hi(hi_odata),
        .lo(lo_odata),
        .cpr(cpr),
        .mul(mult_out[31:0]),
        .clo(D_CLO),
        .mux(mux_rf),
        .out(exe_out)
    );
    mux_hi MUX_HI(
        .rs(rf_rdata1),
        .div(div_r),
        .divu(divu_r),
        .mult(mult_out[63:32]),
        .multu(multu_out[63:32]),
        .mux(mux_hi),
        .out(hi_new)
    );
    mux_lo MUX_LO(
        .rs(rf_rdata1),
        .div(div_q),
        .divu(divu_q),
        .mult(mult_out[31:0]),
        .multu(multu_out[31:0]),
        .mux(mux_lo),
        .out(lo_new)
    );
    hi_lo_function HI_LO_FUNC(
        .hi_odata(hi_odata),
        .lo_odata(lo_odata),
        .hi_new(hi_new),
        .lo_new(lo_new),
        .hi_lo_func(hi_lo_func),
        .hi_wdata(hi_idata),
        .lo_wdata(lo_idata)
    );
    extend1 EXT1_n(
        .a(alu_negative),
        .b(D_EXT1_n)
    );
    extend1 EXT1_c(
        .a(alu_carry),
        .b(D_EXT1_c)
    );
    mux2_32 EXT1(
        .a(D_EXT1_n),
        .b(D_EXT1_c),
        .choose(EXT1_n_c),
        .c(D_EXT1)
    );
    always@(*)
    begin
        if(branch_inst)
        begin
            case(branch_flag)
                branch_BEQ:begin
                    branch_predict_success<=(branch_predict&&rf_rdata1==rf_rdata2)||(!branch_predict&&rf_rdata1!=rf_rdata2);
                    branch_predict_fail<=(!branch_predict&&rf_rdata1==rf_rdata2)||(branch_predict&&rf_rdata1!=rf_rdata2);
                end
                branch_BNE:begin
                    branch_predict_success<=(branch_predict&&rf_rdata1!=rf_rdata2)||(!branch_predict&&rf_rdata1==rf_rdata2);
                    branch_predict_fail<=(!branch_predict&&rf_rdata1!=rf_rdata2)||(branch_predict&&rf_rdata1==rf_rdata2);
                end
                branch_BGEZ:begin
                    branch_predict_success<=(branch_predict&&~rf_rdata1[31])||(!branch_predict&&rf_rdata1[31]);
                    branch_predict_fail<=(!branch_predict&&~rf_rdata1[31])||(branch_predict&&rf_rdata1[31]);
                end
                branch_BGTZ:begin
                    branch_predict_success<=(branch_predict&&(~rf_rdata1[31]&&rf_rdata1!=32'b0))||(!branch_predict&&(rf_rdata1[31]||rf_rdata1==32'b0));
                    branch_predict_fail<=(!branch_predict&&(~rf_rdata1[31]&&rf_rdata1!=32'b0))||(branch_predict&&(rf_rdata1[31]||rf_rdata1==32'b0));
                end
                branch_BLEZ:begin
                    branch_predict_success<=(branch_predict&&(rf_rdata1[31]||rf_rdata1==32'b0))||(!branch_predict&&(~rf_rdata1[31]&&rf_rdata1!=32'b0));
                    branch_predict_fail<=(!branch_predict&&(rf_rdata1[31]||rf_rdata1==32'b0))||(branch_predict&&(~rf_rdata1[31]&&rf_rdata1!=32'b0));
                end
                branch_BLTZ:begin
                    branch_predict_success<=(branch_predict&&rf_rdata1[31])||(!branch_predict&&~rf_rdata1[31]);
                    branch_predict_fail<=(!branch_predict&&rf_rdata1[31])||(branch_predict&&~rf_rdata1[31]);
                end
            endcase
        end
        else
        begin
            branch_predict_success<=0;
            branch_predict_fail<=0;
        end
    end
    always@(*)
    begin
        if(mov_cond==mov_cond_NONE)
        begin
            if(branch_flag==branch_BLTZ&&~rf_rdata1[31]||
               branch_flag==branch_BGEZ&&rf_rdata1[31])
            begin
                o_rf_wena<=0;
            end
            else
            begin
                o_rf_wena<=i_rf_wena;
            end
        end
        else 
        begin
            if(mov_cond==mov_cond_N&&rf_rdata2!=32'b0||mov_cond==mov_cond_Z&&rf_rdata2==32'b0)
            begin
                o_rf_wena<=i_rf_wena;
            end
            else
            begin
                o_rf_wena<=0;
            end
        end
    end
endmodule