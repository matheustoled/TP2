module top_module (
    input clk,
    input reset,
    input insere,
    input [3:0] entrada,
    output [6:0] display1,
    output led
);

    wire [3:0] estadoatual;
    wire [3:0] proximoestado;
    wire controlar_led;

    Controlador controlador_inst (
        .clk(clk),
        .reset(reset),
        .insere(insere),
        .entrada(entrada),
        .estadoatual(estadoatual),
        .proximoestado(proximoestado),
        .controlar_led(controlar_led)
    );

    MapeamentoDisplay mapeamentodisplay_inst (
        .entrada(entrada),
        .estado(estadoatual),
        .display1(display1)
    );

    ControladorLED controladorled_inst (
        .clk(clk),
        .reset(reset),
        .controlar_led(controlar_led),
        .led(led)
    );

endmodule