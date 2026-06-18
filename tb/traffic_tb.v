`timescale 1ns/1ps

module traffic_tb;

reg clk;
reg rst;
reg ped_req;
reg emergency;

wire ns_red;
wire ns_yellow;
wire ns_green;

wire ew_red;
wire ew_yellow;
wire ew_green;

wire ped_walk;

top dut(
    .clk(clk),
    .rst(rst),
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

always #5 clk = ~clk;

initial
begin

    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_tb);

    clk = 0;
    rst = 1;
    ped_req = 0;
    emergency = 0;

    #20 rst = 0;

    #500 ped_req = 1;
    #20  ped_req = 0;

    #500 emergency = 1;
    #20  emergency = 0;

    #2000;

    $finish;
end

endmodule