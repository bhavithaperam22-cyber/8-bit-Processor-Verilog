module instruction_memory (
    input  [7:0] address,
    output [15:0] instruction
);

    reg [15:0] memory [0:255];

    always @(*) begin

        case (address)

            // PC 0:
            // ADD R3 = R1 + R2
            8'd0: memory[address] = 16'h0CA0;

            // PC 1:
            // ADD R4 = R3 + R2
            8'd1: memory[address] = 16'h11A0;

            // PC 2:
            // SUB R5 = R4 - R1
            8'd2: memory[address] = 16'h3610;

            // PC 3:
            // AND R6 = R5 & R2
            8'd3: memory[address] = 16'h5AA0;

            // PC 4:
            // OR R7 = R3 | R2
            8'd4: memory[address] = 16'h7DA0;

            // PC 5:
            // NOT R0 = ~R1
            8'd5: memory[address] = 16'hA080;

            // PC 6:
            // SHIFT LEFT R0 = R1 << 1
            8'd6: memory[address] = 16'hC080;

            // PC 7:
            // SHIFT RIGHT R0 = R1 >> 1
            8'd7: memory[address] = 16'hE080;

            // Empty locations
            default:
                memory[address] = 16'h0000;

        endcase

    end

    assign instruction = memory[address];

endmodule