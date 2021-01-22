`timescale 1 ns / 100 ps
module tb();

reg clock;
reg [1:0] key;
wire[3:0] VGA_B;
wire[3:0] VGA_R;
wire[3:0] VGA_G;
wire VGA_HS;
wire VGA_VS;

always #10 clock = ~clock;

Project4 TUD(.MAX10_CLK1_50(clock), .KEY(key), .VGA_B(VGA_B), .VGA_G(VGA_G), .VGA_R(VGA_R), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS));

initial
    begin
        $dumpfile("output.vcd");
        $dumpvars;
        clock = 0;
        key = 10;
end

initial
begin
    $display("Simulation Starting...");
    #25 key = 11;
    #20000000 $finish;
end
endmodule