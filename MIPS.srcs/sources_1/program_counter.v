`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2022 09:02:20 PM
// Design Name: 
// Module Name: program_counter
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
