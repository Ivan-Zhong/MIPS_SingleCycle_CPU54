module clz (
    input [31:0] input_data,
    output [31:0] zero_number
);
assign zero_number = 
(input_data[31:0] == 32'b0) ? 32 :
(input_data[31:1] == 31'b0) ? 31 :
(input_data[31:2] == 30'b0) ? 30 :
(input_data[31:3] == 29'b0) ? 29 :
(input_data[31:4] == 28'b0) ? 28 :
(input_data[31:5] == 27'b0) ? 27 :
(input_data[31:6] == 26'b0) ? 26 :
(input_data[31:7] == 25'b0) ? 25 :
(input_data[31:8] == 24'b0) ? 24 :
(input_data[31:9] == 23'b0) ? 23 :
(input_data[31:10] == 22'b0) ? 22 :
(input_data[31:11] == 21'b0) ? 21 :
(input_data[31:12] == 20'b0) ? 20 :
(input_data[31:13] == 19'b0) ? 19 :
(input_data[31:14] == 18'b0) ? 18 :
(input_data[31:15] == 17'b0) ? 17 :
(input_data[31:16] == 16'b0) ? 16 :
(input_data[31:17] == 15'b0) ? 15 :
(input_data[31:18] == 14'b0) ? 14 :
(input_data[31:19] == 13'b0) ? 13 :
(input_data[31:20] == 12'b0) ? 12 :
(input_data[31:21] == 11'b0) ? 11 :
(input_data[31:22] == 10'b0) ? 10 :
(input_data[31:23] == 9'b0) ? 9 :
(input_data[31:24] == 8'b0) ? 8 :
(input_data[31:25] == 7'b0) ? 7 :
(input_data[31:26] == 6'b0) ? 6 :
(input_data[31:27] == 5'b0) ? 5 :
(input_data[31:28] == 4'b0) ? 4 :
(input_data[31:29] == 3'b0) ? 3 :
(input_data[31:30] == 2'b0) ? 2 :
(input_data[31] == 1'b0) ? 1 : 0;

endmodule