`timescale 1ns/1ps

module cpu_core_tb;

    reg clk;
    reg reset;

    // External register loading
    reg        load_enable;
    reg  [2:0] load_address;
    reg  [7:0] load_data;

    // Register read addresses
    reg  [2:0] read_address_a;
    reg  [2:0] read_address_b;

    // Instruction
    reg  [2:0] opcode;

    // Outputs
    wire [7:0] result;
    wire       carry;
    wire       overflow;
    wire       zero;


    // =========================================
    // CPU CORE
    // =========================================

    cpu_core DUT (

        .clk(clk),
        .reset(reset),

        .load_enable(load_enable),
        .load_address(load_address),
        .load_data(load_data),

        .read_address_a(read_address_a),
        .read_address_b(read_address_b),

        .opcode(opcode),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero)

    );


    // =========================================
    // CLOCK
    // =========================================

    always #5 clk = ~clk;


    // =========================================
    // TEST
    // =========================================

    initial begin

        clk = 0;
        reset = 1;

        load_enable = 0;
        load_address = 0;
        load_data = 0;

        read_address_a = 0;
        read_address_b = 0;

        opcode = 0;

        #10;

        reset = 0;


        // =====================================
        // LOAD R1 = 10
        // =====================================

        load_enable = 1;
        load_address = 3'b001;
        load_data = 8'h0A;

        #10;

        load_enable = 0;


        // =====================================
        // LOAD R2 = 5
        // =====================================

        load_enable = 1;
        load_address = 3'b010;
        load_data = 8'h05;

        #10;

        load_enable = 0;


        // =====================================
        // ADD R1 + R2
        // =====================================

        read_address_a = 3'b001;
        read_address_b = 3'b010;

        opcode = 3'b000;

        #10;

        $display("--------------------------------");
        $display("CPU CORE TEST");
        $display("R1 = %h", 8'h0A);
        $display("R2 = %h", 8'h05);
        $display("ADD RESULT = %h", result);
        $display("CARRY = %b", carry);
        $display("OVERFLOW = %b", overflow);
        $display("ZERO = %b", zero);
        $display("--------------------------------");


        // =====================================
        // SUBTRACT R1 - R2
        // =====================================

        opcode = 3'b001;

        #10;

        $display("SUB RESULT = %h", result);


        // =====================================
        // AND
        // =====================================

        opcode = 3'b010;

        #10;

        $display("AND RESULT = %h", result);


        // =====================================
        // OR
        // =====================================

        opcode = 3'b011;

        #10;

        $display("OR RESULT = %h", result);


        // =====================================
        // XOR
        // =====================================

        opcode = 3'b100;

        #10;

        $display("XOR RESULT = %h", result);


        // =====================================
        // SHIFT LEFT
        // =====================================

        opcode = 3'b101;

        #10;

        $display("SHIFT LEFT RESULT = %h", result);


        // =====================================
        // SHIFT RIGHT
        // =====================================

        opcode = 3'b110;

        #10;

        $display("SHIFT RIGHT RESULT = %h", result);


        // =====================================
        // PASS
        // =====================================

        opcode = 3'b111;

        #10;

        $display("PASS RESULT = %h", result);


        $display("================================");
        $display("CPU CORE TEST COMPLETED");
        $display("================================");

        $stop;

    end

endmodule