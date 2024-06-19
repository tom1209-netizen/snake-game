`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2024 08:14:23 AM
// Design Name: 
// Module Name: test_snake
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


module test_snake();
  reg clk, reset, l, r, u, d;
  wire VGA_clk, update_clock;
  wire red, green, blue, h_sync, v_sync;
  
  Snake test (red, green, blue, h_sync, v_sync, clk, reset, l, r, u, d);
  
  always
    #1 clk = ~clk;  // Clock generation: toggles every 1 time unit

  assign VGA_clk = test.VGA_clk;
  assign update_clock = test.update_clock;

  initial begin
    clk = 0; 
    reset = 0;
    l = 1; r = 0; u = 0; d = 0; #30;  // Move left for 30 time units
    l = 0; r = 1; u = 0; d = 0; #30;  // Move right for 30 time units
    l = 0; r = 0; u = 1; d = 0; #30;  // Move up for 30 time units
    l = 0; r = 0; u = 0; d = 1; #30;  // Move down for 30 time units
    $finish;  // End the simulation
  end
endmodule
