`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2024 08:00:48 AM
// Design Name: 
// Module Name: Snake
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Snake(red, green, blue,h_sync,v_sync,clk, reset,l,r,u,d);
input clk, reset, l, r, u, d;
output reg [4:0] red, blue;
output reg [5:0] green;
output h_sync, v_sync;

wire VGA_clk,update_clock,displayArea;
wire [9:0] xCount;
wire [9:0] yCount;
wire [3:0] direction;
wire [9:0] randX;
wire [9:0] randomX;
wire [8:0] randY;
wire [8:0] randomY;
reg apple;
reg border;
wire R,G,B;
reg snake;
reg gameOver;
reg head;
reg [9:0] appleX;
reg [9:0] appleY;
reg inX, inY;
reg [9:0] snakeX;
reg [8:0] snakeY;

ClockDivider divider (clk, VGA_clk);
UpdateClock upd(clk,update_clock);
VGAgenerator vga (VGA_clk, xCount, yCount, displayArea, h_sync, v_sync);
Random ran (VGA_clk,randX, randY);
ButtonInput but (clk,l,r,u,d, direction);

assign randomx = randX;
assign randomy = randY;

initial
begin
snakeX = 10'd20;
snakeY = 9'd20;
end

always @(posedge VGA_clk) begin
  inX <= (xCount > appleX & xCount < (appleX + 50));
  inY <= (yCount > appleY & yCount < (appleY + 50));
  apple <= inX & inY;
end


always @(posedge VGA_clk) begin
  border <= (((xCount >= 0) & (xCount < 15) & ((yCount >= 220) & (yCount < 280))) | 
             (xCount >= 630) & (xCount < 641) & ((yCount >= 220) & (yCount < 280))) | 
             ((yCount >= 0) & (yCount < 15) | (yCount >= 465) & (yCount < 481));
end

always @(posedge VGA_clk) begin
  if (reset | gameOver) begin
    appleX = 350;
    appleY = 300;
  end
  if (apple & head) begin
    appleX <= randX;
    appleY <= randY;
  end
end

always @(posedge update_clock) begin
  if (direction == 4'b0001) begin snakeX = snakeX - 5; end
  else if (direction == 4'b0010) begin snakeX = snakeX + 5; end
  else if (direction == 4'b0100) begin snakeY = snakeY - 5; end
  else if (direction == 4'b1000) begin snakeY = snakeY + 5; end
end

always @(posedge VGA_clk) begin
  head <= (xCount > snakeX & xCount < (snakeX+10)) & (yCount > snakeY & yCount < (snakeY+10));
end

always @(posedge VGA_clk) begin
  if ((border & head) | reset) gameOver <= 1;
  else gameOver <= 0;
end

assign R = (displayArea & apple);
assign G = (displayArea & head);
assign B = (displayArea & border);

always @(posedge VGA_clk) begin
  red = {5{R}};
  green = {6{G}};
  blue = {5{B}};
end

endmodule
