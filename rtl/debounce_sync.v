module debounce_sync(
    input clk,
    input rst,
    input btn_in,
    output reg btn_out
);

reg q1, q2;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        q1 <= 0;
        q2 <= 0;
        btn_out <= 0;
    end
    else
    begin
        q1 <= btn_in;
        q2 <= q1;
        btn_out <= q2;
    end
end

endmodule