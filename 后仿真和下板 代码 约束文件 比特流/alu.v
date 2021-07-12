`timescale 1ns / 1ps
module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
reg [32:0] temp;
always@(*)
begin
    case(aluc)
        4'b0000: 
            begin
                temp = {1'b0, a} + {1'b0, b};
                r = temp[31:0];
                zero = (r == 0) ? 1 : 0;
                carry = temp[32];
                negative = r[31];
            end
        4'b0001: 
            begin
                carry = (a < b) ? 1 : 0;
                r = a - b;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b0010: 
            begin
                r = a + b;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
                if((a[31] == 0 && b[31] == 0 && r[31] == 1) || (a[31] == 1 && b[31] == 1 && r[31] == 0))
                    overflow = 1;
                else
                    overflow = 0;
            end
        4'b0011: 
            begin
                r = a - b;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
                if((a[31] == 0 && b[31] == 1 && r[31] == 1) || (a[31] == 1 && b[31] == 0 && r[31] == 0))
                    overflow = 1;
                else
                    overflow = 0;
            end
        4'b0100: 
            begin
                r = a & b;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b0101: 
            begin
                r = a | b;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b0110: 
            begin
                r = a ^ b;
                zero = (r == 0) ? 1 : 0; 
                negative = r[31];
            end
        4'b0111: 
            begin
                r = ~(a | b);
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b1000: 
            begin
                r = {b[15:0], 16'b0};
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b1001: 
            begin
                r = {b[15:0], 16'b0};
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b1010: 
            begin
                r = (a < b) ? 1 : 0;
                zero = (a == b) ? 1 : 0;
                negative = r[31];
                carry = (a < b) ? 1 : 0;
            end
        4'b1011: 
            begin
                if((a[31] == 1 && b[31] == 0) || (a[31] == 1 && b[31] == 1 && a < b) || (a[31] == 0 && b[31] == 0 && a < b))
                    r = 1;
                else
                    r = 0;
                zero = (a == b) ? 1 : 0;
                negative = (r == 1) ? 1 : 0;
            end
        4'b1100: 
            begin
                r = ($signed(b)) >>> a;
                if(a > 32)
                    carry = b[31];
                else if(a == 0)
                    carry = 0;
                else
                    carry = b[a - 1];
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b1101: 
            begin
                r = b >> a;
                if(a > 32)
                    carry = 0;
                else if(a == 0)
                    carry = 0;
                else
                    carry = b[a - 1];
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
            end
        4'b1110: 
            begin
                r = b << a;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
                if(a == 0)
                    carry = 0;
                else if(a > 32)
                    carry = 0;
                else
                    carry = b[32 - a];
            end
        4'b1111:
            begin
                r = b << a;
                zero = (r == 0) ? 1 : 0;
                negative = r[31];
                if(a == 0)
                    carry = 0;
                else if(a > 32)
                    carry = 0;
                else
                    carry = b[32 - a];
            end 
    endcase
end
endmodule
