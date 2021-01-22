`timescale 1 ns / 100 ps
module tb();

reg clock;
reg [9:0] switches;
reg [1:0] key;
wire[7:0] hex0;
wire[9:0] leds;

always #10 clock = ~clock;

top TUD (.ADC_CLK_10(clock), .KEY(key), .SW(switches), .LEDR(leds), .HEX0(hex0));

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
    #100 switches = 10'b00_0000_0100;
    #700 switches = 10'b00_0000_0010;
    #700 key = 01;
    #700 switches = 10'b00_0000_0001;
    #700 switches = 10'b00_0000_0111;
    #700 switches = 10'b00_0000_0110;
    #700 key = 11;
    #700 $finish;
end

initial
    $monitor($time, " clock = %b \t key = %b switches = %b \t LEDR = %b, HEX0 = %b", clock, key, switches, leds, hex0);

endmodule