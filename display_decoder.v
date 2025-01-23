module DisplayDecoder (
    input [3:0] entrada,
    input [3:0] estado, // Corrigido para usar o nome correto
    output reg [6:0] display1);

    // Decodificação do número
    always @(*) begin
        case (entrada)
            4'b0000: display1 = 7'b0000001;
            4'b0001: display1 = 7'b1001111;
            4'b0010: display1 = 7'b0010010;
            4'b0011: display1 = 7'b0000110;
            4'b0100: display1 = 7'b1001100;
            4'b0101: display1 = 7'b0100100;
            4'b0110: display1 = 7'b0100000;
            4'b0111: display1 = 7'b0001111;
            4'b1000: display1 = 7'b0000000;
            4'b1001: display1 = 7'b0000100;
            default: display1 = 7'b1111110; // Erro
        endcase
        case(estado)
            4'b0110: display1 = 7'b0100100; // sucessototal
            4'b1101: display1 = 7'b0011000; // sucessoparcial
            4'b1110: display1 = 7'b0111000; // falha
        endcase
    end
endmodule
