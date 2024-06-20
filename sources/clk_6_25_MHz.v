`timescale 1ns / 1ps

module clk_6_25_MHz(
    input CLOCK,
    output slow_clk
    );
    
    reg [3:0] COUNTER = 4'b0;
    
    always @ (posedge CLOCK) begin
        COUNTER = COUNTER + 1;
    end
    
    assign slow_clk = COUNTER[3];
    
endmodule
