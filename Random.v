module Random (
    input VGA_clk,
    output reg [9:0] randX,
    output reg [8:0] randY
);
    reg [9:0] lfsrX = 10'b1010101010; // Initial seed for randX
    reg [8:0] lfsrY = 9'b110110110;   // Initial seed for randY

    always @(posedge VGA_clk) begin
        // LFSR for randX (10-bit)
        lfsrX <= {lfsrX[8:0], lfsrX[9] ^ lfsrX[6]};  // Example taps for 10-bit LFSR
        randX <= lfsrX;

        // LFSR for randY (9-bit)
        lfsrY <= {lfsrY[7:0], lfsrY[8] ^ lfsrY[4]};  // Example taps for 9-bit LFSR
        randY <= lfsrY;
    end
endmodule