`timescale 1ns / 1ps

module Top_Student (
    input CLK100MHZ,
    output [15:0] led,
    output reg [7:0] seg,
    output reg [3:0] an,

    input btnC,
    input btnU, btnL, btnR,
    output [7:0] JC
    );

    // OLED Display
    wire clk6p25m, clk95;
    wire reset;
    reg [15:0] oled_data;
    wire frame_begin, sending_pixels, sample_pixel; 
    wire [4:0] teststate; 
    wire [12:0] pixel_index;

    clk_6_25_MHz clk_dev1 (CLK100MHZ, clk6p25m);
    pulse pulse_dev (btnC, clk6p25m, reset);
    Oled_Display(clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7],teststate);

    wire [15:0] normal_oled_data;

    graphical_visualisation normal_GV_dev (CLK100MHZ, pixel_index, normal_oled_data); // Part 4.2B

    reg [2:0] btn;
    wire [15:0] snake_oled_data;
    wire [3:0] snake_an;
    wire [7:0] snake_seg;
    wire [15:0] combined_oled_data;

    Top_Snake TS_dev(CLK100MHZ, btn, pixel_index, snake_oled_data, snake_an, snake_seg);

    always @ (posedge CLK100MHZ) begin
        an = snake_an;
        seg = snake_seg;
        oled_data = snake_oled_data;
        btn = {btnR, btnL, btnU};
    end

    assign led = normal_oled_data;

endmodule
