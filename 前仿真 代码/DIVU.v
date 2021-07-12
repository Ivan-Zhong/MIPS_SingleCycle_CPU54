module DIVU(
    input [31:0] dividend,
    input [31:0] divisor,
    input start,
    input clock,
    input reset,
    output [31:0] q,
    output [31:0] r,
    output busy
);

reg [63:0] temp;
reg [6:0] count;
reg regbusy;

always@(clock or posedge reset)
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
            temp <= {32'b0, dividend};
            count <= 32;
        end
        else
        begin
            if(count)
            begin
                temp = {temp[62:0], 1'b0};
                if(temp[63:32] >= divisor)
                begin
                    temp[63:32] = temp[63:32] - divisor;
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

assign q = temp[31:0];
assign r = temp[63:32];
assign busy = regbusy;

endmodule