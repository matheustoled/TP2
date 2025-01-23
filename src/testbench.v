`timescale 1ns / 1ps

module top_module_tb;
    // Entradas
    reg clk;
    reg reset;
    reg insere;
    reg [3:0] entrada;

    // Saídas
    wire [6:0] display1;
    wire led;

    // Instância do módulo principal
    top_module uut (
        .clk(clk),
        .reset(reset),
        .insere(insere),
        .entrada(entrada),
        .display1(display1),
        .led(led)
    );

    // Gera o clock
    always #5 clk = ~clk;

    //comandos para gerar o arquivo VCD
    initial begin
        $dumpfile("arquivos/simulacao_ondas.vcd");
        $dumpvars(0, top_module_tb); //grava todas as variáveis do módulo testbench.v
    end

    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        insere = 0;
        entrada = 4'b0000;

        // Espera inicial para reset
        #10 reset = 0;

        // Teste 1: Caminho correto (5 - 9 - 0 - 0 - 6 - 0)
        entrada = 4'b0101; #10; $display("Display = %b (esperado: 5)", display1);
        entrada = 4'b1001; #10; $display("Display = %b (esperado: 9)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);
        entrada = 4'b0110; #10; $display("Display = %b (esperado: 6)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);

        // Verifica se o display mostra "S" (sucesso total)
        $display("Teste 1: Display final = %b (esperado: S)", display1);

        // Teste 2: Caminho parcialmente correto (erro em uma posição e correção)
        reset = 1; #10; reset = 0;
        entrada = 4'b0101; #10; $display("Display = %b (esperado: 5)", display1);
        entrada = 4'b1000; #10; $display("Display = %b (esperado: erro)", display1);
        entrada = 4'b1001; #10; $display("Display = %b (esperado: 9)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);
        entrada = 4'b0110; #10; $display("Display = %b (esperado: 6)", display1);
        entrada = 4'b0000; #10; $display("Display = %b (esperado: 0)", display1);

        // Verifica se o display mostra "P" (sucesso parcial)
        $display("Teste 2: Display final = %b (esperado: P)", display1);

        // Teste 3: Caminho com 2 erros
        reset = 1; #10; reset = 0;
        entrada = 4'b0101; #10; $display("Display = %b (esperado: 5)", display1);
        entrada = 4'b1000; #10; $display("Display = %b (esperado: erro)", display1);
        entrada = 4'b1000; #10; $display("Display = %b (esperado: erro)", display1);

        // Verifica se o display mostra "F" (falha)
        $display("Teste 3: Display final = %b (esperado: F)", display1);

        // Finaliza a simulação
        $stop;
    end
endmodule
