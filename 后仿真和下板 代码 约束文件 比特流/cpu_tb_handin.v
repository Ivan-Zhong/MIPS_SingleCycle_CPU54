`timescale 1ns / 1ps
module cpu_tb ();
reg clk, rst;
wire [7:0] seg;
wire [7:0] sel;

sccomp_dataflow uut(.clk_in(clk), .reset(rst), .o_seg(seg), .o_sel(sel));

initial begin
    rst = 0;
    #5 rst = 1;
    #5 rst = 0;
    clk = 1;
end

always
begin
    #5 clk = ~clk;
end

endmodule