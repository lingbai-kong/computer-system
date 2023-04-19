// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Thu May 20 18:08:39 2021
// Host        : kPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/sd_buf/sd_buf_stub.v
// Design      : sd_buf
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.2" *)
module sd_buf(a, d, clk, we, spo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],d[31:0],clk,we,spo[31:0]" */;
  input [6:0]a;
  input [31:0]d;
  input clk;
  input we;
  output [31:0]spo;
endmodule
