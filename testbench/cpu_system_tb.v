`timescale 1ns/1ps

module cpu_system_tb;

    reg clk;
    reg reset;

    reg        load_enable;
    reg  [2:0] load_address;
    reg  [7:0] load_data;

    wire [7:0] result;
    wire       carry;
    wire       overflow;
    wire       zero;

    wire [7:0] pc;
    wire [15:0] instruction;


    // =========================================
    // CPU SYSTEM
    // =========================================

    cpu_system DUT (

        .clk(clk),
        .reset(reset),

        .load_enable(load_enable),
        .load_address(load_address),
        .load_data(load_data),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero),

        .pc(pc),
        .instruction(instruction)

    );


    // =========================================
    // CLOCK
    // =========================================

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // =========================================
    // TEST
    // =========================================

    initial begin

        // -------------------------------------
        // INITIAL RESET
        // -------------------------------------

        reset = 1;
        load_enable = 0;
        load_address = 0;
        load_data = 0;

        #10;

        reset = 0;


        // -------------------------------------
        // LOAD R1 = 10
        // -------------------------------------

        @(negedge clk);

        load_enable = 1;
        load_address = 3'b001;
        load_data = 8'h0A;


        @(negedge clk);

        load_enable = 0;


        // -------------------------------------
        // LOAD R2 = 5
        // -------------------------------------

        @(negedge clk);

        load_enable = 1;
        load_address = 3'b010;
        load_data = 8'h05;


        @(negedge clk);

        load_enable = 0;


        // =====================================
        // PROGRAM STARTS AT PC = 0
        // =====================================

        // Show instruction at PC 0
        #1;

        $display("");
        $display("==========================================");
        $display("       8-BIT CPU PROGRAM EXECUTION");
        $display("==========================================");


        // -------------------------------------
        // PC 0
        // R3 = R1 + R2
        // 10 + 5 = 15 = 0F
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h0F)
            $display("PC 0 ADD TEST: PASS");
        else
            $display("PC 0 ADD TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 1
        // R4 = R3 + R2
        // 15 + 5 = 20 = 14
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h14)
            $display("PC 1 WRITEBACK TEST: PASS");
        else
            $display("PC 1 WRITEBACK TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 2
        // R5 = R4 - R1
        // 20 - 10 = 10 = 0A
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h0A)
            $display("PC 2 SUB TEST: PASS");
        else
            $display("PC 2 SUB TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 3
        // R6 = R5 & R2
        // 10 & 5 = 0
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h00)
            $display("PC 3 AND TEST: PASS");
        else
            $display("PC 3 AND TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 4
        // R7 = R3 | R2
        // 15 | 5 = 15 = 0F
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h0F)
            $display("PC 4 OR TEST: PASS");
        else
            $display("PC 4 OR TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 5
        // R0 = ~R1
        // ~0A = F5
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'hF5)
            $display("PC 5 NOT TEST: PASS");
        else
            $display("PC 5 NOT TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 6
        // R0 = R1 << 1
        // 0A << 1 = 14
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h14)
            $display("PC 6 SHIFT LEFT TEST: PASS");
        else
            $display("PC 6 SHIFT LEFT TEST: FAIL");


        @(posedge clk);
        #1;


        // -------------------------------------
        // PC 7
        // R0 = R1 >> 1
        // 0A >> 1 = 05
        // -------------------------------------

        $display("PC=%d  INSTRUCTION=%h  RESULT=%h",
                 pc, instruction, result);

        if (result == 8'h05)
            $display("PC 7 SHIFT RIGHT TEST: PASS");
        else
            $display("PC 7 SHIFT RIGHT TEST: FAIL");


        $display("");
        $display("==========================================");
        $display("       COMPLETE CPU TEST FINISHED");
        $display("==========================================");

        $stop;

    end

endmodule