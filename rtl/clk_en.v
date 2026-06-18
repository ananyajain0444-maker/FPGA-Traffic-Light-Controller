module clk_en(
    input clk,
    input rst,
    output reg tick
);

reg [23:0] count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 0;
        tick <= 0;
    end
    else
    begin
        if(count == 10)
        begin
            count <= 0;
            tick <= 1;
        end
        else
        begin
            count <= count + 1;
            tick <= 0;
        end
    end
end

endmodule