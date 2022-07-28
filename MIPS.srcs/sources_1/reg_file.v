`timescale 1ns / 1ps

module reg_file(
		rst, clk, wr_en,
		rd0_addr, rd1_addr, wr_addr,
		wr_data, rd0_data, rd1_data
	);
input wire rst, clk, wr_en;
input wire [1:0] rd0_addr, rd1_addr, wr_addr;
input wire [8:0] wr_data;
output reg [8:0] rd0_data = 0, rd1_data = 0;
			
parameter WIDTH = 9, DEPTH = 4;
	
reg [WIDTH-1:0] regfile [0:DEPTH-1];

integer i;

always @ (posedge clk or posedge rst)begin
    if (rst)begin
        for(i = 0; i < WIDTH; i = i + 1) begin
            regfile[i] <= 0;
        end
        rd0_data <= 0;
        rd1_data <= 0;
    end
    else begin
        regfile[wr_addr] <= wr_en ? wr_data : regfile[wr_addr];
        rd0_data <= regfile[rd0_addr];
	    rd1_data <= regfile[rd1_addr];
    end
end

endmodule




//initial begin
//	for(i = 0; i < WIDTH; i = i + 1) begin
//		regfile[i] <= 0;
//	end
//end

//always @(posedge clk) begin
//	rd0_data <= regfile[rd0_addr];
//	rd1_data <= regfile[rd1_addr];
//end

//always @(clk, wr_data, wr_addr) begin
//	if(wr_en) begin
//		regfile[wr_addr] <= wr_data;
//	end
//end

//always @(posedge rst) begin
//	for(i = 0; i < WIDTH; i = i + 1) begin
//		regfile[i] <= 0;
//	end
//end
	
