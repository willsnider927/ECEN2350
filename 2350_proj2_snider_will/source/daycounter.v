module daycounter(input clock, input wire reset_n, output [7:0]HEX0, output [7:0]HEX1, output reg [7:0] BCD_value);
    `include "params.vh"
    
    //wire [6:0] binary_value = 0;
    wire [7:0] hex0_t, hex1_t;
    reg [3:0] BCD_t = 0;
    
    always @ (posedge clock, negedge reset_n)
    begin
        if(~reset_n)
            BCD_value <= 1;
        else if (BCD_value[3:0] == 4'b1001 && BCD_value[7:4]==4'b1001)
            BCD_value <= 1;
        else if (BCD_value[3:0]==4'b1001)
        begin
            BCD_value[3:0] <= 0;
            BCD_value[7:4] <= BCD_value[7:4]+1;
        end
        else 
            BCD_value[3:0] <= BCD_value[3:0]+1;
    end
    always @(posedge clock)
    begin
        if (BCD_value[7:4] == 0)
        BCD_t <= 4'b1111;
        else
        BCD_t <= BCD_value[7:4];
    end

    //binary_value = (BCD_value[7:4] * 10) + ({3'b0, BCD_value[3:0]});
    sevenseg U1 (.bits(BCD_value[3:0]), .out(hex0_t));
    sevenseg U2 (.bits(BCD_t), .out(hex1_t));
    assign HEX0 = hex0_t;
    assign HEX1 = hex1_t;
endmodule