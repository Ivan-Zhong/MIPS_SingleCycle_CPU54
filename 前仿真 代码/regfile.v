module regfile (
    input clk,
    input rst,
    input RF_W,
    input [31:0] rd,
    input [4:0] rdc,
    input [4:0] rtc,
    input [4:0] rsc,
    output [31:0] rs,
    output [31:0] rt
);
reg [31:0] array_reg[31:0];

always @ (posedge clk or posedge rst)
begin
    if(rst)
    begin
        array_reg[0] <= 32'b0;
        array_reg[1] <= 32'b0;
        array_reg[2] <= 32'b0;
        array_reg[3] <= 32'b0;
        array_reg[4] <= 32'b0;
        array_reg[5] <= 32'b0;
        array_reg[6] <= 32'b0;
        array_reg[7] <= 32'b0;
        array_reg[8] <= 32'b0;
        array_reg[9] <= 32'b0;
        array_reg[10] <= 32'b0;
        array_reg[11] <= 32'b0;
        array_reg[12] <= 32'b0;
        array_reg[13] <= 32'b0;
        array_reg[14] <= 32'b0;
        array_reg[15] <= 32'b0;
        array_reg[16] <= 32'b0;
        array_reg[17] <= 32'b0;
        array_reg[18] <= 32'b0;
        array_reg[19] <= 32'b0;
        array_reg[20] <= 32'b0;
        array_reg[21] <= 32'b0;
        array_reg[22] <= 32'b0;
        array_reg[23] <= 32'b0;
        array_reg[24] <= 32'b0;
        array_reg[25] <= 32'b0;
        array_reg[26] <= 32'b0;
        array_reg[27] <= 32'b0;
        array_reg[28] <= 32'b0;
        array_reg[29] <= 32'b0;
        array_reg[30] <= 32'b0;
        array_reg[31] <= 32'b0;
    end
    else
    begin
        if(RF_W && rdc != 0)
        begin
            array_reg[rdc] <= rd;
            array_reg[0] <= 32'b0;
        end
    end
end

assign rs = array_reg[rsc];
assign rt = array_reg[rtc];

endmodule