`timescale 1ns / 1ps
module cp0(
    input clk,
    input rst,
    input exception,
    input mfc0,
    input mtc0,
    input eret,
    input [31:0] pc,
    input [4:0] rd,
    input [31:0] wdata,
    input [4:0] cause,
    output [31:0] rdata,
    output [31:0] status,
    output [31:0] exc_addr
);

reg [31:0]cp0reg[31:0];
parameter STATUS = 12,
          CAUSE = 13,
          EPC = 14;
parameter SYSCALL = 5'b1000,
          BREAK = 5'b1001,
          TEQ = 5'b1101;
parameter STATUS_SYSCALL = 8,
          STATUS_BREAK = 9,
          STATUS_TEQ = 10;
// µ½µ×0ÆÁ±Î»¹ÊÇ1ÆÁ±Î£¿£¿£¿
wire legalException = exception;
assign exc_addr = eret ? cp0reg[EPC] : 32'h00400004;
assign status = cp0reg[STATUS];
assign rdata = mfc0 ? cp0reg[rd] : 32'b0;
// assign rdata = mfc0 ? 32'b1 : 32'b0;
always @(posedge clk or posedge rst) begin
    if(rst)
    begin
        cp0reg[0]<=32'b0;
        cp0reg[1]<=32'b0;
        cp0reg[2]<=32'b0;
        cp0reg[3]<=32'b0;
        cp0reg[4]<=32'b0;
        cp0reg[5]<=32'b0;
        cp0reg[6]<=32'b0;
        cp0reg[7]<=32'b0;
        cp0reg[8]<=32'b0;
        cp0reg[9]<=32'b0;
        cp0reg[10]<=32'b0;
        cp0reg[11]<=32'b0;
        cp0reg[12]<=32'b0;
        cp0reg[13]<=32'b0;
        cp0reg[14]<=32'b0;
        cp0reg[15]<=32'b0;
        cp0reg[16]<=32'b0;
        cp0reg[17]<=32'b0;
        cp0reg[18]<=32'b0;
        cp0reg[19]<=32'b0;
        cp0reg[20]<=32'b0;
        cp0reg[21]<=32'b0;
        cp0reg[22]<=32'b0;
        cp0reg[23]<=32'b0;
        cp0reg[24]<=32'b0;
        cp0reg[25]<=32'b0;
        cp0reg[26]<=32'b0;
        cp0reg[27]<=32'b0;
        cp0reg[28]<=32'b0;
        cp0reg[29]<=32'b0;
        cp0reg[30]<=32'b0;
        cp0reg[31]<=32'b0;
    end
    else
    begin
        if(mtc0)
            cp0reg[rd] <= wdata;
        if(legalException)
        begin
            cp0reg[STATUS] <= cp0reg[STATUS] << 5;
            cp0reg[CAUSE][6:2] <= cause;
            cp0reg[EPC] <= pc;
        end
        if(eret)
            cp0reg[STATUS] <= cp0reg[STATUS] >> 5;
    end
end

endmodule