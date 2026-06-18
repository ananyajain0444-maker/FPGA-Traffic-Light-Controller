`include "params.vh"

module traffic_fsm(
    input clk,
    input rst,
    input tick,
    input ped_req,
    input emergency,
    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,
    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green,
    output reg ped_walk
);

reg [2:0] state;
reg [7:0] timer;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= `NS_GREEN;
        timer <= 0;
    end
    else if(tick)
    begin
        timer <= timer + 1;

        case(state)

        `NS_GREEN:
        begin
            if(emergency)
            begin
                state <= `EMERGENCY;
                timer <= 0;
            end
            else if(timer >= `GREEN_TIME)
            begin
                state <= `NS_YELLOW;
                timer <= 0;
            end
        end

        `NS_YELLOW:
        begin
            if(timer >= `YELLOW_TIME)
            begin
                state <= `EW_GREEN;
                timer <= 0;
            end
        end

        `EW_GREEN:
        begin
            if(emergency)
            begin
                state <= `EMERGENCY;
                timer <= 0;
            end
            else if(timer >= `GREEN_TIME)
            begin
                state <= `EW_YELLOW;
                timer <= 0;
            end
        end

        `EW_YELLOW:
        begin
            if(ped_req)
            begin
                state <= `PED_WALK;
                timer <= 0;
            end
            else if(timer >= `YELLOW_TIME)
            begin
                state <= `NS_GREEN;
                timer <= 0;
            end
        end

        `PED_WALK:
        begin
            if(timer >= `PED_TIME)
            begin
                state <= `NS_GREEN;
                timer <= 0;
            end
        end

        `EMERGENCY:
        begin
            if(timer >= `EMERGENCY_TIME)
            begin
                state <= `NS_GREEN;
                timer <= 0;
            end
        end

        default:
        begin
            state <= `NS_GREEN;
            timer <= 0;
        end

        endcase
    end
end

always @(*)
begin

    ns_red = 0;
    ns_yellow = 0;
    ns_green = 0;

    ew_red = 0;
    ew_yellow = 0;
    ew_green = 0;

    ped_walk = 0;

    case(state)

    `NS_GREEN:
    begin
        ns_green = 1;
        ew_red = 1;
    end

    `NS_YELLOW:
    begin
        ns_yellow = 1;
        ew_red = 1;
    end

    `EW_GREEN:
    begin
        ew_green = 1;
        ns_red = 1;
    end

    `EW_YELLOW:
    begin
        ew_yellow = 1;
        ns_red = 1;
    end

    `PED_WALK:
    begin
        ns_red = 1;
        ew_red = 1;
        ped_walk = 1;
    end

    `EMERGENCY:
    begin
        ns_green = 1;
        ew_red = 1;
    end

    endcase
end

endmodule