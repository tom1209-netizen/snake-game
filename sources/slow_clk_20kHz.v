`timescale 1ns / 1ps

module slow_clk_20kHz(
    input CLOCK,
    output CLK_20kHz
    );
    
    reg [12:0] COUNTER = 12'b0;
    reg slow_clock = 0;
    
    always @ (posedge CLOCK) begin
        if (COUNTER == 12'b100111000011) 
            begin
                COUNTER <= 0;
                slow_clock <= ~slow_clock;
            end
        else
            COUNTER <= COUNTER + 1;
    end
    
    assign CLK_20kHz = slow_clock;
    
endmodule
