module ControladorLED (
    input clk,
    input reset,
    input controlar_led,
    output reg led
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led <= 0;
        end else begin
            led <= controlar_led;
        end
    end

endmodule