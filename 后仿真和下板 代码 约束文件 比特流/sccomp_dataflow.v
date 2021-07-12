`timescale 1ns / 1ps
module sccomp_dataflow (
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel
);

wire cs, DM_R, DM_W_W, DM_W_H, DM_W_B;
wire [31:0] DM_data_in;
wire [31:0] DM_data_out;
wire [10:0] pc_imem;
wire [10:0] DM_addr_cpu;
wire [10:0] DM_addr_DM;
wire [31:0] inst;
wire [31:0] pc;

wire clk;

assign pc_imem = (pc - 32'h0040_0000) / 4;
assign DM_addr_DM = DM_addr_cpu - 32'h1001_0000;

clock_divider #(3) cpu_clk(.clk(clk_in), .divided_clk(clk));

imem imem_inst(.a(pc_imem), .spo(inst));

dmem dmem_inst(.clk(clk), .cs(cs), .DM_R(DM_R), .DM_W_W(DM_W_W), .DM_W_H(DM_W_H), .DM_W_B(DM_W_B), .DM_addr(DM_addr_DM), .DM_data_in(DM_data_in), .DM_data_out(DM_data_out));

cpu sccpu(.clk(clk), .rst(reset), .inst(inst), .DM_data_out(DM_data_out), .pc(pc), .DM_cs(cs), .DM_R(DM_R), .DM_W_W(DM_W_W), .DM_W_H(DM_W_H), .DM_W_B(DM_W_B), .DM_addr(DM_addr_cpu), .DM_data_in(DM_data_in));

seg7x16 seg_inst(.clk(clk_in), .reset(reset), .cs(1), .i_data(pc), .o_seg(o_seg), .o_sel(o_sel));

endmodule