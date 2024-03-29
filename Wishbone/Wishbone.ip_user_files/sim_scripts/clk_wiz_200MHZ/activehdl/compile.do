vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ_clk_wiz.v" \
"../../../../Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ.v" \

vlog -work xil_defaultlib \
"glbl.v"

