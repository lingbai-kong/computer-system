`timescale 1ns/1ps
module PipeID(
    input clk,
    input rst,
    input [31:0] inst,
    input [31:0] pc4,
    input i_EXE_rf_wena,
    input i_EXE_rf_DMEM,
    input [4:0] i_EXE_rf_waddr,
    input [31:0] i_EXE_rf_wdata,
    input i_MEM_rf_wena,
    input i_MEM_rf_DMEM,
    input [4:0] i_MEM_rf_waddr,
    input [31:0] i_MEM_rf_wdata,
    input i_rf_wena,
    input [4:0] i_rf_waddr,
    input [31:0] i_rf_wdata,
    input i_EXE_hi_ena,
    input [31:0] i_EXE_hi_idata,
    input i_EXE_lo_ena,
    input [31:0] i_EXE_lo_idata,
    input i_MEM_hi_ena,
    input [31:0] i_MEM_hi_idata,
    input i_MEM_lo_ena,
    input [31:0] i_MEM_lo_idata,
    input i_hi_ena,
    input [31:0] i_hi_idata,
    input i_lo_ena,
    input [31:0] i_lo_idata,
    input [5:0] i_cp0_int_i,
    input i_blockade,
    input i_branch_predict_success,
    input i_branch_predict_fail,
    output o_DMEM_ena,
    output o_DMEM_wena,
    output [3:0] o_data_type,
    output o_CBW_sign,
    output o_CHW_sign,
    output [31:0] o_pc4,
    output [7:0] o_mux_pc,
    output [7:0] o_mux_rf,
    output o_mux_rf_DMEM,
    output [7:0] o_mux_alu,
    output [7:0] o_mux_hi,
    output [7:0] o_mux_lo,
    output o_rf_wena,
    output [3:0] o_mov_cond,
    output [4:0] o_rf_waddr,
    output [31:0] o_rf_rdata1,
    output [31:0] o_rf_rdata2,
    output [3:0] o_alu_aluc,
    output o_hi_ena,
    output [31:0] o_hi_odata,
    output o_lo_ena,
    output [31:0] o_lo_odata,
    output [3:0] o_hi_lo_func,
    output o_EXT1_n_c,
    output [31:0] o_ext5,
    output [31:0] o_ext16,
    output [31:0] o_ext18,
    output [31:0] o_II,
    output [31:0] o_cp0_rdata,
    output [31:0] o_cp0_exc_addr,
    output o_cp0_timer_int,
    output o_stall,
    output o_blockade,
    output o_branch_inst,
    output o_branch_predict,
    output [3:0] o_branch_flag,
    output [31:0] o_branch_fail_pc,
    
    output [31:0] count,
    output [31:0] compare
);
    wire DMEM_ena;
    wire DMEM_wena;
    wire [7:0] mux_pc;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [15:0] immediate;
    wire [25:0] address;
    wire [7:0] INST;
    wire EXT16_sign;
    wire rf_wena;
    wire [31:0] rf_rdata1;
    wire [31:0] rf_rdata2;
    wire hi_ena;
    wire [31:0] hi_odata;
    wire lo_ena;
    wire [31:0] lo_odata;
    wire [31:0] ext18;
    wire cpr_ena;
    wire blockade;
    wire branch_inst;
    wire [3:0] branch_flag;
    wire cp0_mfc0;
    wire cp0_mtc0;
    wire cp0_exception;
    wire cu_exception;
    wire cp0_eret;
    wire [4:0] cp0_cause;
    wire [31:0] cp0_status;
    wire cp0_delay;
    wire cp0_int;
    wire LLbit_idata;
    wire LLbit_wena;
    wire LLbit_odata;
    decoder DECODER(
        .inst(inst),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .immediate(immediate),
        .address(address),
        .out(INST)
    );
    cu CONTROL_UNIT(
        .rst(rst),
        .branch_predict_success(i_branch_predict_success),
        .branch_predict_fail(i_branch_predict_fail),
        .rf_rdata1(o_rf_rdata1),
        .rf_rdata2(o_rf_rdata2),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .immediate(immediate),
        .address(address),
        .INST(INST),
        .pc4(pc4),
        .ext18(o_ext18),
        .cp0_exec_addr(o_cp0_exc_addr),
        .cp0_int(cp0_int),
        .cp0_status(cp0_status),
        .LLbit_odata(LLbit_odata),
        .DMEM_ena(DMEM_ena),
        .DMEM_wena(DMEM_wena),
        .data_type(o_data_type),
        .CBW_sign(o_CBW_sign),
        .CHW_sign(o_CHW_sign),
        .mux_pc(mux_pc),
        .mux_rf(o_mux_rf),
        .mux_rf_DMEM(o_mux_rf_DMEM),
        .mux_alu(o_mux_alu),
        .mux_hi(o_mux_hi),
        .mux_lo(o_mux_lo),
        .rf_wena(rf_wena),
        .mov_cond(o_mov_cond),
        .rf_waddr(o_rf_waddr),
        .alu_aluc(o_alu_aluc),
        .hi_ena(hi_ena),
        .lo_ena(lo_ena),
        .hi_lo_func(o_hi_lo_func),
        .EXT1_n_c(o_EXT1_n_c),
        .EXT16_sign(EXT16_sign),
        .mfc0(cp0_mfc0),
        .mtc0(cp0_mtc0),
        .exception(cu_exception),
        .eret(cp0_eret),
        .cause(cp0_cause),
        .blockade(blockade),
        .branch_inst(branch_inst),
        .branch_predict(o_branch_predict),
        .branch_flag(branch_flag),
        .branch_fail_pc(o_branch_fail_pc),
        .LLbit_idata(LLbit_idata),
        .LLbit_wena(LLbit_wena)
    );
    direct DIRECT(
        .EXE_rf_wena(i_EXE_rf_wena),
        .EXE_rf_DMEM(i_EXE_rf_DMEM),
        .EXE_rf_waddr(i_EXE_rf_waddr),
        .EXE_rf_wdata(i_EXE_rf_wdata),
        .MEM_rf_wena(i_MEM_rf_wena),
        .MEM_rf_DMEM(i_MEM_rf_DMEM),
        .MEM_rf_waddr(i_MEM_rf_waddr),
        .MEM_rf_wdata(i_MEM_rf_wdata),
        .WB_rf_wena(i_rf_wena),
        .WB_rf_waddr(i_rf_waddr),
        .WB_rf_wdata(i_rf_wdata),
        .rs(rs),
        .rdata1(rf_rdata1),
        .rt(rt),
        .rdata2(rf_rdata2),
        .EXE_hi_ena(i_EXE_hi_ena),
        .EXE_hi_idata(i_EXE_hi_idata),
        .EXE_lo_ena(i_EXE_lo_ena),
        .EXE_lo_idata(i_EXE_lo_idata),
        .MEM_hi_ena(i_MEM_hi_ena),
        .MEM_hi_idata(i_MEM_hi_idata),
        .MEM_lo_ena(i_MEM_lo_ena),
        .MEM_lo_idata(i_MEM_lo_idata),
        .WB_hi_ena(i_hi_ena),
        .WB_hi_idata(i_hi_idata),
        .WB_lo_ena(i_lo_ena),
        .WB_lo_idata(i_lo_idata),
        .hi_odata(hi_odata),
        .lo_odata(lo_odata),
        .o_rdata1(o_rf_rdata1),
        .o_rdata2(o_rf_rdata2),
        .o_hi_odata(o_hi_odata),
        .o_lo_odata(o_lo_odata),
        .stall(o_stall)
    );
    regfile REGFILE(
        .clk(clk),
        .rst(rst),
        .we(i_rf_wena),
        .raddr1(rs),
        .raddr2(rt),
        .waddr(i_rf_waddr),
        .wdata(i_rf_wdata),
        .rdata1(rf_rdata1),
        .rdata2(rf_rdata2)
    );
    pcreg HI(
        .CLK(~clk),
        .rst(rst),
        .ena(i_hi_ena),
        .data_in(i_hi_idata),
        .data_out(hi_odata)
    );
    pcreg LO(
        .CLK(~clk),
        .rst(rst),
        .ena(i_lo_ena),
        .data_in(i_lo_idata),
        .data_out(lo_odata)
    );
    extend5 EXT5(
        .a(shamt),
        .b(o_ext5)
    );    
    extend16 EXT16(
        .a(immediate),
        .sign(EXT16_sign),             //1±íÊ¾ÓÐ·ûºÅ
        .b(o_ext16)
    );
    extend18 EXT18(
        .a(immediate),
        .b(ext18)
    );
    wire empty;
    ADD EXT18_PC(
        .a(ext18),
        .b(pc4),
        .r(o_ext18),
        .overflow(empty)
    );
    ii II(
        .a(pc4[31:28]),
        .b(address),
        .r(o_II)
    );
    cp0 CP0(
        .clk(clk),
        .rst(rst),
        .delay(cp0_delay),
        .mfc0(cp0_mfc0),
        .mtc0(cpr_ena),
        .pc(pc4-32'd4),
        .Rd(rd),
        .wdata(o_rf_rdata2),
        .int_i(i_cp0_int_i),
        .exception(cp0_exception),
        .eret(cp0_eret),
        .cause(cp0_cause),
        .rdata(o_cp0_rdata),
        .status(cp0_status),
        .count(count),
        .compare(compare),
        .exc_addr(o_cp0_exc_addr),
        .timer_int_o(o_cp0_timer_int),
        .int(cp0_int)
    );
    LLbit_reg LLbit_REG(
        .clk(clk),
        .rst(rst),
        .flush(cp0_exception),
        .LLbit_i(LLbit_idata),
        .we(LLbit_wena),
        .LLbit_o(LLbit_odata)
    );
    assign o_pc4=pc4;
    assign o_DMEM_ena=(i_blockade|o_stall)? 0:DMEM_ena;
    assign o_DMEM_wena=(i_blockade|o_stall)? 0:DMEM_wena;
    assign o_mux_pc=(i_blockade|o_stall)? 0:mux_pc;
    assign o_rf_wena=(i_blockade|o_stall)? 0:rf_wena;
    assign o_hi_ena=(i_blockade|o_stall)? 0:hi_ena;
    assign o_lo_ena=(i_blockade|o_stall)? 0:lo_ena;
    assign cpr_ena=(i_blockade|o_stall)? 0:cp0_mtc0;
    assign cp0_exception=(i_blockade|o_stall)? 0:cu_exception;
    assign cp0_delay=(i_blockade|o_stall);
    assign o_blockade=(i_blockade|o_stall)? 0:blockade;
    assign o_branch_inst=(i_blockade|o_stall)? 0:branch_inst;
    assign o_branch_flag=(i_blockade|o_stall)? 4'b0000:branch_flag;
endmodule