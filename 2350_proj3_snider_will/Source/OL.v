module OL(clock, CurrentState, LEDR);
`include "states.vh"
input clock;
input [3:0] CurrentState;
output [9:0] LEDR;
reg [9:0] leds = 10'b00_0000_0000;
reg [9:0] turn_led_right = 10'b00_0000_0000;
reg [9:0] turn_led_left = 10'b00_0000_0000;
reg [9:0] hazard = 10'b0;
//break
reg [9:0] brake = 10'b111_0000_111;

reg [2:0] cnt = 0;
always @(posedge clock) 
begin
    cnt <= (cnt == 3'd3)? 0: cnt + 1;
    //turn signals
    if (cnt ==0)
        turn_led_right <= 10'b00_0000_0000;
    if(cnt == 1)
        turn_led_right <= 10'b00_0000_0100;
    if(cnt == 2)
        turn_led_right <= 10'b00_0000_0110;
    if(cnt == 3)
        turn_led_right <= 10'b00_0000_0111;
    if (cnt ==0)
        turn_led_left <= 10'b00_0000_0000;
    if(cnt == 1)
        turn_led_left <= 10'b00_1000_0000;
    if(cnt == 2)
        turn_led_left <= 10'b01_1000_0000;
    if(cnt == 3)
        turn_led_left <= 10'b11_1000_0000;
    //hazards
    if (cnt==3)
        hazard <= ~hazard;
end
always @(*)
begin
    case(CurrentState)
    IDLE:   leds <= 10'd0;
    HAZARD: begin
        leds[9:7] <= hazard[9:7];
        leds[2:0] <= hazard[2:0];
    end 
    TURN_LEFT:  leds <= turn_led_left;
    TURN_RIGHT: leds <= turn_led_right;
    BRAKE:      leds <= brake;
    BRAKE_TURN_RIGHT: begin
        leds[9:7] <= brake;
        leds[2:0] <= turn_led_right[2:0];
    end
    BRAKE_TURN_LEFT: begin
        leds[2:0] <= brake;
        leds[9:7] <= turn_led_left[9:7];       
    end
    endcase
end
assign LEDR = leds;
endmodule
