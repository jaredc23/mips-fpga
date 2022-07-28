`timescale 1ns / 1ps

module program_counter(
    input wire clk,
    input wire rst,
    input wire [7:0] imm,
    input wire take_branch,
    output reg [7:0] pc
    );
    
 reg inc;
    
always @(posedge clk or posedge rst) begin

	if(rst) begin
		pc <= 0;
		inc <= 1;
	end
	else begin
		if(inc) begin
			if(take_branch) begin
				pc <= pc + imm;
				inc <= ~inc;
			end
			else begin
				pc <= pc + 1;
				inc <= ~inc;
			end
		end
		else begin
			inc <= ~inc;
		end
	end
end    

endmodule
