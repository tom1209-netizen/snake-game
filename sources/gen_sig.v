`timescale 1ns / 1ps

module gen_sig(
    input CLOCK, SLOW_CLOCK, enable, left_pulse, right_pulse,
    output reg E = 1, L, R
    );
    
    reg COUNTER;
    
    always @ (posedge CLOCK) begin
        if (left_pulse == 1) begin
            L = 1;
            R = 0;
        end
        else if (right_pulse == 1) begin
            R = 1;
            L = 0;
        end
            
        if (enable == 1)
            E = 1;
        if (COUNTER == 0 && SLOW_CLOCK == 1)
            begin
                L = 0;
                R = 0;
                E = 0;
            end
        COUNTER <= SLOW_CLOCK;
    end
    
endmodule
