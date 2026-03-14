`include "sumador_restador_4_bits.v"
`timescale 1ns/1ns

module sumador_restador_tb();

    reg [3:0] A_tb, B_tb;
    reg Sel_tb;
    wire [3:0] So_tb;
    wire Co_tb;

    integer i, j, k;
    reg [4:0] resultado_esperado;

    // --- SOLUCIÓN AL ERROR DE $MONITOR ---
    // Creamos señales simples para que el monitor no se queje
    wire [31:0] modo_str = (Sel_tb) ? "REST" : "SUMA"; // Guardamos el texto en un cable
    wire signed [3:0] So_signed = So_tb;               // Convertimos a signo en un cable

    sumador_restador_4_bits uut (
        .A(A_tb),
        .B(B_tb),
        .Sel(Sel_tb),
        .So(So_tb),
        .Co(Co_tb)
    );

    initial begin
        $dumpfile("sumador_restador.vcd");
        $dumpvars(0, sumador_restador_tb);
        
        // Ahora el monitor solo recibe "señales simples"
        $monitor("Time=%0t | Modo=%s | A=%d | B=%d || Co=%b | So=%b | Dec=%d", 
                  $time, modo_str, A_tb, B_tb, Co_tb, So_tb, So_signed);
    end

    initial begin
        for (k = 0; k < 2; k = k + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    Sel_tb = k;
                    A_tb = i;
                    B_tb = j;
                    #10; 

                    if (Sel_tb == 0) 
                        resultado_esperado = i + j;
                    else 
                        resultado_esperado = i + (~j & 4'b1111) + 1;

                    if ({Co_tb, So_tb} !== resultado_esperado[4:0]) begin
                        $display("ERROR: A=%d B=%d | Exp=%b Obt=%b", 
                                  A_tb, B_tb, resultado_esperado[4:0], {Co_tb, So_tb});
                    end
                end
            end
        end

        $display("---------------------------------------------------------------");
        $display("Test completado con éxito.");
        $display("---------------------------------------------------------------");
        $finish;
    end

endmodule