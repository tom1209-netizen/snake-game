module ButtonInput (
    input wire clk,
    input wire l,  // Left
    input wire r,  // Right
    input wire u,  // Up
    input wire d,  // Down
    output reg [3:0] direction
);
    localparam LEFT  = 4'b0001;
    localparam RIGHT = 4'b0010;
    localparam UP    = 4'b0100;
    localparam DOWN  = 4'b1000;

    always @(posedge clk) begin
        if (l)
            direction <= LEFT;
        else if (r)
            direction <= RIGHT;
        else if (u)
            direction <= UP;
        else if (d)
            direction <= DOWN;
    end
endmodule
