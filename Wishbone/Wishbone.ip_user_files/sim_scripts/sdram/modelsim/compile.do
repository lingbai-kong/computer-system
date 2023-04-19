vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -sv \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93 \
"M:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/clocking/mig_7series_v4_2_clk_ibuf.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/clocking/mig_7series_v4_2_infrastructure.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/clocking/mig_7series_v4_2_iodelay_ctrl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/clocking/mig_7series_v4_2_tempmon.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_arb_mux.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_arb_row_col.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_arb_select.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_cntrl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_common.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_compare.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_mach.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_queue.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_bank_state.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_col_mach.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_mc.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_rank_cntrl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_rank_common.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_rank_mach.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/controller/mig_7series_v4_2_round_robin_arb.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ecc/mig_7series_v4_2_ecc_buf.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ecc/mig_7series_v4_2_ecc_dec_fix.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ecc/mig_7series_v4_2_ecc_gen.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ecc/mig_7series_v4_2_ecc_merge_enc.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ecc/mig_7series_v4_2_fi_xor.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ip_top/mig_7series_v4_2_memc_ui_top_std.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ip_top/mig_7series_v4_2_mem_intfc.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_group_io.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_lane.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_calib_top.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_if_post_fifo.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy_wrapper.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_of_pre_fifo.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_4lanes.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal_hr.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_init.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_cntlr.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_data.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_edge.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_lim.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_mux.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_po_cntlr.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_samp.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_oclkdelay_cal.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_prbs_rdlvl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_rdlvl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_tempmon.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_top.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrcal.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl_off_delay.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_ddr_prbs_gen.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_cc.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_edge_store.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_meta.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_pd.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_tap_base.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/phy/mig_7series_v4_2_poc_top.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ui/mig_7series_v4_2_ui_cmd.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ui/mig_7series_v4_2_ui_rd_data.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ui/mig_7series_v4_2_ui_top.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/ui/mig_7series_v4_2_ui_wr_data.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/sdram_mig_sim.v" \
"../../../../Wishbone.gen/sources_1/ip/sdram/sdram/user_design/rtl/sdram.v" \

vlog -work xil_defaultlib \
"glbl.v"

