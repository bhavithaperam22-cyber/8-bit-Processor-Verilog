`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;

    reg write_enable;
    reg [2:0] write_address;
    reg [7:0] write_data;

    reg [2:0] read_address_a;
    reg [2:0] read_address_b;

    wire [7:0] read_data_a;
    wire [7:0] read_data_b;

    register_file DUT (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_address(write_address),
        .write_data(write_data),
        .read_address_a(read_address_a),
        .read_address_b(read_address_b),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b)
    );

    always #5 clk = ~clk;

    task check_register;
        input [7:0] expected_a;
        input [7:0] expected_b;

        begin
            #2;

            if ((read_data_a == expected_a) &&
                (read_data_b == expected_b))

                $display("PASS: ReadA=%h ReadB=%h",
                         read_data_a, read_data_b);

            else

                $display("FAIL: ReadA=%h ReadB=%h ExpectedA=%h ExpectedB=%h",
                         read_data_a, read_data_b,
                         expected_a, expected_b);
        end
    endtask

    initial begin

        clk = 0;
        reset = 1;

        write_enable = 0;
        write_address = 0;
        write_data = 0;

        read_address_a = 0;
        read_address_b = 0;

        #12;

        reset = 0;

        // Write 5 into R1
        @(negedge clk);
        write_enable = 1;
        write_address = 3'b001;
        write_data = 8'h05;

        @(negedge clk);
        write_enable = 0;

        // Write 3 into R2
        write_enable = 1;
        write_address = 3'b010;
        write_data = 8'h03;

        @(negedge clk);
        write_enable = 0;

        // Read R1 and R2
        read_address_a = 3'b001;
        read_address_b = 3'b010;

        check_register(8'h05, 8'h03);

        // Write 8 into R3
        write_enable = 1;
        write_address = 3'b011;
        write_data = 8'h08;

        @(negedge clk);
        write_enable = 0;

        // Read R3
        read_address_a = 3'b011;
        read_address_b = 3'b000;

        check_register(8'h08, 8'h00);

        $display("==============================");
        $display("REGISTER FILE TEST COMPLETED");
        $display("==============================");

        $stop;

    end

endmodule