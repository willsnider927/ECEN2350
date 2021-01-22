module top(input wire ADC_CLK_10, 
    input [9:0] SW, 
    input [1:0] KEY, 
    output [7:0] HEX0, HEX1, HEX2, HEX4, HEX5,
    output [9:0] LEDR,
    output [6:0] binary_value,
    output reg [7:0] day,
    output reg [3:0] month);
    `include "params.vh"

    wire fiveHzClock, twoHzClock;   // wires to carry clock pulses
    reg dayClock = 0;   // reg to store selected clock
    wire [7:0] BCD_value;

    clock_divider #(mydiv)      U0 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(twoHzClock));   // divide 10MHz clock to 2Hz
    clock_divider #(mydiv_1)  U1 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(fiveHzClock));  // divide 10MHz clock to 5Hz

    always @ (*)
    	dayClock = (~KEY[1]) ? fiveHzClock : twoHzClock;    // multiplexor to select clock based on KEY[1] buttonpress

    wire[7:0] hex0_t, hex1_t, hex2_t, hex4_t, hex5_t;   // wires to hold information passed to hex displays

    daycounter U2 (.clock(dayClock), .reset_n(KEY[0]), .HEX0(hex4_t), .HEX1(hex5_t), .BCD_value(BCD_value));   // instantiate daycounter with the selected 2Hz/5Hz clock

    reg l0 = 1'b0;
    reg l1 = 1'b0;  // reg to store the state the light should be in
    always @ (posedge dayClock)
        l0 <= ~l0;   // flip the light every positive edge of the clock
    always @ (negedge dayClock)
        l1 <= ~l1;
    assign LEDR[0] = l0 ^ l1;
    assign HEX4 = hex4_t;
    assign HEX5 = hex5_t;
          
    reg isLeapYear = 1'b0;
    always @ (SW)
        isLeapYear = SW[9] ? 1'b1 : 1'b0;
		  
    reg [3:0] ones;
    reg [3:0] tens;
    
    assign binary_value = (BCD_value[7:4] * 10) + ({3'b0, BCD_value[3:0]});

    always @ (*)
    begin
		   if(~KEY[0])
				month = 4'b0001;
				
        if(binary_value <= 31) // january
            month = 4'b0001;
        else if(31 < binary_value && binary_value <= 59+isLeapYear) //feb
            month = 4'b0010;
        else if (59+isLeapYear < binary_value && binary_value <= isLeapYear+90) // march
            month = 4'b0011;
        else // april
            month = 4'b0100;
    end
	 
    always @(*)
    begin
			if(~KEY[0])
				day = 5'b0_0001;
				
        if (month == 4'b0001)
            day = binary_value;
        else if (month == 4'b0010)
            day = binary_value-31;
        else if (month == 4'b0011)
            day = binary_value - isLeapYear - 59;
        else
            day = binary_value - isLeapYear - 90;
    end
	 
    always @(*)
    begin
			if(~KEY[0])
			begin
				ones = 4'b0001;
            tens = 4'b0000;
			end
			
        if (day < 10)
        begin
            tens <= 4'b1111;
            ones <= day;
        end
        if (day >= 10 && day < 20)
        begin
            tens <= 4'b0001;
            ones <= day -10;
        end
        if (day >= 20 && day <30)
        begin
            tens <= 4'b0010;
            ones <= day -20;
        end
        if (day >= 30)
        begin
            tens <= 4'b0011;
            ones <= day -30;
        end
    end
	 
    sevenseg U3 (.bits(month), .out(hex2_t));
    sevenseg U5 (.bits(tens), .out(hex1_t));
    sevenseg U6 (.bits(ones), .out(hex0_t));

    assign HEX0 = hex0_t;
    assign HEX1 = hex1_t;
    assign HEX2 = hex2_t;
    
endmodule