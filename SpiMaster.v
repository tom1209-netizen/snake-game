`timescale 1ns / 1ps

module SpiMaster(
    input clk,
    input reset,
    input start,
    input [7:0] data,
    output reg done,
    output reg mosi,
    output reg sck,
    output reg cs
);
    reg [2:0] bit_cnt;
    reg [7:0] shift_reg;
    reg [1:0] state;
    reg [4:0] clk_div;

    parameter IDLE = 2'b00;
    parameter SEND = 2'b01;
    parameter DONE = 2'b10;

    initial begin
        state <= IDLE;
        cs <= 1;
        sck <= 0;
        mosi <= 0;
        done <= 0;
        bit_cnt <= 0;
        shift_reg <= 8'b0;
        clk_div <= 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            cs <= 1;
            sck <= 0;
            mosi <= 0;
            done <= 0;
            bit_cnt <= 0;
            shift_reg <= 8'b0;
            clk_div <= 0;
        end else begin
            case (state)
                IDLE: begin
                    cs <= 1;
                    sck <= 0;
                    done <= 0;
                    if (start) begin
                        shift_reg <= data;
                        bit_cnt <= 7;
                        cs <= 0;
                        state <= SEND;
                    end
                end
                SEND: begin
                    clk_div <= clk_div + 1;
                    if (clk_div == 5'b11111) begin
                        clk_div <= 0;
                        sck <= ~sck;
                        if (~sck) begin
                            mosi <= shift_reg[bit_cnt];
                            bit_cnt <= bit_cnt - 1;
                            if (bit_cnt == 0) begin
                                state <= DONE;
                            end
                        end
                    end
                end
                DONE: begin
                    cs <= 1;
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
