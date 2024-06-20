`timescale 1ns / 1ps

module pulse(
    input PUSHBUTTON,
    input CLOCK,
    output PULSE
    );
    
    wire Q1;
    wire Q2;
    
    my_dff dff1 (CLOCK, PUSHBUTTON, Q1);
    my_dff dff2 (CLOCK, Q1, Q2);
    
    assign PULSE = (Q1 & ~Q2);
    
endmodule
