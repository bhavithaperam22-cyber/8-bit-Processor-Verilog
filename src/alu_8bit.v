module alu_8bit (
    input  [7:0] A,
    input  [7:0] B,
    input  [2:0] OP,
    output reg [7:0] Result,
    output reg       Carry,
    output reg       Overflow,
    output reg       Zero
);

always @(*) begin

    Result   = 8'b00000000;
    Carry    = 1'b0;
    Overflow = 1'b0;

    case (OP)

        3'b000: begin
            // ADD
            {Carry, Result} = A + B;
            Overflow = (~(A[7] ^ B[7])) &
                       (Result[7] ^ A[7]);
        end

        3'b001: begin
            // SUB
            Result = A - B;
            Overflow = (A[7] ^ B[7]) &
                       (Result[7] ^ A[7]);
        end

        3'b010: begin
            // AND
            Result = A & B;
        end

        3'b011: begin
            // OR
            Result = A | B;
        end

        3'b100: begin
            // XOR
            Result = A ^ B;
        end

        3'b101: begin
            // NOT A
            Result = ~A;
        end

        3'b110: begin
            // SHIFT LEFT
            Result = A << 1;
            Carry = A[7];
        end

        3'b111: begin
            // SHIFT RIGHT
            Result = A >> 1;
            Carry = A[0];
        end

    endcase

    // ZERO FLAG
    if (Result == 8'b00000000)
        Zero = 1'b1;
    else
        Zero = 1'b0;

end

endmodule