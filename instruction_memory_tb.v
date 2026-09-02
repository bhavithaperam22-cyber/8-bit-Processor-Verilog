`timescale 1ns/1ps

module instruction_memory_tb;

    reg  [7:0] address;
    wire [15:0] instruction;

    instruction_memory DUT (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        $display("==============================");
        $display("INSTRUCTION MEMORY TEST");
        $display("==============================");

        address = 8'd0;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 8'd1;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 8'd2;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 8'd3;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 8'd4;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 8'd10;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        $display("==============================");
        $display("INSTRUCTION MEMORY TEST COMPLETED");
        $display("==============================");

        $stop;

    end

endmodule