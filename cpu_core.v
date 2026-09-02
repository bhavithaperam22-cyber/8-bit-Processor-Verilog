module cpu_core (
    input        clk,
    input        reset,

    // External register loading
    input        load_enable,
    input  [2:0] load_address,
    input  [7:0] load_data,

    // Register read addresses
    input  [2:0] read_address_a,
    input  [2:0] read_address_b,

    // Destination register
    input  [2:0] write_address,

    // Instruction / operation
    input  [2:0] opcode,

    // Outputs
    output [7:0] result,
    output       carry,
    output       overflow,
    output       zero
);

    // ==========================================
    // CONTROL UNIT OUTPUTS
    // ==========================================

    wire [2:0] alu_operation;
    wire       control_write_enable;


    // ==========================================
    // CONNECTIONS TO PROCESSING UNIT
    // ==========================================

    wire       final_write_enable;
    wire [2:0] final_write_address;
    wire [7:0] final_write_data;


    // ==========================================
    // CONTROL UNIT
    // ==========================================

    control_unit CU (
        .opcode(opcode),
        .alu_operation(alu_operation),
        .write_enable(control_write_enable)
    );


    // ==========================================
    // WRITE CONTROL
    // ==========================================

    // When loading data, use external load signals.
    // Otherwise, use the normal CPU operation.

    assign final_write_enable =
            load_enable ? 1'b1 : control_write_enable;

    assign final_write_address =
            load_enable ? load_address : write_address;

    assign final_write_data =
            load_enable ? load_data : result;


    // ==========================================
    // PROCESSING UNIT
    // Contains Register File + ALU
    // ==========================================

    processing_unit PU (
        .clk(clk),
        .reset(reset),

        .write_enable(final_write_enable),
        .write_address(final_write_address),
        .write_data(final_write_data),

        .read_address_a(read_address_a),
        .read_address_b(read_address_b),

        .alu_operation(alu_operation),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero)
    );

endmodule