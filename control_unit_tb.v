`timescale 1ns/1ps

module control_unit_tb;

    reg [2:0] opcode;

    wire [2:0] alu_operation;
    wire       write_enable;

    control_unit DUT (
        .opcode(opcode),
        .alu_operation(alu_operation),
        .write_enable(write_enable)
    );

    initial begin

        // ADD
        opcode = 3'b000;
        #10;

        if (alu_operation == 3'b000 && write_enable == 1'b1)
            $display("PASS: ADD");
        else
            $display("FAIL: ADD");


        // SUB
        opcode = 3'b001;
        #10;

        if (alu_operation == 3'b001 && write_enable == 1'b1)
            $display("PASS: SUB");
        else
            $display("FAIL: SUB");


        // AND
        opcode = 3'b010;
        #10;

        if (alu_operation == 3'b010 && write_enable == 1'b1)
            $display("PASS: AND");
        else
            $display("FAIL: AND");


        // OR
        opcode = 3'b011;
        #10;

        if (alu_operation == 3'b011 && write_enable == 1'b1)
            $display("PASS: OR");
        else
            $display("FAIL: OR");


        // XOR
        opcode = 3'b100;
        #10;

        if (alu_operation == 3'b100 && write_enable == 1'b1)
            $display("PASS: XOR");
        else
            $display("FAIL: XOR");


        // SHIFT LEFT
        opcode = 3'b101;
        #10;

        if (alu_operation == 3'b101 && write_enable == 1'b1)
            $display("PASS: SHIFT LEFT");
        else
            $display("FAIL: SHIFT LEFT");


        // SHIFT RIGHT
        opcode = 3'b110;
        #10;

        if (alu_operation == 3'b110 && write_enable == 1'b1)
            $display("PASS: SHIFT RIGHT");
        else
            $display("FAIL: SHIFT RIGHT");


        // PASS
        opcode = 3'b111;
        #10;

        if (alu_operation == 3'b111 && write_enable == 1'b1)
            $display("PASS: PASS");
        else
            $display("FAIL: PASS");


        $display("==============================");
        $display("CONTROL UNIT TEST COMPLETED");
        $display("==============================");

        $stop;

    end

endmodule