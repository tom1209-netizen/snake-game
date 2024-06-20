`timescale 1ns / 1ps

module Top_Student (
    input CLK100MHZ,
    input btnC,
    input btnU, btnL, btnR,
    output [7:0] JA
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
    Oled_Display(clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, oled_data, JA[0], JA[1], JA[3], JA[4], JA[5], JA[6], JA[7],teststate);

    reg [2:0] btn;
    wire [15:0] snake_oled_data;
    wire [15:0] combined_oled_data;

    Top_Snake TS_dev(CLK100MHZ, btn, pixel_index, snake_oled_data);

    always @ (posedge CLK100MHZ) begin
        oled_data = snake_oled_data;
        btn = {btnR, btnL, btnU};
    end

endmodule
