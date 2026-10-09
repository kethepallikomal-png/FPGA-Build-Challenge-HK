
`timescale 1ns/1ps

module tb_Traffic_Light_Controller;

    reg CLOCK_50;
    wire LED_RED;
    wire LED_YELLOW;
    wire LED_GREEN;

    // Instantiate the traffic light controller
    Traffic_Light_Controller uut (
        .CLOCK_50(CLOCK_50),
        .LED_RED(LED_RED),
        .LED_YELLOW(LED_YELLOW),
        .LED_GREEN(LED_GREEN)
    );

    // Generate 50 MHz clock (20 ns period)
    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    // Monitor traffic light outputs
    initial begin
        $monitor("Time=%0t | RED=%b | YELLOW=%b | GREEN=%b",
                 $time, LED_RED, LED_YELLOW, LED_GREEN);
    end

    // Run simulation
    initial begin
        #100000000;
        $finish;
    end

endmodule