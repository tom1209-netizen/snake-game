`timescale 1ns / 1ps

module Random_tb; 
    reg clk; 
    reg rst; 
    
    wire [6:0] randX; 
    wire [6:0] randY; 
    
    Random uut (.clk(clk), .rst(rst), .randX(randX), .randY(randY));
    
    // Clock generation
    initial begin
        clk             = 0;
        forever #10 clk = ~clk;  // 50 MHz Clock
    end
    
    // Stimuli
    initial begin
        // Initialize Inputs
        rst = 1;  // Apply reset
        #100;     // Wait for 100 ns
        
        rst = 0;  // Release reset
        #1000;    // Run for 1000 ns to observe the behavior
        
        $finish;  // End simulation
    end
    
    // Monitoring
    initial begin
        $monitor("Time = %t, rst = %b, randX = %b, randY = %b", $time, rst, randX, randY);
    end
    
endmodule
