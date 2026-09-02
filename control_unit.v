module control_unit (
    input  [2:0] opcode,

    output reg [2:0] alu_operation,
    output reg       write_enable
);

    always @(*) begin

        alu_operation = 3'b000;
        write_enable  = 1'b0;

        case (opcode)

            3'b000: begin
                // ADD
                alu_operation = 3'b000;
                write_enable  = 1'b1;
            end

            3'b001: begin
                // SUB
                alu_operation = 3'b001;
                write_enable  = 1'b1;
            end

            3'b010: begin
                // AND
                alu_operation = 3'b010;
                write_enable  = 1'b1;
            end

            3'b011: begin
                // OR
                alu_operation = 3'b011;
                write_enable  = 1'b1;
            end

            3'b100: begin
                // XOR
                alu_operation = 3'b100;
                write_enable  = 1'b1;
            end

            3'b101: begin
                // NOT
                alu_operation = 3'b101;
                write_enable  = 1'b1;
            end

            3'b110: begin
                // SHIFT LEFT
                alu_operation = 3'b110;
                write_enable  = 1'b1;
            end

            3'b111: begin
                // SHIFT RIGHT
                alu_operation = 3'b111;
                write_enable  = 1'b1;
            end

            default: begin
                alu_operation = 3'b000;
                write_enable  = 1'b0;
            end

        endcase

    end

endmodule