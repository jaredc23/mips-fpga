`timescale 1ns / 1ps


module instruction_decoder(
	input [15:0] instruction,
	output reg RegWrite,
	output reg RegDst,
	output reg [7:0] Instr_i,
	output reg ALUSrc1,
	output reg ALUSrc2,
	output reg [2:0] ALUOp,
	output reg MemWrite,
	output wire [3:0] opcode,
	output reg MemToReg,
	output reg [1:0] rs_addr,
	output reg [1:0] rt_addr,
	output reg [1:0] rd_addr
);

	always @(instruction) begin
		case (instruction[15:12])
			4'd0:	begin //Load Word (lw)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b0;
				MemWrite <= 1'b0;
				MemToReg <= 1'b1;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[9:8];
				Instr_i <= instruction[7:0];
			end
			4'd1:	begin //Store Word (sw)
				RegDst <= 1'b0;
				RegWrite <= 1'b0;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b0;
				MemWrite <= 1'b1;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[9:8];
				Instr_i <= instruction[7:0];
			end
			4'd2:	begin //Add (add)
				RegDst <= 1'b1;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b0;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[7:6];
				Instr_i <= instruction[5:0];
			end
			4'd3:	begin //Add Immediate (addi)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b0;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= 0;
				Instr_i <= instruction[7:0];
			end
			4'd4:	begin //Invert inv
				RegDst <= 1'b1;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b1;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b1;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[7:6];
				Instr_i <= instruction[5:0];
			end
			4'd5:	begin //And (and)
				RegDst <= 1'b1;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b10;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[7:6];
				Instr_i <= instruction[5:0];
			end
			4'd6:	begin //And Immediate (andi)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b10;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= 0;
				Instr_i <= instruction[7:0];
			end
			4'd7:	begin //Or (or)
				RegDst <= 1'b1;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b11;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[7:6];
				Instr_i <= instruction[5:0];
			end
			4'd8:	begin //Or Immediate (or)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b11;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= 0;
				Instr_i <= instruction[7:0];
			end
			4'd9:	begin //Shift right arithmetic (sra)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b100;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= 0;
				Instr_i <= instruction[7:0];
			end
			4'd10:	begin //Shift left logical (sll)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b1;
				ALUOp <= 3'b101;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= 0;
				Instr_i <= instruction[7:0];
			end
			4'd11:	begin //Branch if equal (beq)
				RegDst <= 1'b0;
				RegWrite <= 1'b0;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b110;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[9:8];
				Instr_i <= instruction[7:0];
			end
			4'd12:	begin //Branch if not equal (bne)
				RegDst <= 1'b0;
				RegWrite <= 1'b0;
				ALUSrc1 <= 1'b0;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b111;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[9:8];
				Instr_i <= instruction[7:0];
			end
			4'd13:	begin //Clear Register (clr)
				RegDst <= 1'b0;
				RegWrite <= 1'b1;
				ALUSrc1 <= 1'b1;
				ALUSrc2 <= 1'b0;
				ALUOp <= 3'b10;
				MemWrite <= 1'b0;
				MemToReg <= 1'b0;
				rs_addr <= instruction[11:10];
				rt_addr <= instruction[9:8];
				rd_addr <= instruction[7:6];
				Instr_i <= instruction[5:0];
			end

		endcase
	end

	assign opcode = instruction[15:12];

endmodule
