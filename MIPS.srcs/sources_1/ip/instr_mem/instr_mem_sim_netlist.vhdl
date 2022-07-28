-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Wed Jul 27 19:30:21 2022
-- Host        : DESKTOP-F3JRP19 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {c:/Users/Jared/Desktop/Projects/MIPS
--               Processor/MIPS.srcs/sources_1/ip/instr_mem/instr_mem_sim_netlist.vhdl}
-- Design      : instr_mem
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
`protect begin_protected
`protect version = 1
`protect encrypt_agent = "XILINX"
`protect encrypt_agent_info = "Xilinx Encryption Tool 2021.1"
`protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`protect key_block
JqLVJNxQZkLohSEqQ9ITFybNm9QPcaTh8kyc7h4uGNwD1GaEe9dZHqj61sUilGTlF+FUk7afNjXe
+9yQ4e75SyWC3Z6F0o0CdI6t84E2VRqNvne6PMLMbSrRPmTgt8cbodbZa3saUKncQltVwK/zTxXc
dXyeIJwoVnylCRZ8MPU=

`protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
RMR60V/K16S3hDpcgdlFzH6vzNttFBxzcEIP9k8l6xLxOXzEGeRk2beZg3IkkpX9ywpiLolj/ijd
pAlaBccK0sBT48q6qTKLouly7vRT3U8EOwOAJBZoDUnL/NwrlIomkg8Pj/4x8iecc9IFkdcLg53k
dreGnJ/4ti8Qi6sHP5Vsy0qpJoYpWsOBc2cmgH9vayWn6WlV7QL8YjnFQ6bQnWuyarN2QQK+bLzc
JrPAdTBzH05U9MiHwKRG1GlZxJA5fxQttnLA39Nwggz6r5qeYai4Vo+J8h0NQDa/GYHeYKSYsF9p
VKrYe14mz3CSYvF3+NMCtnCz+VeW7lF95iKCXA==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`protect key_block
k6iMAgjYok8KaQLMY/TME6/aSCYTKFMZWtHwbD2VKIKOoM9woUSioI0NuiYfkPizuiBJEl8Af3NJ
M5VmpW3SVM0lwPjVSCSNmHMIfc2krrmg962M4XaG4w+tnp7hwZbdNZ8ahj6pOLDYSTGKwdGQanuk
rIQbC+15rT9WEK2XGDQ=

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
lHyAdhaPyzMCy12MalQZTt5ud3be/nityQmJ518pNrYUzgCs2nz/J1pZZgf+RWFgX9JUwWOgttjl
3vfihnzL/+pRWaWe8tlTToa5xX6V/jpw3hAcktXx9YKYreiOr2qpeTLkbp0k6MDPx0OZ6zF6OnXU
mj71WlXFOMXCx/95ZDxCuphivrOiA+pFZwGv2NIFmX/Oh4q8NTSFzJYzF3L9rWrI08UUEu9QuuxY
Iqlhuw+fXq//x9+jC7JNcedTSCXVkefBvZdJcbH0kbNA5ChG445apiF/OiKhKxTUjVKp7Rkm62fE
cFEo6KH1Cp+QaVxNQ55dcOTpVSSDpQGvshrQzw==

`protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
D53lVPGhmka10zY9LQFvI7i1UPoiOm2NaQ+1PpDUs4OCbAMqPLHQSHIZ3EMPWpwgdfAtW9t+9lxl
o33XZq60DBUJ4ZKPRvcfbZCHmpPyjm3Rs8+ACxnIH7G37stehOSCzSXeqM9ORqajk0MjoE3bDLx9
FtW+eEPY1KauFU6KHAWAdaZPPnc5QfgBkK0c27Y7CfkJ049Sjv4lFwtiVOmSkCvdDDisv3/WAcSs
c5Zo+cJIWzw/prfWYTGIB0goZNZRXZpB/aULwQ5itLufopA2f9cHo50fqlIvQX4YoYlfQTXpj3Lj
Qd+7/1UmFCqQLsnOUXy9D/tgspVDu7POGbmsiA==

`protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
bN8g8/EQJ5JNLmcuNioMXeo6xxPhQlbGMqXyUcnPTkqRMGYI+G4Ejpt9cT2XLx48MsTE+bzhGByG
1H1pqr4NO588pcozvxJ5bo7FJRCIhLP1e3pwipkX+z6IlClWyStmkrlQmh4o/jTM/s88Fv0m7FSH
jNd3hhAeYNPIdw9Btn4UcBuZre9QZnCZ+Qb3nW7FuuEd1RxTmP0y9EFC185+bRy+SMigW3FTt75l
qdmakEvm3BkGv3IiztGz6MLRqvBdHQYtaZ17Jeh1xGZ//F4QzRytN/lcdqSrZA6MOo1ObtGE9SFJ
SDo82E2CZlkQZfPVe6EC4/a7V7wIwES5EDHHnw==

`protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
Ewjro/5A8FySdAgSJfHQFGxdnPvtSB6vt25wsSfZkZlB9FCU7IhXRDEGCyqtZv1GE8Vi5CjQkNFt
lkkrCSRYIU5yoD/IUiSUo3oerXD+F7eyfUTsdMH8pyAOmszG4J/U4h2F0oGz4IGjnQhlKadatt3U
Pet1uDdo6p7Uz7fluWoE453v5O5Ag7QL3l2r7pK9QbtKW2b2ZgHI0FP1PfpuAESmBITtaB68uLNI
9IqIpc/l+MM956Gz3Ei4nFXbBqRkNnOoEIr1KKujTAkLJl3zAW45fRxt/SNdspyyOfwqw8HQ4aKl
7gQZLNfO7M9S9RaTP7tfDlNXrjIs40/SiH7VMA==

`protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`protect key_block
BU7byHg11K8bY2oU9sv2hTEzfbBQxIL/wbPRcw3zRiIVklygkCLwToVotzcIxQi5+AgzzF89UJr5
6GTSf74dEO/L+7MiiVhop835AvOvvIFH3e15os3Ed8MZ/CykLdSs8kOVPSgygUECxKL/9FDmPOPu
fo2rClbqDh81jw/cX48EVuss3UxP/PNd7DI06TMx7v4Cwbv+pkvbuSJ9JUQBcJB2a2vbXuFSdPnT
ejL1XTVXeTbl2M6D7N0iqk4rwD1DAC1ao/d+axn50hvVPzigrvjqcQX/U1IENh7yF/bcNB1NT4d2
IdXJlmV2SEYwQNjb9ZTuSLUlehhVKrT3vH5zFJC80glrrjZK2l4tx9ZECJLmYjz00oxWf1dNVI0i
SuSyr3w6cWekzZQOv6vsFN+CRqWOkos5IUF5EaLFMFmcV5BtlgtZ9rm6OCo3zn726oQF5zZNaTBv
qrb5vLe4ELSA4fL4YBwiVDxVDpGpLzJNu+m6WS/V5oWJs1UQV1sRHSGu

`protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`protect key_block
dAIafnl1hEJ76Z8bYZlZKSAU+OyCQ2PwlK+IUKj9QNvxJJYU8c0z5dZmxP4ePLBS+vp0Lekmf+JK
ZmwpMP0AH+BW93Y8Y+QNBeNdszz6mwXF1zf7ZAzf+51PzoZEli3SBCs9JMOdSCtnTg1W+j4FkEYs
NWN3ZK6tfrYSbplsV4lsmoYu2c81xW2Ns3lV8YRQCE8VSADdb1pe8pEztQYXzBmAfCVgwFNJ1kXV
pEtDN1MRi07FvYZeUJ/cX+ebYB0p5w0vxVO4vSr0XOHKMcQkxb/64oEoe4AhHQNWURWYKDxNNzm+
jElAKl1fJL20OmItj+GmJlETFK09uAgqwtZ5HQ==

`protect data_method = "AES128-CBC"
`protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11680)
`protect data_block
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
`protect end_protected
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity instr_mem is
  port (
    a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of instr_mem : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of instr_mem : entity is "instr_mem,dist_mem_gen_v8_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of instr_mem : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of instr_mem : entity is "dist_mem_gen_v8_0_13,Vivado 2021.1";
end instr_mem;

architecture STRUCTURE of instr_mem is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "zynq";
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 0;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of U0 : label is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 8;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 256;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_clk : integer;
  attribute c_has_clk of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "instr_mem.mif";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 1;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 16;
  attribute is_du_within_envelope : string;
  attribute is_du_within_envelope of U0 : label is "true";
begin
U0: entity work.instr_mem_dist_mem_gen_v8_0_13
     port map (
      a(7 downto 0) => a(7 downto 0),
      clk => '0',
      d(15 downto 0) => B"0000000000000000",
      dpo(15 downto 0) => NLW_U0_dpo_UNCONNECTED(15 downto 0),
      dpra(7 downto 0) => B"00000000",
      i_ce => '1',
      qdpo(15 downto 0) => NLW_U0_qdpo_UNCONNECTED(15 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(15 downto 0) => NLW_U0_qspo_UNCONNECTED(15 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(15 downto 0) => spo(15 downto 0),
      we => '0'
    );
end STRUCTURE;
