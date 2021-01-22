parameter IDLE = 4'd0;
parameter HAZARD = 4'd1;
parameter TURN_LEFT = 4'd2;
parameter TURN_RIGHT = 4'd3;
parameter BRAKE_TURN_RIGHT = 4'd4;
parameter BRAKE_TURN_LEFT = 4'd5;
parameter BRAKE = 4'd6;

`ifdef sim
    parameter div_2Hz = 4;
    parameter div_4Hz = 2;
`else
    parameter div_2Hz = 2_500_000;
    parameter div_4Hz = 1_250_000;
`endif