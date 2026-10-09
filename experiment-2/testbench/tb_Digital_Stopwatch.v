
`timescale 1ns/1ps

module tb_Digital_Stopwatch;

    reg CLOCK_50;
    reg [1:0] KEY;
    wire [6:0] HEX0;
    wire [6:0] HEX1;

    // Instantiate the stopwatch design
    Digital_Stopwatch uut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1)
    );

    // Generate 50 MHz clock (20 ns period)
    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        // DE10-Lite push buttons are active-low
        KEY = 2'b11;

        // Reset stopwatch (press KEY[1])
        KEY[1] = 1'b0;
        #100;
        KEY[1] = 1'b1;
        #100;

        // Start stopwatch (press KEY[0])
        KEY[0] = 1'b0;
        #40;
        KEY[0] = 1'b1;

        // Allow stopwatch to run
        #2000000;

        // Stop stopwatch (press KEY[0] again)
        KEY[0] = 1'b0;
        #40;
        KEY[0] = 1'b1;

        #100;
        $finish;
    end

    initial begin
        $monitor("Time=%0t KEY=%b HEX1=%b HEX0=%b",
                 $time, KEY, HEX1, HEX0);
    end

endmoduleS