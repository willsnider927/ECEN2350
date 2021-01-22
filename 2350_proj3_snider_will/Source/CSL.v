module CSL (clock, reset_n, NextState, CurrentState);
`include "states.vh"
input clock, reset_n;
input [3:0] NextState;
output reg [3:0] CurrentState;

always @ (posedge clock, negedge reset_n)
begin
    if(reset_n == 0)
        CurrentState <= IDLE;
    else
        CurrentState <= NextState;
end

endmodule