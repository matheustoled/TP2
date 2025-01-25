module Controlador (
    input clk,
    input reset,
    input insere,
    input [3:0] entrada,
    output reg [3:0] estadoatual,
    output reg [3:0] proximoestado,
    output reg controlar_led
);
    // Definicão de estados
    localparam inicial = 4'b0000;
    // Sucesso
    localparam path1 = 4'b0001;
    localparam path2 = 4'b0010;
    localparam path3 = 4'b0011;
    localparam path4 = 4'b0100;
    localparam path5 = 4'b0101;
    localparam path6_sucesso = 4'b0110;
    // Parcial
    localparam path1_e = 4'b0111;
    localparam path2_e = 4'b1000;
    localparam path3_e = 4'b1001;
    localparam path4_e = 4'b1010;
    localparam path5_e = 4'b1011;
    localparam path6_e = 4'b1100;
    localparam path7_parcial = 4'b1101;
    // Falha
    localparam falha = 4'b1110;

    // Lógica de transição de estados
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            estadoatual <= inicial;
        end else begin
            estadoatual <= proximoestado;
        end
    end

    // Lógica de próximo estado
    always @(*) begin
        if(estadoatual == inicial) begin
        controlar_led = 0;
        end
        if (insere == 0) begin
            case (estadoatual)
                inicial: begin
                    controlar_led = 0;
                    if (entrada != 4'b0101) begin
                        proximoestado = path1_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b0101) begin
                        proximoestado = path1;
                        controlar_led = 0;
                    end
                end
                path1: begin
                    if (entrada != 4'b1001) begin
                        proximoestado = path2_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b1001) begin
                        proximoestado = path2;
                        controlar_led = 0;
                    end
                end
                path2: begin
                    if (entrada != 4'b0000) begin
                        proximoestado = path3_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path3;
                        controlar_led = 0;
                    end
                end
                path3: begin
                    if (entrada != 4'b0000) begin
                        proximoestado = path4_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path4;
                        controlar_led = 0;
                    end
                end
                path4: begin
                    if (entrada != 4'b0110) begin
                        proximoestado = path5_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b0110) begin
                        proximoestado = path5;
                        controlar_led = 0;
                    end
                end
                path5: begin
                    if (entrada != 4'b0000) begin
                        proximoestado = path6_e;
                        controlar_led = 1;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path6_sucesso;
                        controlar_led = 0;
                    end
                end
                path6_sucesso: begin
                    proximoestado = path6_sucesso;
                end
                path1_e: begin
                    if(entrada != 4'b0101) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b0101) begin
                        proximoestado = path2_e;
                    end
                end
                path2_e: begin
                    if(entrada != 4'b1001) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b1001) begin
                        proximoestado = path3_e;
                    end
                end
                path3_e: begin
                    if(entrada != 4'b0000) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path4_e;
                    end
                end
                path4_e: begin
                    if(entrada != 4'b0000) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path5_e;
                    end
                end
                path5_e: begin
                    if(entrada != 4'b0110) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b0110) begin
                        proximoestado = path6_e;
                    end
                end
                path6_e: begin
                    if(entrada != 4'b0000) begin
                        proximoestado = falha;
                    end else if (entrada == 4'b0000) begin
                        proximoestado = path7_parcial;
                    end
                end
                path7_parcial: begin
                    proximoestado = path7_parcial;
                end
                falha: begin
                    proximoestado = falha;
                end
            endcase
        end else begin
            proximoestado = estadoatual;
        end
    end
endmodule
