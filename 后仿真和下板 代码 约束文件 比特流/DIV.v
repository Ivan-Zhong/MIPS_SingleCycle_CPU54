`timescale 1ns / 1ps
module DIV(
    input [31:0] dividend,
    input [31:0] divisor,
    input start,
    input clock,
    input reset,
    output [31:0] q,
    output [31:0] r,
    output busy
);

wire [31:0] posdividend;
wire [31:0] posdivisor;
reg [63:0] temp;
reg [6:0] count;
reg regbusy;

assign posdividend = dividend[31] ? ~dividend + 1 : dividend;
assign posdivisor = divisor[31] ? ~divisor + 1 : divisor;

always@(posedge clock or negedge clock or posedge reset)
begin
    if(reset)
    begin
        temp <= 0;
        count <= 32;
        regbusy <= 0;
    end
    else if(clock == 0) // Ê±ÖÓÏÂ½µÑØ
    begin
        if(start)
        begin
            regbusy <= 1;
            temp <= {32'b0, posdividend};
            count <= 32;
        end
        else
        begin
            if(count)
            begin
                temp = {temp[62:0], 1'b0};
                if(temp[63:32] >= posdivisor)
                begin
                    temp[63:32] = temp[63:32] - posdivisor;
                    temp = temp + 1;
                end
                count = count - 1;
            end
        end
    end
    else
    begin
        if(count == 0)
            regbusy = 0; 
    end
end

assign q = (dividend[31] ^ divisor[31]) ? ~temp[31:0] + 1 : temp[31:0]; 
assign r = dividend[31] ? ~temp[63:32] + 1 : temp[63:32];
assign busy = regbusy;

endmodule