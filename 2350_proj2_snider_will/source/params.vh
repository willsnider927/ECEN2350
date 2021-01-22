`ifdef sim
    parameter mydiv = 10;
    parameter mydiv_1 = 4;
`else
    parameter mydiv = 2_500_000;
    parameter mydiv_1 = 1_000_000;
`endif