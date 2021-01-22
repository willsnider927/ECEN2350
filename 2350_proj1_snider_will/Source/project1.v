module Project1(
                input [9:0] SW,
                input [1:0] KEY,
                output [9:0] LEDR,
                output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
parameter will_bday = 24'h092700;
parameter matt_bday = 24'h012501;

reg[23:0] tb;

always @(KEY[1]) begin
   tb = KEY[1] ? will_bday : matt_bday;
end

sevenseg U0(.bits(tb[3:0]), .out(HEX0));
sevenseg U1(.bits(tb[7:4]), .out(HEX1));
sevenseg U2(.bits(tb[11:8]), .out(HEX2));
sevenseg U3(.bits(tb[15:12]), .out(HEX3));
sevenseg U4(.bits(tb[19:16]), .out(HEX4));
sevenseg U5(.bits(tb[23:20]), .out(HEX5));

assign LEDR[9] = 0;
assign LEDR[8] = 0;

reg l0, l1, l2, l3, l4, l5, l6, l7;
always @ (KEY[0], SW[9:0])
begin
    l0 = KEY[0] ? !SW[0] : SW[0];
    l1 = KEY[0] ? !SW[1] : SW[1];
    l2 = KEY[0] ? !SW[2] : SW[2];
    l3 = KEY[0] ? !SW[3] : SW[3];
    l4 = KEY[0] ? !SW[4] : SW[4];
    l5 = KEY[0] ? !SW[5] : SW[5];
    l6 = KEY[0] ? !SW[6] : SW[6];
    l7 = KEY[0] ? !SW[7] : SW[7];
end

assign LEDR[0] = l0;
assign LEDR[1] = l1;
assign LEDR[2] = l2;
assign LEDR[3] = l3;
assign LEDR[4] = l4;
assign LEDR[5] = l5;
assign LEDR[6] = l6;
assign LEDR[7] = l7;

endmodule