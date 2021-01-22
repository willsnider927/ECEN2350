module topest(input ADC_CLK_10, input [1:0] KEY, input [9:0] SW, output [7:0] HEX0, output[9:0] LEDR);

    wire twoHzClock;
    wire pointTwoHzClock;
    wire [3:0] memData;
    clock_divider #(2_500_000) CLKDIV1 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(twoHzClock));
    clock_divider #(5) CLKDIV2 (.clock_in(twoHzClock), .reset_n(KEY[0]), .clock_out(pointTwoHzClock));
    
    reg [3:0] mem_cnt = 4'd0;
    rom    rom_inst (
    .aclr ( ~KEY[0] ),
    .address ( mem_cnt ),
    .clock ( twoHzClock ),
    .q ( memData )
    );

    always @(posedge pointTwoHzClock, negedge KEY[0])
    begin
        if (KEY[0] == 0)
            mem_cnt <= 4'd0;
        else if (mem_cnt == 4'd5)
            mem_cnt <= 4'd0;
        else
            mem_cnt <= mem_cnt + 1;
    end

    reg [2:0] SWin;
    reg button;
    always @(*)
    begin
        button = SW[9] ? memData[3] : KEY[1];
        SWin = SW[9] ? memData[2:0] : SW[2:0];
    end

    top TOP (.ADC_CLK_10(ADC_CLK_10), .KEY({button, KEY[0]}), .SW(SWin), .LEDR(LEDR), .HEX0(HEX0));


endmodule