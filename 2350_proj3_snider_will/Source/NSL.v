module NSL (SW, KEY, NextState);
`include "states.vh"
input KEY;
input [2:0] SW;
output reg [3:0] NextState;
wire [4:0] NS = {KEY, SW[2:0]};

always @ (*)
begin
    case (NS)
        4'b0000:     NextState <= IDLE;
        4'b0001:     NextState <= HAZARD;
        4'b0010:     NextState <= TURN_RIGHT;
        4'b0011:     NextState <= HAZARD;
        4'b0100:     NextState <= BRAKE;
        4'b0101:     NextState <= HAZARD;
        4'b0110:     NextState <= BRAKE_TURN_RIGHT;
        4'b0111:     NextState <= HAZARD;
        4'b1000:     NextState <= IDLE;
        4'b1001:     NextState <= HAZARD;
        4'b1010:     NextState <= TURN_LEFT;
        4'b1011:     NextState <= HAZARD;
        4'b1100:     NextState <= BRAKE;
        4'b1101:     NextState <= HAZARD;
        4'b1110:     NextState <= BRAKE_TURN_LEFT;
        4'b1111:     NextState <= HAZARD;
        default: NextState <= IDLE;
    endcase
end
endmodule