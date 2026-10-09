module Digital_Stopwatch (
    input  wire       CLOCK_50,
    input  wire [1:0] KEY,
    output wire [6:0] HEX0,
    output wire [6:0] HEX1
);

    // 50 MHz clock
    // 50,000,000 clock cycles = 1 second
    reg [25:0] counter;

    // Stopwatch state
    reg running;

    // Previous button states
    reg key0_prev;
    reg key1_prev;

    // Digits
    reg [3:0] ones;
    reg [3:0] tens;

    // ------------------------------------------------
    // Stopwatch logic
    // ------------------------------------------------
    always @(posedge CLOCK_50) begin

        // Save previous button states
        key0_prev <= KEY[0];
        key1_prev <= KEY[1];

        // KEY1 = Reset
        // Buttons on DE10-Lite are active LOW
        if (!KEY[1] && key1_prev) begin
            counter <= 26'd0;
            ones    <= 4'd0;
            tens    <= 4'd0;
            running <= 1'b0;
        end

        else begin

            // KEY0 = Start / Stop
            if (!KEY[0] && key0_prev) begin
                running <= ~running;
            end

            // Count only when stopwatch is running
            if (running) begin

                if (counter == 26'd49_999_999) begin

                    counter <= 26'd0;

                    // 99 -> 00
                    if ((tens == 4'd9) && (ones == 4'd9)) begin
                        tens <= 4'd0;
                        ones <= 4'd0;
                    end

                    // 09 -> 10
                    else if (ones == 4'd9) begin
                        ones <= 4'd0;
                        tens <= tens + 1'b1;
                    end

                    // 00 -> 01
                    else begin
                        ones <= ones + 1'b1;
                    end

                end

                else begin
                    counter <= counter + 1'b1;
                end
            end
        end
    end


    // ------------------------------------------------
    // 7-segment display decoder
    // Displays are active LOW
    // ------------------------------------------------

    seven_segment U0 (
        .digit(ones),
        .segments(HEX0)
    );

    seven_segment U1 (
        .digit(tens),
        .segments(HEX1)
    );

endmodule


// ====================================================
// 7-Segment Decoder
// ====================================================

module seven_segment (
    input  wire [3:0] digit,
    output reg  [6:0] segments
);

    always @(*) begin

        case (digit)

            4'd0: segments = 7'b1000000;
            4'd1: segments = 7'b1111001;
            4'd2: segments = 7'b0100100;
            4'd3: segments = 7'b0110000;
            4'd4: segments = 7'b0011001;
            4'd5: segments = 7'b0010010;
            4'd6: segments = 7'b0000010;
            4'd7: segments = 7'b1111000;
            4'd8: segments = 7'b0000000;
            4'd9: segments = 7'b0010000;

            default: segments = 7'b1111111;

        endcase

    end

endmodule