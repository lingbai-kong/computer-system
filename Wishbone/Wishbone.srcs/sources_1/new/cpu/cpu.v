`timescale 1ns/1ps
`include "cpu_defines.v"
module cpu(
    input         clk,                  //输入时钟信号
    input         rst,                  //复位信号，高电平有效
    input         stall,
    //----------------------------------//指令存储器接口
    output        IM_ena,               //指令存储器使能信号
    output        IM_w,                 //指令存储器读写信号，高电平为写，低电平为读
    output [31:0] pc,                   //指令存储器地址码
    input  [31:0] inst,                 //读入指令机器码
    //----------------------------------//数据存储器接口    
    output        DM_ena,               //数据存储器使能信号
    output        DM_w,                 //数据存储器读写信号，高电平为写，低电平为读
    output [31:0] addr,                 //数据存储器地址码
    output [3:0]  sel,
    input  [31:0] rdata,                //数据存储器读入数据
    output [31:0] wdata,                //数据存储器写入数据
    //----------------------------------//
    input [5:0]   int_i,
    output        timer_int,
    output [31:0] count,                //for debug
    output [31:0] compare               //for debug
    ); 
    wire iPC_ena;
    wire [31:0] iPC_idata;
    wire [31:0] oPC_odata;
    pcreg#(`IMEM_ADDR) PC(
        .CLK(~clk),
        .rst(rst),
        .ena(iPC_ena),
        .data_in(iPC_idata),
        .data_out(oPC_odata)
    );
    wire [31:0] iIF_pc;
    wire [31:0] iIF_rs;
    wire [31:0] iIF_ext18;
    wire [31:0] iIF_II;
    wire [31:0] iIF_epc;
    wire [7:0] iIF_pcmux;
    wire iIF_branch_predict_fail;
    wire [31:0] iIF_branch_fail_pc;
    wire [31:0] oIF_pc4;
    wire [31:0] oIF_npc;
    wire [31:0] oIF_inst;
    PipeIF IF(
        .pc(iIF_pc),
        .rs(iIF_rs),
        .ext18(iIF_ext18),
        .II(iIF_II),
        .epc(iIF_epc),
        .pcmux(iIF_pcmux),
        .branch_predict_fail(iIF_branch_predict_fail),
        .branch_fail_pc(iIF_branch_fail_pc),
        .pc4(oIF_pc4),
        .npc(oIF_npc)
    );
    wire iIR_stall;
    wire [31:0] iID_pc4;
    wire [31:0] iID_inst;
    wire iID_blockade;
    wire iIR_branch_predict_fail;
    wire iIR_blockade;
    PipeIR IR(
        .clk(clk),
        .rst(rst),
        .stall(iIR_stall),
        .pc4(oIF_pc4),
        .inst(oIF_inst),
        .blockade(iIR_blockade|iIR_branch_predict_fail),
        .D_pc4(iID_pc4),
        .D_inst(iID_inst),
        .D_blockade(iID_blockade)
    );
    wire iID_EXE_rf_wena;
    wire iID_EXE_rf_DMEM;
    wire [4:0] iID_EXE_rf_waddr;
    wire [31:0] iID_EXE_rf_wdata;
    wire iID_MEM_rf_wena;
    wire iID_MEM_rf_DMEM;
    wire [4:0] iID_MEM_rf_waddr;
    wire [31:0] iID_MEM_rf_wdata;
    wire iID_rf_wena;
    wire [4:0] iID_rf_waddr;
    wire [31:0] iID_rf_wdata;
    wire iID_EXE_hi_ena;
    wire [31:0] iID_EXE_hi_idata;
    wire iID_EXE_lo_ena;
    wire [31:0] iID_EXE_lo_idata;
    wire iID_MEM_hi_ena;
    wire [31:0] iID_MEM_hi_idata;
    wire iID_MEM_lo_ena;
    wire [31:0] iID_MEM_lo_idata;
    wire iID_hi_ena;
    wire [31:0] iID_hi_idata;
    wire iID_lo_ena;
    wire [31:0] iID_lo_idata;
    wire [5:0] iID_cp0_int_i;
    wire iID_branch_predict_success;
    wire iID_branch_predict_fail;
    wire oID_DMEM_ena;
    wire oID_DMEM_wena;
    wire [3:0] oID_data_type;
    wire oID_CBW_sign;
    wire oID_CHW_sign;
    wire [31:0] oID_pc4;
    wire [7:0] oID_mux_pc;
    wire [7:0] oID_mux_rf;
    wire oID_mux_rf_DMEM;
    wire [7:0] oID_mux_alu;
    wire [7:0] oID_mux_hi;
    wire [7:0] oID_mux_lo;
    wire oID_rf_wena;
    wire [3:0] oID_mov_cond;
    wire [4:0] oID_rf_waddr;
    wire [31:0] oID_rf_rdata1;
    wire [31:0] oID_rf_rdata2;
    wire [3:0] oID_alu_aluc;
    wire oID_hi_ena;
    wire [31:0] oID_hi_odata;
    wire oID_lo_ena;
    wire [31:0] oID_lo_odata;
    wire [3:0] oID_hi_lo_func;
    wire oID_EXT1_n_c;
    wire [31:0] oID_ext5;
    wire [31:0] oID_ext16;
    wire [31:0] oID_ext18;
    wire [31:0] oID_II;
    wire [31:0] oID_cp0_rdata;
    wire [31:0] oID_cp0_exc_addr;
    wire oID_cp0_timer_int;
    wire oID_stall;
    wire oID_blockade; 
    wire oID_branch_inst;
    wire oID_branch_predict;
    wire [3:0] oID_branch_flag;
    wire [31:0] oID_branch_fail_pc;
    PipeID ID(
        .clk(clk),
        .rst(rst),
        .inst(iID_inst),
        .pc4(iID_pc4),
        .i_EXE_rf_wena(iID_EXE_rf_wena),
        .i_EXE_rf_DMEM(iID_EXE_rf_DMEM),
        .i_EXE_rf_waddr(iID_EXE_rf_waddr),
        .i_EXE_rf_wdata(iID_EXE_rf_wdata),
        .i_MEM_rf_wena(iID_MEM_rf_wena),
        .i_MEM_rf_DMEM(iID_MEM_rf_DMEM),
        .i_MEM_rf_waddr(iID_MEM_rf_waddr),
        .i_MEM_rf_wdata(iID_MEM_rf_wdata),
        .i_rf_wena(iID_rf_wena),
        .i_rf_waddr(iID_rf_waddr),
        .i_rf_wdata(iID_rf_wdata),
        .i_EXE_hi_ena(iID_EXE_hi_ena),
        .i_EXE_hi_idata(iID_EXE_hi_idata),
        .i_EXE_lo_ena(iID_EXE_lo_ena),
        .i_EXE_lo_idata(iID_EXE_lo_idata),
        .i_MEM_hi_ena(iID_MEM_hi_ena),
        .i_MEM_hi_idata(iID_MEM_hi_idata),
        .i_MEM_lo_ena(iID_MEM_lo_ena),
        .i_MEM_lo_idata(iID_MEM_lo_idata),
        .i_hi_ena(iID_hi_ena),
        .i_hi_idata(iID_hi_idata),
        .i_lo_ena(iID_lo_ena),
        .i_lo_idata(iID_lo_idata),
        .i_cp0_int_i(iID_cp0_int_i),
        .i_blockade(iID_blockade|iID_branch_predict_fail),
        .i_branch_predict_success(iID_branch_predict_success),
        .i_branch_predict_fail(iID_branch_predict_fail),
        .o_DMEM_ena(oID_DMEM_ena),
        .o_DMEM_wena(oID_DMEM_wena),
        .o_data_type(oID_data_type),
        .o_CBW_sign(oID_CBW_sign),
        .o_CHW_sign(oID_CHW_sign),
        .o_pc4(oID_pc4),
        .o_mux_pc(oID_mux_pc),
        .o_mux_rf(oID_mux_rf),
        .o_mux_rf_DMEM(oID_mux_rf_DMEM),
        .o_mux_alu(oID_mux_alu),
        .o_mux_hi(oID_mux_hi),
        .o_mux_lo(oID_mux_lo),
        .o_rf_wena(oID_rf_wena),
        .o_mov_cond(oID_mov_cond),
        .o_rf_waddr(oID_rf_waddr),
        .o_rf_rdata1(oID_rf_rdata1),
        .o_rf_rdata2(oID_rf_rdata2),
        .o_alu_aluc(oID_alu_aluc),
        .o_hi_ena(oID_hi_ena),
        .o_hi_odata(oID_hi_odata),
        .o_lo_ena(oID_lo_ena),
        .o_lo_odata(oID_lo_odata),
        .o_hi_lo_func(oID_hi_lo_func),
        .o_EXT1_n_c(oID_EXT1_n_c),
        .o_ext5(oID_ext5),
        .o_ext16(oID_ext16),
        .o_ext18(oID_ext18),
        .o_II(oID_II),
        .o_cp0_rdata(oID_cp0_rdata),
        .o_cp0_exc_addr(oID_cp0_exc_addr),
        .o_cp0_timer_int(oID_cp0_timer_int),
        .o_stall(oID_stall),
        .o_blockade(oID_blockade),
        .o_branch_inst(oID_branch_inst),
        .o_branch_predict(oID_branch_predict),
        .o_branch_flag(oID_branch_flag),
        .o_branch_fail_pc(oID_branch_fail_pc),
        
        .count(count),
        .compare(compare)
    );
    wire iDEreg_stall;
    wire oDEreg_DMEM_ena;
    wire oDEreg_DMEM_wena;
    wire [3:0] oDEreg_data_type;
    wire oDEreg_CBW_sign;
    wire oDEreg_CHW_sign;
    wire [31:0] iEXE_pc4;
    wire [7:0] iEXE_mux_rf;
    wire oDEreg_mux_rf_DMEM;
    wire [7:0] iEXE_mux_alu;
    wire [7:0] iEXE_mux_hi;
    wire [7:0] iEXE_mux_lo;
    wire iEXE_rf_wena;
    wire [3:0] iEXE_mov_cond;
    wire [4:0] oDEreg_rf_waddr;
    wire [31:0] iEXE_rf_rdata1;
    wire [31:0] iEXE_rf_rdata2;
    wire [3:0] iEXE_alu_aluc;
    wire oDEreg_hi_ena;
    wire [31:0] iEXE_hi_odata;
    wire oDEreg_lo_ena;
    wire [31:0] iEXE_lo_odata;
    wire [3:0] iEXE_hi_lo_func;
    wire iEXE_EXT1_n_c;
    wire [31:0] iEXE_ext5;
    wire [31:0] iEXE_ext16;
    wire [31:0] iEXE_cpr;
    wire iEXE_branch_inst;
    wire iEXE_branch_predict;
    wire [3:0] iEXE_branch_flag;
    wire [31:0] oDEreg_branch_fail_pc;
    wire iDEreg_branch_predict_fail;
    PipeDEreg DEreg(
        .clk(clk),
        .rst(rst),
        .stall(iDEreg_stall),
        .DMEM_ena(oID_DMEM_ena),
        .DMEM_wena(oID_DMEM_wena),
        .data_type(oID_data_type),
        .CBW_sign(oID_CBW_sign),
        .CHW_sign(oID_CHW_sign),
        .pc4(oID_pc4),
        .mux_rf(oID_mux_rf),
        .mux_rf_DMEM(oID_mux_rf_DMEM),
        .mux_alu(oID_mux_alu),
        .mux_hi(oID_mux_hi),
        .mux_lo(oID_mux_lo),
        .rf_wena(oID_rf_wena),
        .mov_cond(oID_mov_cond),
        .rf_waddr(oID_rf_waddr),
        .rf_rdata1(oID_rf_rdata1),
        .rf_rdata2(oID_rf_rdata2),
        .alu_aluc(oID_alu_aluc),
        .hi_ena(oID_hi_ena),
        .hi_odata(oID_hi_odata),
        .lo_ena(oID_lo_ena),
        .lo_odata(oID_lo_odata),
        .hi_lo_func(oID_hi_lo_func),
        .EXT1_n_c(oID_EXT1_n_c),
        .ext5(oID_ext5),
        .ext16(oID_ext16),
        .cpr(oID_cp0_rdata),
        .branch_inst(oID_branch_inst),
        .branch_predict(oID_branch_predict),
        .branch_flag(oID_branch_flag),
        .branch_fail_pc(oID_branch_fail_pc),
        .blockade(iDEreg_branch_predict_fail),
        .D_DMEM_ena(oDEreg_DMEM_ena),
        .D_DMEM_wena(oDEreg_DMEM_wena),
        .D_data_type(oDEreg_data_type),
        .D_CBW_sign(oDEreg_CBW_sign),
        .D_CHW_sign(oDEreg_CHW_sign),
        .D_pc4(iEXE_pc4),
        .D_mux_rf(iEXE_mux_rf),
        .D_mux_rf_DMEM(oDEreg_mux_rf_DMEM),
        .D_mux_alu(iEXE_mux_alu),
        .D_mux_hi(iEXE_mux_hi),
        .D_mux_lo(iEXE_mux_lo),
        .D_rf_wena(iEXE_rf_wena),
        .D_mov_cond(iEXE_mov_cond),
        .D_rf_waddr(oDEreg_rf_waddr),
        .D_rf_rdata1(iEXE_rf_rdata1),
        .D_rf_rdata2(iEXE_rf_rdata2),
        .D_alu_aluc(iEXE_alu_aluc),
        .D_hi_ena(oDEreg_hi_ena),
        .D_hi_odata(iEXE_hi_odata),
        .D_lo_ena(oDEreg_lo_ena),
        .D_lo_odata(iEXE_lo_odata),
        .D_hi_lo_func(iEXE_hi_lo_func),
        .D_EXT1_n_c(iEXE_EXT1_n_c),
        .D_ext5(iEXE_ext5),
        .D_ext16(iEXE_ext16),
        .D_cpr(iEXE_cpr),
        .D_branch_inst(iEXE_branch_inst),
        .D_branch_predict(iEXE_branch_predict),
        .D_branch_flag(iEXE_branch_flag),
        .D_branch_fail_pc(oDEreg_branch_fail_pc)
    );
    wire oEXE_rf_wena;
    wire [31:0] oEXE_alu_out;
    wire [31:0] oEXE_exe_out;
    wire [31:0] oEXE_hi_idata;
    wire [31:0] oEXE_lo_idata;
    wire oEXE_branch_predict_success;
    wire oEXE_branch_predict_fail;
    PipeEXE EXE(
        .clk(clk),
        .pc4(iEXE_pc4),
        .mux_rf(iEXE_mux_rf),
        .mux_alu(iEXE_mux_alu),
        .mux_hi(iEXE_mux_hi),
        .mux_lo(iEXE_mux_lo),
        .i_rf_wena(iEXE_rf_wena),
        .mov_cond(iEXE_mov_cond),
        .rf_rdata1(iEXE_rf_rdata1),
        .rf_rdata2(iEXE_rf_rdata2),
        .hi_odata(iEXE_hi_odata),
        .lo_odata(iEXE_lo_odata),
        .hi_lo_func(iEXE_hi_lo_func),
        .EXT1_n_c(iEXE_EXT1_n_c),
        .ext5(iEXE_ext5),
        .ext16(iEXE_ext16),
        .cpr(iEXE_cpr),
        .alu_aluc(iEXE_alu_aluc),
        .branch_inst(iEXE_branch_inst),
        .branch_predict(iEXE_branch_predict),
        .branch_flag(iEXE_branch_flag),
        .o_rf_wena(oEXE_rf_wena),
        .alu_out(oEXE_alu_out),
        .exe_out(oEXE_exe_out),
        .hi_idata(oEXE_hi_idata),
        .lo_idata(oEXE_lo_idata),
        .branch_predict_success(oEXE_branch_predict_success),
        .branch_predict_fail(oEXE_branch_predict_fail)
    );
    wire iEMreg_stall;
    wire iMEM_DMEM_ena;
    wire iMEM_DMEM_wena;
    wire [3:0] iMEM_data_type;
    wire iMEM_CBW_sign;
    wire iMEM_CHW_sign;
    wire oEMreg_mux_rf_DMEM;
    wire [31:0] iMEM_Rt;
    wire oEMreg_rf_wena;
    wire [4:0] oEMreg_rf_waddr;
    wire oEMreg_hi_ena;
    wire oEMreg_lo_ena;
    wire [31:0] iMEM_alu_out;
    wire [31:0] iMEM_exe_out;
    wire [31:0] oEMreg_hi_idata;
    wire [31:0] oEMreg_lo_idata;
    PipeEMreg EMreg(
        .clk(clk),
        .rst(rst),
        .stall(iEMreg_stall),
        .DMEM_ena(oDEreg_DMEM_ena),
        .DMEM_wena(oDEreg_DMEM_wena),
        .data_type(oDEreg_data_type),
        .CBW_sign(oDEreg_CBW_sign),
        .CHW_sign(oDEreg_CHW_sign),
        .mux_rf_DMEM(oDEreg_mux_rf_DMEM),
        .rf_rdata2(iEXE_rf_rdata2),
        .rf_wena(oEXE_rf_wena),
        .rf_waddr(oDEreg_rf_waddr),
        .hi_ena(oDEreg_hi_ena),
        .hi_idata(oEXE_hi_idata),
        .lo_ena(oDEreg_lo_ena),
        .lo_idata(oEXE_lo_idata),
        .alu_out(oEXE_alu_out),
        .exe_out(oEXE_exe_out),
        .D_DMEM_ena(iMEM_DMEM_ena),
        .D_DMEM_wena(iMEM_DMEM_wena),
        .D_data_type(iMEM_data_type),
        .D_CBW_sign(iMEM_CBW_sign),
        .D_CHW_sign(iMEM_CHW_sign),
        .D_mux_rf_DMEM(oEMreg_mux_rf_DMEM),
        .D_rf_rdata2(iMEM_Rt),
        .D_rf_wena(oEMreg_rf_wena),
        .D_rf_waddr(oEMreg_rf_waddr),
        .D_hi_ena(oEMreg_hi_ena),
        .D_hi_idata(oEMreg_hi_idata),
        .D_lo_ena(oEMreg_lo_ena),
        .D_lo_idata(oEMreg_lo_idata),
        .D_alu_out(iMEM_alu_out),
        .D_exe_out(iMEM_exe_out)
    );
    wire [31:0] iMEM_DMEM_rdata;
    wire [31:0] oMEM_exe_out;
    wire oMEM_DMEM_ena;
    wire oMEM_DMEM_wena;
    wire [31:0] oMEM_DMEM_addr;
    wire [31:0] oMEM_DMEM_rdata;
    wire [31:0] oMEM_DMEM_wdata;
    wire [3:0] oMEM_sel;
    PipeMEM MEM(
        .i_DMEM_ena(iMEM_DMEM_ena),
        .i_DMEM_wena(iMEM_DMEM_wena),
        .i_data_type(iMEM_data_type),
        .i_CBW_sign(iMEM_CBW_sign),
        .i_CHW_sign(iMEM_CHW_sign),
        .i_DMEM_wdata(iMEM_Rt),
        .i_alu_out(iMEM_alu_out),
        .i_exe_out(iMEM_exe_out),
        .i_DMEM_rdata(iMEM_DMEM_rdata),
        .o_exe_out(oMEM_exe_out),
        .o_DMEM_ena(oMEM_DMEM_ena),
        .o_DMEM_wena(oMEM_DMEM_wena),
        .o_DMEM_addr(oMEM_DMEM_addr),
        .o_DMEM_rdata(oMEM_DMEM_rdata),
        .o_DMEM_wdata(oMEM_DMEM_wdata),
        .o_sel(oMEM_sel)
    );
    wire iMWreg_stall;
    wire iWB_mux_rf_DMEM;
    wire oMWreg_rf_wena;
    wire [4:0] oMWreg_rf_waddr;
    wire oMWreg_hi_ena;
    wire [31:0] oMWreg_hi_idata;
    wire oMWreg_lo_ena;
    wire [31:0] oMWreg_lo_idata;
    wire [31:0] iWB_exe_out;
    wire [31:0] iWB_DMEM_rdata;
    PipeMWreg MWreg(
        .clk(clk),
        .rst(rst),
        .stall(iMWreg_stall),
        .mux_rf_DMEM(oEMreg_mux_rf_DMEM),
        .rf_wena(oEMreg_rf_wena),
        .rf_waddr(oEMreg_rf_waddr),
        .hi_ena(oEMreg_hi_ena),
        .hi_idata(oEMreg_hi_idata),
        .lo_ena(oEMreg_lo_ena),
        .lo_idata(oEMreg_lo_idata),
        .exe_out(oMEM_exe_out),
        .DMEM_rdata(oMEM_DMEM_rdata),
        .D_mux_rf_DMEM(iWB_mux_rf_DMEM),
        .D_rf_wena(oMWreg_rf_wena),
        .D_rf_waddr(oMWreg_rf_waddr),
        .D_hi_ena(oMWreg_hi_ena),
        .D_hi_idata(oMWreg_hi_idata),
        .D_lo_ena(oMWreg_lo_ena),
        .D_lo_idata(oMWreg_lo_idata),
        .D_exe_out(iWB_exe_out),
        .D_DMEM_rdata(iWB_DMEM_rdata)
    );
    wire [31:0] oWB_rf_wdata;
    PipeWB WB(
        .mux_rf_DMEM(iWB_mux_rf_DMEM),
        .exe_out(iWB_exe_out),
        .DMEM_rdata(iWB_DMEM_rdata),
        .rf_wdata(oWB_rf_wdata)
    );
    assign IM_ena=1;
    assign IM_w=0;
    assign pc=oPC_odata;
    assign DM_ena=oMEM_DMEM_ena;
    assign DM_w=oMEM_DMEM_wena;
    assign addr=oMEM_DMEM_addr;
    assign sel=oMEM_sel;
    assign wdata=oMEM_DMEM_wdata;
    assign timer_int=oID_cp0_timer_int;
    
    assign iPC_ena=~(stall|oID_stall);
    assign iPC_idata=oIF_npc;
    assign iIF_pc=oPC_odata;
    assign iIF_rs=oID_rf_rdata1;
    assign iIF_ext18=oID_ext18;
    assign iIF_II=oID_II;
    assign iIF_epc=oID_cp0_exc_addr;
    assign iIF_pcmux=oID_mux_pc;  
    assign iIF_branch_predict_fail=oEXE_branch_predict_fail;
    assign iIF_branch_fail_pc=oDEreg_branch_fail_pc;
    assign oIF_inst=inst; 
   
    assign iIR_stall=stall|oID_stall;
    assign iIR_blockade=oID_blockade;
    assign iIR_branch_predict_fail=oEXE_branch_predict_fail;
    
    assign iID_EXE_rf_wena=oEXE_rf_wena;
    assign iID_EXE_rf_DMEM=oDEreg_mux_rf_DMEM;
    assign iID_EXE_rf_waddr=oDEreg_rf_waddr;
    assign iID_EXE_rf_wdata=oEXE_exe_out;
    assign iID_MEM_rf_wena=oEMreg_rf_wena;
    assign iID_MEM_rf_DMEM=oEMreg_mux_rf_DMEM;
    assign iID_MEM_rf_waddr=oEMreg_rf_waddr;
    assign iID_MEM_rf_wdata=oEMreg_mux_rf_DMEM? oMEM_DMEM_rdata:oMEM_exe_out;
    assign iID_rf_wena=oMWreg_rf_wena;
    assign iID_rf_waddr=oMWreg_rf_waddr;
    assign iID_rf_wdata=oWB_rf_wdata;
    assign iID_EXE_hi_ena=oDEreg_hi_ena;
    assign iID_EXE_hi_idata=oEXE_hi_idata;
    assign iID_EXE_lo_ena=oDEreg_lo_ena;
    assign iID_EXE_lo_idata=oEXE_lo_idata;
    assign iID_MEM_hi_ena=oEMreg_hi_ena;
    assign iID_MEM_hi_idata=oEMreg_hi_idata;
    assign iID_MEM_lo_ena=oEMreg_lo_ena;
    assign iID_MEM_lo_idata=oEMreg_lo_idata;
    assign iID_hi_ena=oMWreg_hi_ena;
    assign iID_hi_idata=oMWreg_hi_idata;
    assign iID_lo_ena=oMWreg_lo_ena;
    assign iID_lo_idata=oMWreg_lo_idata;
    assign iID_cp0_int_i=int_i;
    assign iID_branch_predict_success=oEXE_branch_predict_success;
    assign iID_branch_predict_fail=oEXE_branch_predict_fail;
    
    assign iDEreg_stall=stall;
`ifdef delay_slot
    assign iDEreg_branch_predict_fail=0;
`else
    assign iDEreg_branch_predict_fail=oEXE_branch_predict_fail;
`endif    
    assign iEMreg_stall=stall;
    
    assign iMEM_DMEM_rdata=rdata;
    
    assign iMWreg_stall=stall;
endmodule