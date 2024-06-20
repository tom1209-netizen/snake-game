`timescale 1ns / 1ps

module Top_Snake(
    input CLOCK,
    input [2:0] btn,
    input [12:0] pixel,
    output [15:0] oled_data
    );
    
    wire [35:0] SLOW_CLOCK;
    slow_clock SC(CLOCK, SLOW_CLOCK);
    
    wire left_pulse, right_pulse, reset;
    pulse p1(btn[0], SLOW_CLOCK[15], reset);
    pulse p2(btn[1], SLOW_CLOCK[15], left_pulse); // Left move
    pulse p3(btn[2], SLOW_CLOCK[15], right_pulse);  // Right move
    
    wire speed_selector;
    wire E, L, R;
    gen_sig G(CLOCK, speed_selector, reset, left_pulse, right_pulse, E, L, R);
    wire [4:0] len;
    plot_snake_test PST(speed_selector, E, L, R, pixel, oled_data, len);
    
    assign speed_selector = SLOW_CLOCK[22];
    
endmodule

