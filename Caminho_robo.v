module robot_path (
    input wire clk,
    input wire reset,
    input wire insere,
    input wire [3:0] path_input,
    output reg [1:0] display_state, // 2'b00: STATE_S, 2'b01: STATE_P, 2'b10: STATE_F
    output reg [6:0] display_7seg, // Segmentos do display
    output reg led_error, // LED de erro
    output reg [2:0] step_counter, // Contador de etapas do caminho
    output reg [2:0] error_count   // Contador de erros
);

    // Definição dos estados
    localparam STATE_I = 2'b11; // Estado inicial
    localparam STATE_S = 2'b00; // Sucesso total
    localparam STATE_P = 2'b01; // Sucesso parcial
    localparam STATE_F = 2'b10; // Falha

    // Caminho esperado
    reg [3:0] expected_path [0:5];
    initial begin
        expected_path[0] = 4'b0101; // 5
        expected_path[1] = 4'b1001; // 9
        expected_path[2] = 4'b0000; // 0
        expected_path[3] = 4'b0000; // 0
        expected_path[4] = 4'b0110; // 6
        expected_path[5] = 4'b0000; // 0
    end

    // 7'b0100101; // 5
    // 7'b0000100; // 9
    // 7'b0000001; // 0
    // 7'b0000001; // 0
    // 7'b0100000; // 6
    // 7'b0000001; // 0

    // Atualização do display com base no `path_input`
    function [6:0] get_7seg;
        input [3:0] value;
        case (value)
            4'b0000: get_7seg = 7'b0000001; // 0
            4'b0001: get_7seg = 7'b1001111; // 1
            4'b0010: get_7seg = 7'b0010010; // 2
            4'b0011: get_7seg = 7'b0000110; // 3
            4'b0100: get_7seg = 7'b1001100; // 4
            4'b0101: get_7seg = 7'b0100100; // 5
            4'b0110: get_7seg = 7'b0100000; // 6
            4'b0111: get_7seg = 7'b0001111; // 7
            4'b1000: get_7seg = 7'b0000000; // 8
            4'b1001: get_7seg = 7'b0000100; // 9
            default: get_7seg = 7'b1111110; // -
        endcase
    endfunction

    // Lógica
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            step_counter <= 3'b000;
            error_count <= 3'b000;
            display_state <= STATE_I;
            display_7seg <= 7'b1111110; // Display estado inicial
            led_error <= 1'b1; // Led desligado
        end else if (insere) begin
            // Comparação com o caminho esperado
            if (path_input == expected_path[step_counter]) begin
                display_7seg <= get_7seg(path_input); // Atualiza o display
                error_count <= error_count; // Sem incremento
                if (step_counter < 6) begin
                    step_counter <= step_counter + 1;
                end
            end else begin
                display_7seg <= get_7seg(path_input); // Atualiza o display
                error_count <= error_count + 1;
                led_error <= 1'b0;
            end

            // Atualiza estado final ao término do caminho
            if (step_counter == 6 || error_count >= 2) begin
                case (error_count)
                    0: begin
                        display_state <= STATE_S; // Caminho correto
                        led_error <= 1'b1;
                    end
                    1: begin
                        display_state <= STATE_P; // Um erro
                        led_error <= 1'b0;
                    end
                    2: begin
                        display_state <= STATE_F; // Dois ou mais erros
                        led_error <= 1'b0;
                    end
                    default: begin
                        display_state <= STATE_I; // Inicio
                        led_error <= 1'b1;
                    end
                endcase
            end
        end
    end

    // Atualização do display de 7 segmentos com base no estado
    always @(*) begin
        case (display_state)
            STATE_S: display_7seg = 7'b0100010; // "S" no display para sucesso
            STATE_P: display_7seg = 7'b0011000; // "P" no display para parcial
            STATE_F: display_7seg = 7'b0111000; // "F" no display para falha
            default: display_7seg = 7'b1111110; // Inicial "-"
        endcase
    end

endmodule


// STATE_S = 2'b00; Sucesso total
// STATE_P = 2'b01; Sucesso parcial
// STATE_F = 2'b10; Falha

// STATE_S: display_7seg = 7'b0100010; "S" no display para sucesso
// STATE_P: display_7seg = 7'b0011000; "P" no display para parcial
// STATE_F: display_7seg = 7'b0111000; "F" no display para falha