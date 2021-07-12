module hi (
    input clk,
    input rst,
    input HI_W,
    input [31:0] hi_input,
    output [31:0] hi_output
);

reg [31:0] hi_reg;
assign hi_output = hi_reg;
always @(posedge clk or posedge rst) begin
    if(rst)
        hi_reg <= 32'b0;
    else
    begin
        if(HI_W)
            hi_reg <= hi_input;
    end
end
    
endmodule