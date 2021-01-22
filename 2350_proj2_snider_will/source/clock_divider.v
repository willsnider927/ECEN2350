module clock_divider (input clock_in, reset_n, output reg clock_out);
    reg [22:0] clock_divider;
    parameter divide_by = 0;

    always @ (posedge clock_in, negedge reset_n)
        begin
            if(~reset_n)    // reset (active low)
                begin
                    clock_out <= 0;
                    clock_divider <= 0;
                end
            else    // divide clock
                begin
                    if(clock_divider != divide_by - 1)
                        clock_divider <= clock_divider + 1'b1;  // count up to divide_by-1
                    else
                        begin
                            clock_out <= ~clock_out;    // flip clock every time we count to divide_by-1 
                            clock_divider <= 0;         // reset counter back to 0
                        end
                end
        end
        
endmodule