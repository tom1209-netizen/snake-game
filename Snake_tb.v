`timescale 1ns / 1ps

module Snake_tb;
    // Inputs
    reg clk;
    reg reset;
    reg l;
    reg r;
    reg u;
    reg d;

    // Outputs
    wire mosi;
    wire sck;
    wire cs;
    wire dc;
    wire vbat;
    wire vdd;
    wire res;

    // Instantiate the Unit Under Test (UUT)
    Snake uut (
        .clk(clk),
        .reset(reset),
        .l(l),
        .r(r),
        .u(u),
        .d(d),
        .mosi(mosi),
        .sck(sck),
        .cs(cs),
        .dc(dc),
        .vbat(vbat),
        .vdd(vdd),
        .res(res)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        l = 0;
        r = 0;
        u = 0;
        d = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Release reset
        reset = 0;
        
        // Wait for OLED initialization to complete
        #100000; // Adjust based on OLED initialization time
        
        // Test movement
        // Move right
        r = 1; #20; r = 0; #80;
        
        // Move down
        d = 1; #20; d = 0; #80;
        
        // Move left
        l = 1; #20; l = 0; #80;
        
        // Move up
        u = 1; #20; u = 0; #80;
        
        // Test reset
        reset = 1; #20; reset = 0;
        
        // End of simulation
        #1000;
        $stop;
    end

    initial begin
        $dumpfile("snake_game_tb.vcd");
        $dumpvars(0, Snake_tb);
    end

    // Monitor statements
    initial begin
        $monitor("Time = %0t | reset = %b | l = %b | r = %b | u = %b | d = %b | snake_x = %d | snake_y = %d | apple_x = %d | apple_y = %d | game_over = %b",
            $time, reset, l, r, u, d, uut.snake_x, uut.snake_y, uut.apple_x, uut.apple_y, uut.game_over);
    end
endmodule
