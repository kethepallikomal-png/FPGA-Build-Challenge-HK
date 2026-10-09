
`timescale 1ns/1ps

module tb_LED_Switch;

    reg  [9:0] SW;
    wire [9:0] LEDR;

    // Instantiate the design under test
    LED_Switch uut (
        .SW(SW),
        .LEDR(LEDR)
    );

    initial begin
        // Initialize all switches to OFF
        SW = 10'b0000000000;
        #10;

        // Test switch 0
        SW = 10'b0000000001;
        #10;

        // Test switch 1
        SW = 10'b0000000010;
        #10;

        // Test multiple switches
        SW = 10'b0000010101;
        #10;

        // Test all switches ON
        SW = 10'b1111111111;
        #10;

        // Test all switches OFF
        SW = 10'b0000000000;
        #10;

        $finish;
    end

    // Display input and output values
    initial begin
        $monitor("Time=%0t | SW=%b | LEDR=%b", $time, SW, LEDR);
    end

endmodule