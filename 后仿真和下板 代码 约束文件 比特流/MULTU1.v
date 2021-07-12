`timescale 1ns / 1ps
module MULTU1 (
    input [31:0] a,
    input [31:0] b,
    output [63:0] result
);
wire [63:0] adder[62:0];
assign adder[0] = b[0] ? {32'b0, a} : 64'b0;
assign adder[1] = b[1] ? {31'b0, a, 1'b0} : 64'b0;
assign adder[2] = b[2] ? {30'b0, a, 2'b0} : 64'b0;
assign adder[3] = b[3] ? {29'b0, a, 3'b0} : 64'b0;
assign adder[4] = b[4] ? {28'b0, a, 4'b0} : 64'b0;
assign adder[5] = b[5] ? {27'b0, a, 5'b0} : 64'b0;
assign adder[6] = b[6] ? {26'b0, a, 6'b0} : 64'b0;
assign adder[7] = b[7] ? {25'b0, a, 7'b0} : 64'b0;
assign adder[8] = b[8] ? {24'b0, a, 8'b0} : 64'b0;
assign adder[9] = b[9] ? {23'b0, a, 9'b0} : 64'b0;
assign adder[10] = b[10] ? {22'b0, a, 10'b0} : 64'b0;
assign adder[11] = b[11] ? {21'b0, a, 11'b0} : 64'b0;
assign adder[12] = b[12] ? {20'b0, a, 12'b0} : 64'b0;
assign adder[13] = b[13] ? {19'b0, a, 13'b0} : 64'b0;
assign adder[14] = b[14] ? {18'b0, a, 14'b0} : 64'b0;
assign adder[15] = b[15] ? {17'b0, a, 15'b0} : 64'b0;
assign adder[16] = b[16] ? {16'b0, a, 16'b0} : 64'b0;
assign adder[17] = b[17] ? {15'b0, a, 17'b0} : 64'b0;
assign adder[18] = b[18] ? {14'b0, a, 18'b0} : 64'b0;
assign adder[19] = b[19] ? {13'b0, a, 19'b0} : 64'b0;
assign adder[20] = b[20] ? {12'b0, a, 20'b0} : 64'b0;
assign adder[21] = b[21] ? {11'b0, a, 21'b0} : 64'b0;
assign adder[22] = b[22] ? {10'b0, a, 22'b0} : 64'b0;
assign adder[23] = b[23] ? {9'b0, a, 23'b0} : 64'b0;
assign adder[24] = b[24] ? {8'b0, a, 24'b0} : 64'b0;
assign adder[25] = b[25] ? {7'b0, a, 25'b0} : 64'b0;
assign adder[26] = b[26] ? {6'b0, a, 26'b0} : 64'b0;
assign adder[27] = b[27] ? {5'b0, a, 27'b0} : 64'b0;
assign adder[28] = b[28] ? {4'b0, a, 28'b0} : 64'b0;
assign adder[29] = b[29] ? {3'b0, a, 29'b0} : 64'b0;
assign adder[30] = b[30] ? {2'b0, a, 30'b0} : 64'b0;
assign adder[31] = b[31] ? {1'b0, a, 31'b0} : 64'b0;

assign adder[32] = adder[0] + adder[1];
assign adder[33] = adder[2] + adder[3];
assign adder[34] = adder[4] + adder[5];
assign adder[35] = adder[6] + adder[7];
assign adder[36] = adder[8] + adder[9];
assign adder[37] = adder[10] + adder[11];
assign adder[38] = adder[12] + adder[13];
assign adder[39] = adder[14] + adder[15];
assign adder[40] = adder[16] + adder[17];
assign adder[41] = adder[18] + adder[19];
assign adder[42] = adder[20] + adder[21];
assign adder[43] = adder[22] + adder[23];
assign adder[44] = adder[24] + adder[25];
assign adder[45] = adder[26] + adder[27];
assign adder[46] = adder[28] + adder[29];
assign adder[47] = adder[30] + adder[31];

assign adder[48] = adder[32] + adder[33];
assign adder[49] = adder[34] + adder[35];
assign adder[50] = adder[36] + adder[37];
assign adder[51] = adder[38] + adder[39];
assign adder[52] = adder[40] + adder[41];
assign adder[53] = adder[42] + adder[43];
assign adder[54] = adder[44] + adder[45];
assign adder[55] = adder[46] + adder[47];

assign adder[56] = adder[48] + adder[49];
assign adder[57] = adder[50] + adder[51];
assign adder[58] = adder[52] + adder[53];
assign adder[59] = adder[54] + adder[55];

assign adder[60] = adder[56] + adder[57];
assign adder[61] = adder[58] + adder[59];

assign adder[62] = adder[60] + adder[61];

assign result = adder[62];

endmodule