######################################################################
#
# File name : cpu_test_compile.do
# Created on: Mon May 24 16:28:37 +0800 2021
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/dist_mem_gen_v8_0_13
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap dist_mem_gen_v8_0_13 modelsim_lib/msim/dist_mem_gen_v8_0_13
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog  -incr -sv -work xpm  \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom  -93 -work xpm  \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog  -incr -work dist_mem_gen_v8_0_13  \
"../../../../Wishbone.ip_user_files/ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog  -incr -work xil_defaultlib  \
"../../../../Wishbone.gen/sources_1/ip/dist_mem_gen_0/sim/dist_mem_gen_0.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/Asynchronous_D_FF.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/II.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/LLbit_reg.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeDEreg.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeEMreg.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeEXE.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeID.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeIF.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeIR.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeMEM.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeMWreg.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/PipeWB.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/alu.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/clo.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/clz.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/complement.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/cp0.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/cpmem.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/cpu.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/cpu_top.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/cu.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/decoder.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/direct.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/div.v" \
"../../../../Wishbone.srcs/sources_1/new/divider.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/extend.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/hi_lo_function.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/mult.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/mux.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/npc.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/pcreg.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/predictor.v" \
"../../../../Wishbone.srcs/sources_1/new/cpu/regfile.v" \
"../../../../Wishbone.srcs/sim_1/new/cpu_test.v" \

# compile glbl module
vlog -work xil_defaultlib "glbl.v"

quit -force
