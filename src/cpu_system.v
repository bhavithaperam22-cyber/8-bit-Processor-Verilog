module cpu_system (

    input        clk,
    input        reset,

    // External register loading
    input        load_enable,
    input  [2:0] load_address,
    input  [7:0] load_data,

    // CPU outputs
    output [7:0] result,
    output       carry,
    output       overflow,
    output       zero,

    // Debug outputs
    output [7:0] pc,
    output [15:0] instruction

);

    // ==========================================
    // KEEP PC AT ZERO WHILE LOADING REGISTERS
    // ==========================================

    wire pc_reset;

    assign pc_reset = reset | load_enable;


    // ==========================================
    // PROGRAM COUNTER
    // ==========================================

    program_counter PC (
        .clk(clk),
        .reset(pc_reset),
        .pc(pc)
    );


    // ==========================================
    // INSTRUCTION MEMORY
    // ==========================================

    instruction_memory IM (
        .address(pc),
        .instruction(instruction)
    );


    // ==========================================
    // INSTRUCTION DECODER
    // ==========================================

    wire [2:0] opcode;
    wire [2:0] write_address;
    wire [2:0] read_address_a;
    wire [2:0] read_address_b;

    assign opcode          = instruction[15:13];
    assign write_address   = instruction[12:10];
    assign read_address_a  = instruction[9:7];
    assign read_address_b  = instruction[6:4];


    // ==========================================
    // CPU CORE
    // ==========================================

    cpu_core CPU (

        .clk(clk),

        // IMPORTANT:
        // This reset resets registers,
        // but does NOT reset the PC.
        .reset(reset),

        .load_enable(load_enable),
        .load_address(load_address),
        .load_data(load_data),

        .read_address_a(read_address_a),
        .read_address_b(read_address_b),

        .write_address(write_address),

        .opcode(opcode),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero)

    );

endmodule