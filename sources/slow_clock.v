`timescale 1ns / 1ps

module slow_clock(
    input CLOCK,
    output reg [35:0] COUNTER = 0
    );
    
    always @ (posedge CLOCK) begin
        COUNTER = COUNTER + 1;
    end
endmodule
