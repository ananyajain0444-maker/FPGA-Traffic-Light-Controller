module top(
    input clk,
    input rst,
    input ped_req,
    input emergency,

    output ns_red,
    output ns_yellow,
    output ns_green,

    output ew_red,
    output ew_yellow,
    output ew_green,

    output ped_walk
);

wire tick;

clk_en u1(
    .clk(clk),
    .rst(rst),
    .tick(tick)
);

traffic_fsm u2(
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .ped_req(ped_req),
    .emergency(emergency),

    .ns_red(ns_red),
    .ns_yellow(ns_yellow),
    .ns_green(ns_green),

    .ew_red(ew_red),
    .ew_yellow(ew_yellow),
    .ew_green(ew_green),

    .ped_walk(ped_walk)
);

endmodule