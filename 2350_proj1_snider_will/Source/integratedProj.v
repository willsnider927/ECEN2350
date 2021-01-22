module IntegratedProj(
                        input [9:0] SW,
                        input [1:0] KEY,
                        output [9:0] LEDR,
                        output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire [9:0] LEDRDU1;
wire [7:0] HEX0DU1, HEX1DU1, HEX2DU1, HEX3DU1, HEX4DU1, HEX5DU1;

wire [9:0] LEDRDU2;
wire [7:0] HEX0DU2, HEX1DU2, HEX2DU2, HEX3DU2, HEX4DU2, HEX5DU2;

Project1 U0 (.SW(SW[9:0]), .KEY(KEY[1:0]), .LEDR(LEDRDU1), .HEX0(HEX0DU1), .HEX1(HEX1DU1), .HEX2(HEX2DU1), .HEX3(HEX3DU1), .HEX4(HEX4DU1), .HEX5(HEX5DU1));
Project1DU2 U1 (.SW(SW[9:0]), .KEY(KEY[1:0]), .LEDR(LEDRDU2), .HEX0(HEX0DU2), .HEX1(HEX1DU2), .HEX2(HEX2DU2), .HEX3(HEX3DU2), .HEX4(HEX4DU2), .HEX5(HEX5DU2));

reg[9:0] LEDR_output;
reg[7:0] HEX0_o, HEX1_o, HEX2_o, HEX3_o, HEX4_o, HEX5_o;

always@(SW[9])
begin
    HEX0_o = !SW[9] ? HEX0DU1 : HEX0DU2;
    HEX1_o = !SW[9] ? HEX1DU1 : HEX1DU2;
    HEX2_o = !SW[9] ? HEX2DU1 : HEX2DU2;
    HEX3_o = !SW[9] ? HEX3DU1 : HEX3DU2;
    HEX4_o = !SW[9] ? HEX4DU1 : HEX4DU2;
    HEX5_o = !SW[9] ? HEX5DU1 : HEX5DU2;

    LEDR_output = !SW[9] ? LEDRDU1 : LEDRDU2;
end

assign HEX0 = HEX0_o;
assign HEX1 = HEX1_o;
assign HEX2 = HEX2_o;
assign HEX3 = HEX3_o;
assign HEX4 = HEX4_o;
assign HEX5 = HEX5_o;
assign LEDR = LEDR_output;

endmodule