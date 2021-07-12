module MULT1 (
    input [31:0] a,
    input [31:0] b,
    output [63:0] result
);

wire sign;
assign sign = (a[31] == 0) ? ((b[31] == 0) ? 1'b0 : 1'b1) : ((b[31] == 0) ? 1'b1 : 1'b0);
wire [31:0] posa;
wire [31:0] posb;
assign posa = a[31] ? ~a + 1 : a;
assign posb = b[31] ? ~b + 1 : b;
wire [63:0] adder[62:0];
assign adder[0] = posb[0] ? {32'b0, posa} : 64'b0;
assign adder[1] = posb[1] ? {31'b0, posa, 1'b0} : 64'b0;
assign adder[2] = posb[2] ? {30'b0, posa, 2'b0} : 64'b0;
assign adder[3] = posb[3] ? {29'b0, posa, 3'b0} : 64'b0;
assign adder[4] = posb[4] ? {28'b0, posa, 4'b0} : 64'b0;
assign adder[5] = posb[5] ? {27'b0, posa, 5'b0} : 64'b0;
assign adder[6] = posb[6] ? {26'b0, posa, 6'b0} : 64'b0;
assign adder[7] = posb[7] ? {25'b0, posa, 7'b0} : 64'b0;
assign adder[8] = posb[8] ? {24'b0, posa, 8'b0} : 64'b0;
assign adder[9] = posb[9] ? {23'b0, posa, 9'b0} : 64'b0;
assign adder[10] = posb[10] ? {22'b0, posa, 10'b0} : 64'b0;
assign adder[11] = posb[11] ? {21'b0, posa, 11'b0} : 64'b0;
assign adder[12] = posb[12] ? {20'b0, posa, 12'b0} : 64'b0;
assign adder[13] = posb[13] ? {19'b0, posa, 13'b0} : 64'b0;
assign adder[14] = posb[14] ? {18'b0, posa, 14'b0} : 64'b0;
assign adder[15] = posb[15] ? {17'b0, posa, 15'b0} : 64'b0;
assign adder[16] = posb[16] ? {16'b0, posa, 16'b0} : 64'b0;
assign adder[17] = posb[17] ? {15'b0, posa, 17'b0} : 64'b0;
assign adder[18] = posb[18] ? {14'b0, posa, 18'b0} : 64'b0;
assign adder[19] = posb[19] ? {13'b0, posa, 19'b0} : 64'b0;
assign adder[20] = posb[20] ? {12'b0, posa, 20'b0} : 64'b0;
assign adder[21] = posb[21] ? {11'b0, posa, 21'b0} : 64'b0;
assign adder[22] = posb[22] ? {10'b0, posa, 22'b0} : 64'b0;
assign adder[23] = posb[23] ? {9'b0, posa, 23'b0} : 64'b0;
assign adder[24] = posb[24] ? {8'b0, posa, 24'b0} : 64'b0;
assign adder[25] = posb[25] ? {7'b0, posa, 25'b0} : 64'b0;
assign adder[26] = posb[26] ? {6'b0, posa, 26'b0} : 64'b0;
assign adder[27] = posb[27] ? {5'b0, posa, 27'b0} : 64'b0;
assign adder[28] = posb[28] ? {4'b0, posa, 28'b0} : 64'b0;
assign adder[29] = posb[29] ? {3'b0, posa, 29'b0} : 64'b0;
assign adder[30] = posb[30] ? {2'b0, posa, 30'b0} : 64'b0;
assign adder[31] = posb[31] ? {1'b0, posa, 31'b0} : 64'b0;

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

assign result = sign ? ~adder[62] + 1 : adder[62];

endmodule