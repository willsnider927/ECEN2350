module top(input ADC_CLK_10, input [1:0] KEY,input [9:0] SW, output [9:0] LEDR, output [7:0] HEX0);
    `include "states.vh"
    wire [3:0] CurrentState;
    wire [3:0] NextState;
    wire twoHzClock;
    wire fourHzClock;

    clock_divider #(div_2Hz) CLKD2 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(twoHzClock));
    clock_divider #(div_4Hz) CLKD4 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(fourHzClock));

    NSL U0 (.KEY(KEY[1]), .SW(SW[2:0]), .NextState(NextState));
    CSL U1 (.clock(twoHzClock), .reset_n(KEY[0]), .NextState(NextState), .CurrentState(CurrentState));
    OL  U2 (.clock(fourHzClock), .CurrentState(CurrentState), .LEDR(LEDR));

    sevenseg U3 (.bits(CurrentState),.out(HEX0));
endmodule