module sccomp_dataflow (
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
);

wire cs, DM_R, DM_W_W, DM_W_H, DM_W_B;
wire [31:0] DM_data_in;
wire [31:0] DM_data_out;
wire [10:0] pc_imem;
wire [10:0] DM_addr_cpu;
wire [10:0] DM_addr_DM;

assign pc_imem = (pc - 32'h0040_0000) / 4;
assign DM_addr_DM = DM_addr_cpu - 32'h1001_0000;

imem imem_inst(.a(pc_imem), .spo(inst));

dmem dmem_inst(.clk(clk_in), .cs(cs), .DM_R(DM_R), .DM_W_W(DM_W_W), .DM_W_H(DM_W_H), .DM_W_B(DM_W_B), .DM_addr(DM_addr_DM), .DM_data_in(DM_data_in), .DM_data_out(DM_data_out));

cpu sccpu(.clk(clk_in), .rst(reset), .inst(inst), .DM_data_out(DM_data_out), .pc(pc), .DM_cs(cs), .DM_R(DM_R), .DM_W_W(DM_W_W), .DM_W_H(DM_W_H), .DM_W_B(DM_W_B), .DM_addr(DM_addr_cpu), .DM_data_in(DM_data_in));

endmodule