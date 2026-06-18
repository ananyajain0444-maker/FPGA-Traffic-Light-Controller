`ifndef PARAMS_VH
`define PARAMS_VH

// State Encoding
`define NS_GREEN    3'b000
`define NS_YELLOW   3'b001
`define EW_GREEN    3'b010
`define EW_YELLOW   3'b011
`define PED_WALK    3'b100
`define EMERGENCY   3'b101

// Timing Parameters (simulation friendly)
`define GREEN_TIME     20
`define YELLOW_TIME    5
`define PED_TIME       10
`define EMERGENCY_TIME 15

`endif