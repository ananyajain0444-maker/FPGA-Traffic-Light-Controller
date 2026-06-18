module timer(
    input clk,
    input rst,
    input tick,
    output reg [7:0] count
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        count <= 0;
    else if(tick)
        count <= count + 1;
end

endmodule