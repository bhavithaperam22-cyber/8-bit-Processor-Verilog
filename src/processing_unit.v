module processing_unit (
    input        clk,
    input        reset,

    // Register file write control
    input        write_enable,
    input  [2:0] write_address,
    input  [7:0] write_data,

    // Register file read addresses
    input  [2:0] read_address_a,
    input  [2:0] read_address_b,

    // ALU operation
    input  [2:0] alu_operation,

    // Outputs
    output [7:0] result,
    output       carry,
    output       overflow,
    output       zero
);

    // Wires connecting Register File to ALU
    wire [7:0] register_a;
    wire [7:0] register_b;

    // Instantiate Register File
    register_file RF (
        .clk(clk),
        .reset(reset),

        .write_enable(write_enable),
        .write_address(write_address),
        .write_data(write_data),

        .read_address_a(read_address_a),
        .read_address_b(read_address_b),

        .read_data_a(register_a),
        .read_data_b(register_b)
    );

    // Instantiate your existing ALU
    alu_8bit ALU (
        .A(register_a),
        .B(register_b),
        .OP(alu_operation),
        .Result(result),
        .Carry(carry),
        .Overflow(overflow),
        .Zero(zero)
    );

endmodule