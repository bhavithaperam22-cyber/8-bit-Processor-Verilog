`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;

    wire [7:0] pc;

    // Device Under Test
    program_counter DUT (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        #10;

        reset = 0;

        #100;

        $display("==============================");
        $display("PROGRAM COUNTER TEST COMPLETED");
        $display("==============================");

        $stop;

    end

endmodule