module Project4 (
	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,
	//////////// KEYS//////////
	input 		     [1:0]		KEY,
	//////////// VGA outputs //////////
	output		     [3:0]		VGA_B,   // Blue
	output		     [3:0]		VGA_G,   // Green
	output		     [3:0]		VGA_R,   // Red	
	output		          		VGA_HS,  // Horizontal sync
	output		          		VGA_VS   // Vertical sync
);

reg VGA_CTRL_CLK;

// Divide clock by 2 to create VGA clock
always @ (posedge MAX10_CLK1_50, negedge KEY[0])
	if (KEY[0] == 1'b0)
		VGA_CTRL_CLK <= 1'b0;
	else
		VGA_CTRL_CLK <= !VGA_CTRL_CLK;

vga_controller U0 ( .iRST_n(KEY[0]),
                    .iVGA_CLK(VGA_CTRL_CLK),
                    .oHS(VGA_HS),
                    .oVS(VGA_VS),
                    .oVGA_B(VGA_B),
                    .oVGA_G(VGA_G),
                    .oVGA_R(VGA_R));	

endmodule
