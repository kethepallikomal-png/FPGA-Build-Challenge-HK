module Traffic_Light_Controller (
    input  wire CLOCK_50,
    output reg  LED_RED,
    output reg  LED_YELLOW,
    output reg  LED_GREEN
);

    // 50 MHz clock
    // 50,000,000 clock cycles = 1 second
    reg [25:0] counter;

    // Traffic-light state
    reg [1:0] state;

    localparam RED    = 2'b00;
    localparam GREEN  = 2'b01;
    localparam YELLOW = 2'b10;

    // State timing
    // RED    = 5 seconds
    // GREEN  = 5 seconds
    // YELLOW = 2 seconds

    always @(posedge CLOCK_50) begin

        if (counter == 26'd49_999_999) begin
            counter <= 26'd0;

            case (state)

                RED: begin
                    state <= GREEN;
                end

                GREEN: begin
                    state <= YELLOW;
                end

                YELLOW: begin
                    state <= RED;
                end

                default: begin
                    state <= RED;
                end

            endcase
        end
        else begin
            counter <= counter + 1'b1;
        end

    end

    // Control traffic-light LEDs
    always @(*) begin

        LED_RED    = 1'b0;
        LED_YELLOW = 1'b0;
        LED_GREEN  = 1'b0;

        case (state)

            RED: begin
                LED_RED = 1'b1;
            end

            GREEN: begin
                LED_GREEN = 1'b1;
            end

            YELLOW: begin
                LED_YELLOW = 1'b1;
            end

            default: begin
                LED_RED = 1'b1;
            end

        endcase

    end

endmodule