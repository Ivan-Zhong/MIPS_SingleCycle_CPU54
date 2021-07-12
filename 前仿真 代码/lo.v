module lo (
    input clk,
    input rst,
    input LO_W,
    input [31:0] lo_input,
    output [31:0] lo_output
);

reg [31:0] lo_reg;
assign lo_output = lo_reg;
always @(posedge clk or posedge rst) begin
    if(rst)
        lo_reg <= 32'b0;
    else
    begin
        if(LO_W)
            lo_reg <= lo_input;
    end
end
    
endmodule