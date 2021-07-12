`timescale 1ns / 1ps
module dmem (
    input clk,
    input cs,
    input DM_R,
    input DM_W_W,
    input DM_W_H,
    input DM_W_B,
    input [10:0] DM_addr,
    input [31:0] DM_data_in,
    output [31:0] DM_data_out
);

reg [7:0] mem [0:1023];
always @ (posedge clk)
begin
    if(cs && DM_W_W)
    begin
        mem[DM_addr] <= DM_data_in[7:0];
        mem[DM_addr + 1] <= DM_data_in[15:8];
        mem[DM_addr + 2] <= DM_data_in[23:16];
        mem[DM_addr + 3] <= DM_data_in[31:24];
    end
    else if(cs && DM_W_H)
    begin
        mem[DM_addr] <= DM_data_in[7:0];
        mem[DM_addr + 1] <= DM_data_in[15:8];
    end
    else if(cs && DM_W_B)
    begin
        mem[DM_addr] <= DM_data_in[7:0];
    end
end

assign DM_data_out[7:0] = (cs && DM_R) ? mem[DM_addr] : {32{1'bz}};
assign DM_data_out[15:8] = (cs && DM_R) ? mem[DM_addr + 1] : {32{1'bz}};
assign DM_data_out[23:16] = (cs && DM_R) ? mem[DM_addr + 2] : {32{1'bz}};
assign DM_data_out[31:24] = (cs && DM_R) ? mem[DM_addr + 3] : {32{1'bz}};

endmodule