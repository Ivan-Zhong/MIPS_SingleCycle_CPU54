`timescale 1ns / 1ps
module clock_divider #(parameter div_value = 1) (
    input clk,
    output reg divided_clk = 0
);
    // div_value = ((100M / desired_freq) / 2) - 1
    integer count = 0;
    always@(posedge clk)
    begin
        if(count == div_value)
        begin
            count <= 0;
            divided_clk <= ~divided_clk;
        end
        else
            count <= count + 1;
    end  
endmodule
