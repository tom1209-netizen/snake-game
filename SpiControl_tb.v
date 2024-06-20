`timescale 1ns / 1ps

module SpiControl_tb;
    // Inputs
    reg CLK;
    reg RST;
    reg SPI_EN;
    reg [7:0] SPI_DATA;

    // Outputs
    wire CS;
    wire SDO;
    wire SCLK;
    wire SPI_FIN;

    // Instantiate the Unit Under Test (UUT)
    SpiControl uut (
        .CLK(CLK),
        .RST(RST),
        .SPI_EN(SPI_EN),
        .SPI_DATA(SPI_DATA),
        .CS(CS),
        .SDO(SDO),
        .SCLK(SCLK),
        .SPI_FIN(SPI_FIN)
    );

    // Clock generation
    always #5 CLK = ~CLK; // 100 MHz clock

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST = 1;
        SPI_EN = 0;
        SPI_DATA = 8'h00;

        // Wait for global reset to finish
        #100;
        RST = 0;

        // Test 1: Transmit a byte
        SPI_DATA = 8'hA5;  // Example data to send
        SPI_EN = 1;
        #20;
        SPI_EN = 0;

        // Wait for transmission to complete
        wait (SPI_FIN == 1);

        // Test 2: Transmit another byte
        #100;  // Wait a bit before next transmission
        SPI_DATA = 8'h3C;  // Example data to send
        SPI_EN = 1;
        #20;
        SPI_EN = 0;

        // Wait for transmission to complete
        wait (SPI_FIN == 1);

        // End of simulation
        #100;
        $stop;
    end

    initial begin
        $dumpfile("SpiControl_tb.vcd");
        $dumpvars(0, SpiControl_tb);
    end

    // Monitor statements for debugging
    initial begin
        $monitor("Time = %0t | CS = %b | SCLK = %b | SDO = %b | SPI_FIN = %b | SPI_DATA = %h | current_state = %s",
                 $time, CS, SCLK, SDO, SPI_FIN, SPI_DATA, uut.current_state);
    end
endmodule
