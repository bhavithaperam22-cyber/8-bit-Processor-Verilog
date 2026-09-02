module register_file (
    input        clk,
    input        reset,

    input        write_enable,
    input  [2:0] write_address,
    input  [7:0] write_data,

    input  [2:0] read_address_a,
    input  [2:0] read_address_b,

    output [7:0] read_data_a,
    output [7:0] read_data_b
);

    reg [7:0] registers [0:7];

    integer i;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            for (i = 0; i < 8; i = i + 1)
                registers[i] <= 8'b00000000;
        end

        else if (write_enable) begin
            registers[write_address] <= write_data;
        end

    end

    assign read_data_a = registers[read_address_a];
    assign read_data_b = registers[read_address_b];

endmodule