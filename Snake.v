`timescale 1ns / 1ps

module Snake(
    input clk,
    input reset,
    input l,
    input r,  
    input u,  
    input d, 
    output mosi,
    output sck,
    output cs,
    output dc,
    output vbat,
    output vdd,
    output res
);
    wire [3:0] direction;
    ButtonInput but(clk, l, r, u, d, direction);

    wire [6:0] randX, randY;
    Random ran(clk, reset, randX, randY);

    reg [7:0] spi_data;
    reg spi_start = 0;
    wire spi_done;
    SpiMaster spi0(clk, reset, spi_start, spi_data, spi_done, mosi, sck, cs);

    // OLED initialization and control
    reg oled_init_start = 0;
    wire oled_init_done;
    OledInit oled_init(
        .CLK(clk),
        .EN(oled_init_start),
        .RST(reset),
        .CS(cs),
        .DC(dc),
        .FIN(oled_init_done),
        .RES(res),
        .SCLK(sck),
        .SDO(mosi),
        .VBAT(vbat),
        .VDD(vdd)
    );

    // Adjusted for a 96x64 OLED display
    reg [767:0] display_buffer;  // Each bit represents a pixel (96x64 / 8 = 768 bytes)
    reg [9:0] buffer_addr = 0;

    // Snake and apple properties
    reg [6:0] snake_x = 20, snake_y = 20;  // Initial snake position
    reg [6:0] apple_x = 48, apple_y = 32;  // Initial apple position
    reg game_over = 0;

    // Update the display buffer and send to the OLED via SPI
    always @(posedge clk) begin
        if (reset) begin
            // Reset logic
            buffer_addr <= 0;
            spi_start <= 0;
            oled_init_start <= 1;
            snake_x <= 20;
            snake_y <= 20;
            apple_x <= 48;
            apple_y <= 32;
            game_over <= 0;
            display_buffer <= 0;
        end else if (oled_init_done) begin
            oled_init_start <= 0;
            if (spi_done && buffer_addr < 768) begin
                spi_start <= 1;
                spi_data <= display_buffer[buffer_addr * 8 +: 8];
                buffer_addr <= buffer_addr + 1;
            end else if (buffer_addr >= 768) begin
                buffer_addr <= 0;  // Restart buffer cycle
            end
        end
    end

    // Game logic to update display_buffer based on game state
    integer i;
    always @(posedge clk) begin
        if (!reset && !game_over) begin
            // Clear display buffer each frame
            for (i = 0; i < 768; i = i + 1) begin
                display_buffer[i] <= 0;
            end

            // Update apple position in display buffer
            display_buffer[apple_x + apple_y * 96] <= 1;

            // Update snake position in display buffer
            display_buffer[snake_x + snake_y * 96] <= 1;

            // Handle direction input and move snake
            case (direction)
                4'b0001: snake_y <= (snake_y > 0) ? snake_y - 1 : 63;  // Up
                4'b0010: snake_y <= (snake_y < 63) ? snake_y + 1 : 0;  // Down
                4'b0100: snake_x <= (snake_x > 0) ? snake_x - 1 : 95;  // Left
                4'b1000: snake_x <= (snake_x < 95) ? snake_x + 1 : 0;  // Right
            endcase

            // Check for collisions with boundaries or apple
            if (snake_x == 0 || snake_x == 96 || snake_y == 0 || snake_y == 64) begin
                game_over <= 1;
            end else if (snake_x == apple_x && snake_y == apple_y) begin
                // Randomly reposition the apple
                apple_x <= randX;  
                apple_y <= randY;  
            end
        end
    end
endmodule
