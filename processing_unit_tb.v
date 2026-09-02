`timescale 1ns/1ps

module processing_unit_tb;

    reg clk;
    reg reset;

    reg write_enable;
    reg [2:0] write_address;
    reg [7:0] write_data;

    reg [2:0] read_address_a;
    reg [2:0] read_address_b;

    reg [2:0] alu_operation;

    wire [7:0] result;
    wire carry;
    wire overflow;
    wire zero;

    processing_unit DUT (
        .clk(clk),
        .reset(reset),

        .write_enable(write_enable),
        .write_address(write_address),
        .write_data(write_data),

        .read_address_a(read_address_a),
        .read_address_b(read_address_b),

        .alu_operation(alu_operation),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        write_enable = 0;
        write_address = 0;
        write_data = 0;

        read_address_a = 0;
        read_address_b = 0;

        alu_operation = 0;

        #12;

        reset = 0;

        // --------------------------------
        // Write 5 into R1
        // --------------------------------

        @(negedge clk);

        write_enable = 1;
        write_address = 3'b001;
        write_data = 8'h05;

        @(negedge clk);

        write_enable = 0;

        // --------------------------------
        // Write 3 into R2
        // --------------------------------

        write_enable = 1;
        write_address = 3'b010;
        write_data = 8'h03;

        @(negedge clk);

        write_enable = 0;

        // --------------------------------
        // R3 = R1 + R2
        // --------------------------------

        read_address_a = 3'b001;
        read_address_b = 3'b010;

        alu_operation = 3'b000;

        #2;

        if (result == 8'h08)
            $display("PASS: R1 + R2 = %h", result);
        else
            $display("FAIL: Expected 08, Got %h", result);

        // --------------------------------
        // R1 - R2 = 2
        // --------------------------------

        alu_operation = 3'b001;

        #2;

        if (result == 8'h02)
            $display("PASS: R1 - R2 = %h", result);
        else
            $display("FAIL: Expected 02, Got %h", result);

        // --------------------------------
        // R1 AND R2
        // --------------------------------

        alu_operation = 3'b010;

        #2;

        if (result == 8'h01)
            $display("PASS: R1 AND R2 = %h", result);
        else
            $display("FAIL: Expected 01, Got %h", result);

        // --------------------------------
        // R1 OR R2
        // --------------------------------

        alu_operation = 3'b011;

        #2;

        if (result == 8'h07)
            $display("PASS: R1 OR R2 = %h", result);
        else
            $display("FAIL: Expected 07, Got %h", result);

        // --------------------------------
        // R1 XOR R2
        // --------------------------------

        alu_operation = 3'b100;

        #2;

        if (result == 8'h06)
            $display("PASS: R1 XOR R2 = %h", result);
        else
            $display("FAIL: Expected 06, Got %h", result);

        $display("==============================");
        $display("PROCESSING UNIT TEST COMPLETED");
        $display("==============================");

        $stop;

    end

endmodule