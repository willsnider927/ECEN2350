module sevenseg(input [3:0] bits,
                output reg [7:0] out
                );
                
    always @ (*)
        case (bits[3:0])    //7654_3210
            4'b0000: out = 8'b1100_0000;    // 0
            4'b0001: out = 8'b1111_1001;    // 1
            4'b0010: out = 8'b1010_0100;    // 2
            4'b0011: out = 8'b1011_0000;    // 3
            4'b0100: out = 8'b1001_1001;    // 4
            4'b0101: out = 8'b1001_0010;    // 5
            4'b0110: out = 8'b1000_0010;    // 6
            4'b0111: out = 8'b1111_1000;    // 7
            4'b1000: out = 8'b1000_0000;    // 8
            4'b1001: out = 8'b1001_1000;    // 9
            4'b1010: out = 8'b1000_1000;    // A
            4'b1011: out = 8'b1000_0011;    // B
            4'b1100: out = 8'b1100_0110;    // C
            4'b1101: out = 8'b1010_0001;    // D
            4'b1110: out = 8'b1000_0110;    // E
            4'b1111: out = 8'b1000_1110;    // F

            default: out = 8'b1111_1111;
        endcase

endmodule