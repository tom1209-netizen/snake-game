`timescale 1ns / 1ps

module ButtonInput_tb;

    // Inputs
    reg clk;
    reg l, r, u, d;

    // Output
    wire [3:0] direction;

    // Instantiate the Unit Under Test (UUT)
    ButtonInput uut (
        .clk(clk),
        .l(l),
        .r(r),
        .u(u),
        .d(d),
        .direction(direction)
    );

    // Clock generation
    always #10 clk = ~clk;  // 50 MHz clock

    // Initial block to simulate input and reset conditions
    initial begin
        // Initialize Inputs
        clk = 0;
        l = 0;
        r = 0;
        u = 0;
        d = 0;

        // Wait for global reset
        #100;
        
        // Simulate button presses
        l = 1; #20 l = 0; #20;  // Press left
        r = 1; #20 r = 0; #20;  // Press right
        u = 1; #20 u = 0; #20;  // Press up
        d = 1; #20 d = 0; #20;  // Press down

        // Simulate simultaneous button presses
        l = 1; r = 1; u = 1; d = 1; #20;
        l = 0; r = 0; u = 0; d = 0; #20;

        // Finish simulation
        $finish;
    end

    initial begin
        $monitor("Time=%t, clk=%b, l=%b, r=%b, u=%b, d=%b, direction=%b", 
                 $time, clk, l, r, u, d, direction);
    end
      
endmodule
