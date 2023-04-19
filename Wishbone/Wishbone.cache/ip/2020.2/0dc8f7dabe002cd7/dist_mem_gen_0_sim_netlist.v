// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon May 24 16:23:47 2021
// Host        : kPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dist_mem_gen_0_sim_netlist.v
// Design      : dist_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dist_mem_gen_0,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (a,
    spo);
  input [9:0]a;
  output [31:0]spo;

  wire \<const0> ;
  wire [9:0]a;
  wire [3:3]\^spo ;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;
  wire [31:0]NLW_U0_spo_UNCONNECTED;

  assign spo[31] = \<const0> ;
  assign spo[30] = \<const0> ;
  assign spo[29] = \<const0> ;
  assign spo[28] = \<const0> ;
  assign spo[27] = \<const0> ;
  assign spo[26] = \<const0> ;
  assign spo[25] = \<const0> ;
  assign spo[24] = \<const0> ;
  assign spo[23] = \<const0> ;
  assign spo[22] = \<const0> ;
  assign spo[21] = \<const0> ;
  assign spo[20] = \<const0> ;
  assign spo[19] = \<const0> ;
  assign spo[18] = \<const0> ;
  assign spo[17] = \<const0> ;
  assign spo[16] = \<const0> ;
  assign spo[15] = \<const0> ;
  assign spo[14] = \<const0> ;
  assign spo[13] = \<const0> ;
  assign spo[12] = \<const0> ;
  assign spo[11] = \<const0> ;
  assign spo[10] = \<const0> ;
  assign spo[9] = \<const0> ;
  assign spo[8] = \<const0> ;
  assign spo[7] = \<const0> ;
  assign spo[6] = \<const0> ;
  assign spo[5] = \<const0> ;
  assign spo[4] = \<const0> ;
  assign spo[3] = \^spo [3];
  assign spo[2] = \<const0> ;
  assign spo[1] = \<const0> ;
  assign spo[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "10" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "dist_mem_gen_0.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo({NLW_U0_spo_UNCONNECTED[31:4],\^spo ,NLW_U0_spo_UNCONNECTED[2:0]}),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
AWk2+F/LLIwJ/3H70MT+p73z+MaZAUnylB9xu/zfH66xX8dAaOizqpslZkE4MXrWhxdHpghP7sIj
kwvWqhJ3gA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
f3tnX2YCmmij/BT714m5fPTuG3pr/Sp1bWD1FpCFiwTkcUFmqMNcr7abCn+qa2HUp1VAs9a1kY1i
yU68W3C4ARAx1rnlow3CtMBZ+4vG1QDA+Ciu5T+MSJsiWTAoMU3jJunULwD6zEC9h/Y3bBf+ZNGj
RvbKgHQFYSq+EYUzleQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
C6xRmzJVnvguMc3Lt5tkoyg5+/u1VuxRooNBOmgUvD6c148xX9CV/zz4fw53vbCzqUg3WYMPAs5M
/tMrhPMrX5cqjMMHbC20NaFxsFGCfdbN+1Jiu6Ffu0obXLvBu7UGBCEaDTCY0wST3S+7NZ+HnAat
RIt5cVRmnWtLEj9MP8SxAk019LKc3+2AUY0eWFhWbTGvNoTLcRFak8vqIx8KBuqhc16O50jjNmM3
PJltfibMKzAmWpsf6xiOkaD+BvARuccAoYGgANLBAEQdJUza98//SuTN0KLZKbFSmy2WI5iAzkxJ
bhH9hPn6Ks1JkH9+j61hMSpdxSh8rM8X8Dppxw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pefxdCU7VwYHa7diZaenheQOVCFpIvDlVp0qUtYsCnfw3IK+d5+k4O7xc5MWvQPeJpwUWNg+c9U8
PcbHo1enWoVg9o1V4U5fg7wxYqKmubBjgGF3yJ5FYGt6FeiD7zcnIJcaP2puAYDdVnxtiJnNmFz2
OQ7UQsleDpBQo3E4NEsbtqgSaopjHREMjI4yjJ9l5XZYNPCWUzUV/mSGX/kF+vuSOZclwPm6w72e
TE0MyJZA2HPDY3HIy260pYSHuDTUpe8gTxi0s8JmpFjaMaibBcPzq2gqPSQe1d6pDE8cv0OxNYKL
gFy+uh/H5gpNjfWVBhRmUo/kFf8fs680z0B0IQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
q8meW/DFYsK3R2jTQ13P/a1BVQyF0Eb3aLhqxNSrqINAq7gQ0DvJ6JFuxd6Ce7TIpxqKUYX9026h
UujOPWt7f1brVrSWmt8cW5Um2Yy8tv+YSNv9Ig592u4GssTU6dF978RK/7L4ZuQObLOKvWLJqo3F
6gzw0VbqYS3g5aaGu+Y=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GVM7UoBz9uTOdnKd0CVM0lBuJK2N20FwcoiRGregMBQMsQuevbc7y03ZehM7mfGvEdERp1TciWoI
1b6cDAZYb0YBfSuch0bItCwhdftV3A4/R0nUF0HROsZ/rm/HV7DKDXxItqK0qcdOwqf7ju85NMa4
FJRP/Nuq/ya9IvX9BCpmUlT7tLkICG8cEL8/iJrJY3jRIBtKw85mL5OM+r22LQeYg1/3rb9Rk9BT
RZCTbDcVSUq2Awr+6f0L2NXlRwhFraBy+h9iSZKZ/U7uolyF0nB1+/BSgOl+rttZ2KxfLXe6g81N
FbxtrlpK7FNc9fx2jrKWh5bczyW6p0ATPX0ZbA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rYkJ9a3QzTBGC5CITub5Su2Qs6nnM1m+OFLf4ykZkZGIsp11NQi6h5t8dsi/rX/MeEof1XLVJGEU
N+qLOHuLrttRAipPNBsj7yqH3Amnleqy/rjy8UcckD0gxIYzuIlc+2VKoAoyrEFgofTH5bKzBaaQ
q0JSt8PES8xuld4SvsKwr+0Q23qJIUpeNL3HvzxZDmYf5OhTkwlZPi/aLwSMoPZHKwetLUg5SdBm
7K4UmxvUPD3GNxo6GW6dkG2tFW/N9+ju7i//O1A74VUrDPo1OwQfEJazwHFFpHGjCJkv2CiPU3+I
TIVvzssQcs8IphMJulwZguc7fFiYv6aZyj/GrA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PqIVM68d++A6qxRgSePlX8JOoCfHcFLdhzsYr1BDYvLE5JJ5WKFO0Bie6pyEiAbsH8z6oUFGm/Qy
BLXAyWfv1fmbVAwztezaMaxBF0Lw4epvQlAFVdMGJVKgvxfU7ssvLc1KfpF6R/c1o5+4Vf7zn3X+
R8k67LVYgJoxhrPoY3XYr88CjSITfNW0jLDjh0jtDWf7H7nM6QYSXVbRYczQPcepXW2MOFcCZsbi
tdla+UNJ4NeKTUK5bdE9tNZx/8BYKrJtLhyvNdwHi7EdonKLjQu63ExIHoriUmiZScMNbtr2LUBc
YYGUTIENquQ/OhU+DAVXmKbIZcQhwGaqjYeaag==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YMvD1GHkklhDlN9yur11SqhNZTItCRHxHobZtty993SsbvXTWJBbLeIJ+nQ/sv57gpjV5RswiJYh
Vu7QPlLUy2DbVjjcqxaxXlPvYaWV1eKD7BVBOV6HDzPAaAIaFvNjeRurYX0a9Dz1qkgkmttneZxB
s04mTyRdVOc7jIs5wjgXiF+iA0W50/g9JmIYyP6mMLkgEy0MbGyVfpbRfDMcrB3ACnucHTo8A0nT
V/rBUOGbTCYPmQ01tbuE2nqoEfTlmqHVKO6BZ93tQUEjrYoJdteva6yHUfH3dbV1vwwBtsdolICY
7x8cMlorxb6y2ZD7vQEYz6Q6iVnG/PmdaCkLSg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6576)
`pragma protect data_block
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
Hdkhbt+2kHlPRm98PIofaXe9W58G
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
