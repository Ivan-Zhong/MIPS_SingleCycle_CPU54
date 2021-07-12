`timescale 1ns / 1ps
module pcreg (
    input clk,
    input rst,
    input [31:0] newpc,
    output reg [31:0] pc
);

always @ (negedge clk or posedge rst)
begin
    if(rst)
        pc = 32'h0040_0000;
    else
        pc = newpc;
end
    
endmodule