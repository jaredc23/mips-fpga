`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2022 09:14:48 PM
// Design Name: 
// Module Name: lab7_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor_tb();

	reg pb_clk_debounced = 0;
	wire [7:0] pc;
	wire [7:0] alu_output;
	
	
	wire [7:0] alu_input1, alu_input2;
	
	wire [2:0] ALUOp;
	wire       alu_ovf;
	wire       take_branch;
	
	wire [15:0] instruction;
	//insturction fields
	wire [3:0] opcode;
	wire [1:0] rs_addr;
	wire [1:0] rt_addr;
	wire [1:0] rd_addr;
	wire [7:0] immediate;
	//control signals
	wire RegDst;
	wire RegWrite;
	wire ALUSrc1;
	wire ALUSrc2;
	wire MemWrite;
	wire MemToReg;
	
	wire [1:0] regfile_WriteAddress;//destination register address
	wire [8:0] regfile_WriteData;//result data
	wire [8:0] regfile_ReadData1;//source register1 data
	wire [8:0] regfile_ReadData2;//source register2 data
	
	wire [8:0] alu_result;
	wire [8:0] Data_Mem_Out;
	wire [7:0] zero_register;
	
	// PC and debouce clock
	
	
	reg rst_general = 0;
	
	assign zero_register = 8'b0;	//ZERO constant
	assign alu_result = {alu_ovf, alu_output};

program_counter PC(
 	.clk(pb_clk_debounced),
 	.rst(rst_general),
 	.take_branch(take_branch),
 	.imm(immediate),
 	.pc(pc)
);  
	//Instantiate Your instruction Memory here
instr_mem MEM (
  .a(pc),      // input wire [7 : 0] a
  .spo(instruction)  // output wire [15 : 0] spo
);   


mux2bit addrmux(
	.a(rt_addr),
	.b(rd_addr),
	.sel(RegDst),
	.out(regfile_WriteAddress)
);

instruction_decoder decoder(
	.instruction(instruction),
	.RegWrite(RegWrite),
	.RegDst(RegDst),
	.Instr_i(immediate),
	.ALUSrc1(ALUSrc1),
	.ALUSrc2(ALUSrc2),
	.ALUOp(ALUOp),
	.MemWrite(MemWrite),
	.opcode(opcode),
	.MemToReg(MemToReg),
	.rs_addr(rs_addr),
	.rt_addr(rt_addr),
	.rd_addr(rd_addr)
);
	
reg_file regfile(
	.rst(rst_general), 
	.clk(pb_clk_debounced), 
	.wr_en(RegWrite),
	.rd0_addr(rs_addr),
	.rd1_addr(rt_addr),
	.wr_addr(regfile_WriteAddress),
	.wr_data(regfile_WriteData),
	.rd0_data(regfile_ReadData1),
	.rd1_data(regfile_ReadData2)
);
   // Instantiate Muxes here
mux2 regmux(
	.a(regfile_ReadData1),
	.b(zero_register),
	.sel(ALUSrc1),
	.out(alu_input1)
);

mux2 instrmux(
	.a(regfile_ReadData2),
	.b(immediate),
	.sel(ALUSrc2),
	.out(alu_input2)
);
// Instantiate ALU module here
eightbit_alu ALU(
	.a(alu_input1),
	.b(alu_input2),
	.s(ALUOp),
	.f(alu_output),
	.ovf(alu_ovf),
	.take_branch(take_branch)
);	
	
    /* Instantiate the data memory that you have created here*/	
data_memory mem (
  .a(alu_output),      // input wire [7 : 0] a
  .d(regfile_ReadData2),      // input wire [8 : 0] d
  .clk(pb_clk_debounced),  // input wire clk
  .we(MemWrite),    // input wire we
  .spo(Data_Mem_Out)  // output wire [8 : 0] spo
);

mux2 memorymux(
	.a(alu_result),
	.b(Data_Mem_Out),
	.sel(MemToReg),
	.out(regfile_WriteData)
);


initial begin
	rst_general = 1;
	#5 rst_general = 0;
	forever
	#5 pb_clk_debounced = ~pb_clk_debounced;
end

endmodule
