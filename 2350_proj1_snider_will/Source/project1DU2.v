module Project1DU2(
                input [9:0] SW,
                input [1:0] KEY,
                output [9:0] LEDR,
                output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

reg[3:0] input1;
reg[3:0] input2;

reg[7:0] sign; // this will be the 8 bits to send to HEX3

reg l0, l1, l2; // intermediate variables for the LEDR[2:0]

always @ (SW[9:0])
begin
    input1 = SW[7:4];
    input2 = SW[3:0];

    if(input1 == input2)
    begin
        l0 = 0;
        l1 = 0;
        l2 = 1;
          sign = 8'b1000_0110; // set HEX3 to E
    end
    else if (input1 > input2)
    begin
        l0 = 0;
        l1 = 1;
        l2 = 0;
          sign = 8'b1111_1111; // turn HEX3 off
    end
    else
    begin
        l0 = 1;
        l1 = 0;
        l2 = 0;
          sign = 8'b1100_0111; // set HEX3 to L
    end
end

assign HEX0 = 8'b1111_1111; // turn off HEX0
assign HEX2 = 8'b1111_1111; // turn off HEX2
assign HEX4 = 8'b1111_1111; // turn OFF HEX4
assign HEX3 = sign;

sevenseg U0 (.bits(input2), .out(HEX1));
sevenseg U2 (.bits(input1), .out(HEX5));

assign LEDR[0] = l0;
assign LEDR[1] = l1;
assign LEDR[2] = l2;

endmodule