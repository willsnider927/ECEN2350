`timescale 1 ns / 100 ps
module tb();

reg clock;
reg [9:0] switches;
reg [1:0] key;
wire[7:0] hex0, hex1, hex2, hex4, hex5;
wire[9:0] leds;
wire [7:0] day;
wire [3:0] month;
wire [6:0] day_cnt;
always #10 clock = ~clock;

top TUD (.ADC_CLK_10(clock), .SW(switches), .KEY(key), .HEX0(hex0), .HEX1(hex1), .HEX2(hex2), .HEX4(hex4), .HEX5(hex5), .LEDR(leds),.day(day),.month(month),.binary_value(day_cnt));

initial
    begin
        $dumpfile("output.vcd");
        $dumpvars;
        clock = 0;
        key = 11;
        switches = 10'b00_0000_0000;
end

initial
begin
    $display("Simulation Starting...");
    #5 key = 10;
    #2 key = 11;
    #10 key = 01;
    #3000 key = 11;

    #35000 switches = 10'b10_0000_0000;

    #22000 $finish;
end

initial
    $monitor($time, " clock = %b \t key = %b \t isleap? = %b, Month/day = %d/%d, count = %d,  LEDR[0] = %b, HEX4 =%b", clock, key, switches[9], month, day, day_cnt, leds[0], hex4);

endmodule