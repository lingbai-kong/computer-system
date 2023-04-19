vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -sv "+incdir+../../../ipstatic" \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93 \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../ipstatic" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_5MHZ/clk_wiz_5MHZ_clk_wiz.v" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_5MHZ/clk_wiz_5MHZ.v" \

vlog -work xil_defaultlib \
"glbl.v"

