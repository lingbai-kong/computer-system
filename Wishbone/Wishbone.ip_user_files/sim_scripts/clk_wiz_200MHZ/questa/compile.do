vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -sv "+incdir+../../../ipstatic" \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93 \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  "+incdir+../../../ipstatic" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ_clk_wiz.v" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ.v" \

vlog -work xil_defaultlib \
"glbl.v"

