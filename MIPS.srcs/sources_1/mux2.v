`timescale 1ns / 1ps
module mux2(
		a, b, sel, out
	);
parameter WIDTH = 8;
	
input wire [WIDTH:0] a, b;
input wire sel;
output wire [WIDTH:0] out;

assign out = sel? b : a;
	
endmodule


module mux2bit(
		a, b, sel, out
	);
parameter WIDTH = 1;
	
input wire [WIDTH:0] a, b;
input wire sel;
output wire [WIDTH:0] out;

assign out = sel? b : a;
	
endmodule
