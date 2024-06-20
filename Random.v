module Random (
    input clk,
    input rst,
    output reg [6:0] randX,
    output reg [6:0] randY
);
    reg [6:0] lfsrX = 7'b1010101; // Initial seed for randX
    reg [6:0] lfsrY = 7'b0110110;  // Initial seed for randY

    always @(posedge clk) begin
        if (rst) 
            begin
                lfsrX <= 7'b1010101; // Reset
                lfsrY <= 7'b0110110; // Reset 
            end 
        else 
            begin
                // LFSR for randX (7-bit)
                lfsrX <= {lfsrX[5:0], lfsrX[6] ^ lfsrX[5]};  
                if (lfsrX >= 96)   
                    randX <= 96;  
                else
                    randX <= lfsrX; 

                // LFSR for randY (7-bit)
                lfsrY <= {lfsrY[5:0], lfsrY[6] ^ lfsrY[5]};  
                if (lfsrY >= 64)   
                    randY <= 64;  
                else
                    randY <= lfsrY;
            end
    end
endmodule
