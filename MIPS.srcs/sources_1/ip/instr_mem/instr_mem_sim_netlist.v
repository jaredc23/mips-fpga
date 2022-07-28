// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Wed Jul 27 19:30:20 2022
// Host        : DESKTOP-F3JRP19 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/Jared/Desktop/Projects/MIPS
//               Processor/MIPS.srcs/sources_1/ip/instr_mem/instr_mem_sim_netlist.v}
// Design      : instr_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "instr_mem,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module instr_mem
   (a,
    spo);
  input [7:0]a;
  output [15:0]spo;

  wire [7:0]a;
  wire [15:0]spo;
  wire [15:0]NLW_U0_dpo_UNCONNECTED;
  wire [15:0]NLW_U0_qdpo_UNCONNECTED;
  wire [15:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "zynq" *) 
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
  (* c_addr_width = "8" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "256" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "instr_mem.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "16" *) 
  (* is_du_within_envelope = "true" *) 
  instr_mem_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[15:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[15:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[15:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
JqLVJNxQZkLohSEqQ9ITFybNm9QPcaTh8kyc7h4uGNwD1GaEe9dZHqj61sUilGTlF+FUk7afNjXe
+9yQ4e75SyWC3Z6F0o0CdI6t84E2VRqNvne6PMLMbSrRPmTgt8cbodbZa3saUKncQltVwK/zTxXc
dXyeIJwoVnylCRZ8MPU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RMR60V/K16S3hDpcgdlFzH6vzNttFBxzcEIP9k8l6xLxOXzEGeRk2beZg3IkkpX9ywpiLolj/ijd
pAlaBccK0sBT48q6qTKLouly7vRT3U8EOwOAJBZoDUnL/NwrlIomkg8Pj/4x8iecc9IFkdcLg53k
dreGnJ/4ti8Qi6sHP5Vsy0qpJoYpWsOBc2cmgH9vayWn6WlV7QL8YjnFQ6bQnWuyarN2QQK+bLzc
JrPAdTBzH05U9MiHwKRG1GlZxJA5fxQttnLA39Nwggz6r5qeYai4Vo+J8h0NQDa/GYHeYKSYsF9p
VKrYe14mz3CSYvF3+NMCtnCz+VeW7lF95iKCXA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
k6iMAgjYok8KaQLMY/TME6/aSCYTKFMZWtHwbD2VKIKOoM9woUSioI0NuiYfkPizuiBJEl8Af3NJ
M5VmpW3SVM0lwPjVSCSNmHMIfc2krrmg962M4XaG4w+tnp7hwZbdNZ8ahj6pOLDYSTGKwdGQanuk
rIQbC+15rT9WEK2XGDQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lHyAdhaPyzMCy12MalQZTt5ud3be/nityQmJ518pNrYUzgCs2nz/J1pZZgf+RWFgX9JUwWOgttjl
3vfihnzL/+pRWaWe8tlTToa5xX6V/jpw3hAcktXx9YKYreiOr2qpeTLkbp0k6MDPx0OZ6zF6OnXU
mj71WlXFOMXCx/95ZDxCuphivrOiA+pFZwGv2NIFmX/Oh4q8NTSFzJYzF3L9rWrI08UUEu9QuuxY
Iqlhuw+fXq//x9+jC7JNcedTSCXVkefBvZdJcbH0kbNA5ChG445apiF/OiKhKxTUjVKp7Rkm62fE
cFEo6KH1Cp+QaVxNQ55dcOTpVSSDpQGvshrQzw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
D53lVPGhmka10zY9LQFvI7i1UPoiOm2NaQ+1PpDUs4OCbAMqPLHQSHIZ3EMPWpwgdfAtW9t+9lxl
o33XZq60DBUJ4ZKPRvcfbZCHmpPyjm3Rs8+ACxnIH7G37stehOSCzSXeqM9ORqajk0MjoE3bDLx9
FtW+eEPY1KauFU6KHAWAdaZPPnc5QfgBkK0c27Y7CfkJ049Sjv4lFwtiVOmSkCvdDDisv3/WAcSs
c5Zo+cJIWzw/prfWYTGIB0goZNZRXZpB/aULwQ5itLufopA2f9cHo50fqlIvQX4YoYlfQTXpj3Lj
Qd+7/1UmFCqQLsnOUXy9D/tgspVDu7POGbmsiA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bN8g8/EQJ5JNLmcuNioMXeo6xxPhQlbGMqXyUcnPTkqRMGYI+G4Ejpt9cT2XLx48MsTE+bzhGByG
1H1pqr4NO588pcozvxJ5bo7FJRCIhLP1e3pwipkX+z6IlClWyStmkrlQmh4o/jTM/s88Fv0m7FSH
jNd3hhAeYNPIdw9Btn4UcBuZre9QZnCZ+Qb3nW7FuuEd1RxTmP0y9EFC185+bRy+SMigW3FTt75l
qdmakEvm3BkGv3IiztGz6MLRqvBdHQYtaZ17Jeh1xGZ//F4QzRytN/lcdqSrZA6MOo1ObtGE9SFJ
SDo82E2CZlkQZfPVe6EC4/a7V7wIwES5EDHHnw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ewjro/5A8FySdAgSJfHQFGxdnPvtSB6vt25wsSfZkZlB9FCU7IhXRDEGCyqtZv1GE8Vi5CjQkNFt
lkkrCSRYIU5yoD/IUiSUo3oerXD+F7eyfUTsdMH8pyAOmszG4J/U4h2F0oGz4IGjnQhlKadatt3U
Pet1uDdo6p7Uz7fluWoE453v5O5Ag7QL3l2r7pK9QbtKW2b2ZgHI0FP1PfpuAESmBITtaB68uLNI
9IqIpc/l+MM956Gz3Ei4nFXbBqRkNnOoEIr1KKujTAkLJl3zAW45fRxt/SNdspyyOfwqw8HQ4aKl
7gQZLNfO7M9S9RaTP7tfDlNXrjIs40/SiH7VMA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
BU7byHg11K8bY2oU9sv2hTEzfbBQxIL/wbPRcw3zRiIVklygkCLwToVotzcIxQi5+AgzzF89UJr5
6GTSf74dEO/L+7MiiVhop835AvOvvIFH3e15os3Ed8MZ/CykLdSs8kOVPSgygUECxKL/9FDmPOPu
fo2rClbqDh81jw/cX48EVuss3UxP/PNd7DI06TMx7v4Cwbv+pkvbuSJ9JUQBcJB2a2vbXuFSdPnT
ejL1XTVXeTbl2M6D7N0iqk4rwD1DAC1ao/d+axn50hvVPzigrvjqcQX/U1IENh7yF/bcNB1NT4d2
IdXJlmV2SEYwQNjb9ZTuSLUlehhVKrT3vH5zFJC80glrrjZK2l4tx9ZECJLmYjz00oxWf1dNVI0i
SuSyr3w6cWekzZQOv6vsFN+CRqWOkos5IUF5EaLFMFmcV5BtlgtZ9rm6OCo3zn726oQF5zZNaTBv
qrb5vLe4ELSA4fL4YBwiVDxVDpGpLzJNu+m6WS/V5oWJs1UQV1sRHSGu

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dAIafnl1hEJ76Z8bYZlZKSAU+OyCQ2PwlK+IUKj9QNvxJJYU8c0z5dZmxP4ePLBS+vp0Lekmf+JK
ZmwpMP0AH+BW93Y8Y+QNBeNdszz6mwXF1zf7ZAzf+51PzoZEli3SBCs9JMOdSCtnTg1W+j4FkEYs
NWN3ZK6tfrYSbplsV4lsmoYu2c81xW2Ns3lV8YRQCE8VSADdb1pe8pEztQYXzBmAfCVgwFNJ1kXV
pEtDN1MRi07FvYZeUJ/cX+ebYB0p5w0vxVO4vSr0XOHKMcQkxb/64oEoe4AhHQNWURWYKDxNNzm+
jElAKl1fJL20OmItj+GmJlETFK09uAgqwtZ5HQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7040)
`pragma protect data_block
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
3+Pd1rv24o2VmEALv3PYVSGsjBXBOQrRO9ElGls=
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
