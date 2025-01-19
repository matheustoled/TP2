`timescale 1ns / 1ps

module tb_robot_path;

    // Entradas do módulo robot_path
    reg clk;
    reg reset;
    reg insere;
    reg [3:0] path_input;

    // Saídas do módulo robot_path
    wire [1:0] display_state;
    wire [6:0] display_7seg;
    wire led_error;
    wire [2:0] step_counter; // Monitoramento do contador de etapas
    wire [2:0] error_count;  // Monitoramento do contador de erros

    // Instanciando o módulo robot_path
    robot_path uut (
        .clk(clk),
        .reset(reset),
        .insere(insere),
        .path_input(path_input),
        .display_state(display_state),
        .display_7seg(display_7seg),
        .led_error(led_error),
        .step_counter(step_counter),
        .error_count(error_count)
    );

    // Geração do clock
    always begin
        #5 clk = ~clk; // Clock com período de 10 ns
    end

    // Função para simular o comportamento de apertar e soltar o botão
    task press_button;
        begin
            insere = 1; #10; // Aperta o botão
            insere = 0; #10; // Solta o botão
        end
    endtask

    // Testbench
    initial begin
        clk = 0;
        reset = 0;
        insere = 0;
        path_input = 4'b0000;

        // Reset inicial
        $display("Reset inicial");
        reset = 1;
        #10 reset = 0;

        $display("Time=%0t, reset=%b, insere=%b, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, reset, insere, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        // Inserção de caminho correto
        reset = 1;
        #10 reset = 0;
        $display("\nTeste 1: Caminho correto");

        path_input = 4'b0101; // 5
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b1001; // 9
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0110; // 6
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        press_button();
        $display("Sucesso!!! -> display_state = %b, display_7seg = %b", display_state, display_7seg);

        // Teste com 1 erro
        $display("\nTeste 2: Caminho incorreto (1 erro)");

        reset = 1;
        #10 reset = 0;

        path_input = 4'b0101; // 5
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b1001; // 9
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0111; // 7
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0110; // 6
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0000; // 0
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        press_button();
        $display("sera?? -> display_state = %b, display_7seg = %b", display_state, display_7seg);

        // Teste com 2 erros
        $display("\nTeste 3: Caminho incorreto (2 erro)");

        reset = 1;
        #10 reset = 0;

        path_input = 4'b0011; // Valor incorreto
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        path_input = 4'b0001; // Outro valor incorreto
        press_button();
        $display("Time=%0t, path_input=%b, step_counter=%d, error_count=%d, display_state=%b, display_7seg=%b, led_error=%b",
                 $time, path_input, step_counter, error_count, display_state, display_7seg, led_error);

        press_button();
        $display("2 Erros (paias) -> display_state = %b, display_7seg = %b", display_state, display_7seg);

        // Finalizando o teste
        $display("\nFim da simulação.");
        $finish;
    end

endmodule
