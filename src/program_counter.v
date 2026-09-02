module program_counter (
    input        clk,
    input        reset,
    output reg [7:0] pc
);

    always @(posedge clk or posedge reset) begin

        if (reset)
            pc <= 8'b00000000;

        else
            pc <= pc + 8'b00000001;

    end

endmodule