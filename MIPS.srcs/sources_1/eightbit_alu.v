`timescale 1ns / 1ps

module eightbit_alu(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire[2:0] s,
    output reg [7:0]f,
    output reg ovf, take_branch
);

reg carryout;

always @ (s or a or b)
    case (s)
        3'd0: 
            begin
            	take_branch <= 0;
                {carryout, f} = a + b;
                ovf = a[7]^b[7]^f[7]^carryout;
            end
        3'd1: 
            begin
            	take_branch <= 0;
                f <= ~b;
                ovf <= 0;
            end
        3'd2:
            begin
            	take_branch <= 0;
                f <= a & b;
                ovf <= 0;
            end
        3'd3:
            begin
            	take_branch <= 0;
                f <= a | b;
                ovf <= 0; 
            end
        3'd4:
            begin
                f <= $signed(a) >>> 1;
                take_branch <= 0;
                ovf <= 0; 
            end
        3'd5:
            begin
            	take_branch <= 0;
                f <= (a << b);
                ovf <= 0; 
            end
        3'd6:
            begin
            	take_branch <= (a == b);
                f <= 0;
                ovf <= 0; 
            end
        3'd7:
            begin
            	take_branch <= (a != b);
                f <= 0;
                ovf <= 0; 
            end  
        default:
            begin
            	take_branch <= 0;
                ovf <= 0;
                f <= 8'd0;
            end
    endcase
endmodule
