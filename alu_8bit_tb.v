`timescale 1ns/1ps

module alu_8bit_tb;

    reg  [7:0] A;
    reg  [7:0] B;
    reg  [2:0] OP;

    wire [7:0] Result;
    wire       Carry;
    wire       Overflow;
    wire       Zero;

    // Instantiate the ALU
    alu_8bit DUT (
        .A(A),
        .B(B),
        .OP(OP),
        .Result(Result),
        .Carry(Carry),
        .Overflow(Overflow),
        .Zero(Zero)
    );

    // Test procedure
    task check_result;
        input [7:0] expected_result;
        input       expected_carry;
        input       expected_overflow;
        input       expected_zero;

        begin
            #10;

            if ((Result == expected_result) &&
                (Carry == expected_carry) &&
                (Overflow == expected_overflow) &&
                (Zero == expected_zero))

                $display("PASS: A=%h B=%h OP=%b Result=%h Carry=%b Overflow=%b Zero=%b",
                         A, B, OP, Result, Carry, Overflow, Zero);

            else

                $display("FAIL: A=%h B=%h OP=%b Result=%h Carry=%b Overflow=%b Zero=%b",
                         A, B, OP, Result, Carry, Overflow, Zero);
        end
    endtask


    initial begin

        // ADDITION
        A = 8'h05;
        B = 8'h03;
        OP = 3'b000;
        check_result(8'h08, 1'b0, 1'b0, 1'b0);

        // SUBTRACTION
        A = 8'h08;
        B = 8'h03;
        OP = 3'b001;
        check_result(8'h05, 1'b0, 1'b0, 1'b0);

        // AND
        A = 8'hAA;
        B = 8'h0F;
        OP = 3'b010;
        check_result(8'h0A, 1'b0, 1'b0, 1'b0);

        // OR
        A = 8'hA0;
        B = 8'h0F;
        OP = 3'b011;
        check_result(8'hAF, 1'b0, 1'b0, 1'b0);

        // XOR
        A = 8'hAA;
        B = 8'hFF;
        OP = 3'b100;
        check_result(8'h55, 1'b0, 1'b0, 1'b0);

        // NOT
        A = 8'hAA;
        B = 8'h00;
        OP = 3'b101;
        check_result(8'h55, 1'b0, 1'b0, 1'b0);

        // SHIFT LEFT
        A = 8'b10000001;
        B = 8'h00;
        OP = 3'b110;
        check_result(8'b00000010, 1'b1, 1'b0, 1'b0);

        // SHIFT RIGHT
        A = 8'b00000001;
        B = 8'h00;
        OP = 3'b111;
        check_result(8'b00000000, 1'b1, 1'b0, 1'b1);

        $display("====================================");
        $display("ALL ALU TESTS COMPLETED");
        $display("====================================");

        $stop;

    end

endmodule