module video_sync_generator(reset,
                            vga_clk,
                            blank_n,
                            HS,
                            VS
									 );
                            
input reset;
input vga_clk;
output reg blank_n;
output reg HS;
output reg VS;

///////////////////
/*
--VGA Timing
--Horizontal :
--                ______________                 _____________
--               |              |               |
--_______________|  VIDEO       |_______________|  VIDEO (next line)

--___________   _____________________   ______________________
--           |_|                     |_|
--            B <-C-><----D----><-E->
--           <------------A--------->
--The Unit used below are pixels;  
--  B->Sync_cycle                   :H_sync_cycle
--  C->Back_porch                   :hori_back
--  D->Visable Area
--  E->Front porch                  :hori_front
--  A->horizontal line total length :hori_line
--Vertical :
--               ______________                 _____________
--              |              |               |          
--______________|  VIDEO       |_______________|  VIDEO (next frame)
--
--__________   _____________________   ______________________
--          |_|                     |_|
--           P <-Q-><----R----><-S->
--          <-----------O---------->
--The Unit used below are horizontal lines;  
--  P->Sync_cycle                   :V_sync_cycle
--  Q->Back_porch                   :vert_back
--  R->Visable Area
--  S->Front porch                  :vert_front
--  O->vertical line total length :vert_line
*////////////////////////////////////////////
////////////////////////                          
//parameter
parameter hori_line  = 800;
parameter h_pixels = 640;
parameter H_sync_cycle = 96;                          
parameter hori_back  = 48;
parameter hori_front = 16;

parameter vert_line  = 525;
parameter v_lines = 480;
parameter vert_back  = 33;
parameter vert_front = 10;
parameter V_sync_cycle = 2;

parameter H_BLANK = h_pixels + hori_front + H_sync_cycle + hori_back; //add by yang

//////////////////////////
reg [10:0] h_cnt;
reg [9:0]  v_cnt;
wire cHD,cVD,cDEN,hori_valid,vert_valid;
///////
always@(negedge vga_clk,posedge reset)
begin
  if (reset)
  begin
     h_cnt<=11'd0;
     v_cnt<=10'd0;
  end
    else
    begin
      if (h_cnt == hori_line - 1'b1)
      begin 
         h_cnt <= 11'd0;
         if (v_cnt == vert_line - 1'b1)
            v_cnt <= 10'd0;
         else
            v_cnt <= v_cnt + 1'b1;
      end
      else
         h_cnt <= h_cnt + 1'b1;
    end
end
/////
assign cHD = ((h_cnt > h_pixels + hori_front - 1'b1) && (h_cnt < h_pixels + hori_front + H_sync_cycle));
assign cVD = ((v_cnt > v_lines + vert_front - 1'b1) && (v_cnt < v_lines + vert_front + V_sync_cycle));

assign hori_valid = (h_cnt < (hori_line - hori_front) && h_cnt>=hori_back)?1'b1:1'b0;
assign vert_valid = (v_cnt < (vert_line - vert_front) && v_cnt>=vert_back)?1'b1:1'b0;

assign cDEN = ((h_cnt < h_pixels) && (v_cnt < v_lines));

always@(negedge vga_clk)
begin
  HS <= cHD;
  VS <= cVD;
  blank_n <= cDEN;
end

endmodule


