// Asegúrate de que "sumador_un_bit.v" esté en la misma carpeta
`include "sumador_un_bit.v"

module sumador_restador_4_bits (
    input [3:0] A,   // Entrada A (4 bits)
    input [3:0] B,   // Entrada B (4 bits)
    input Sel,       // Señal de control: 0 para Suma, 1 para Resta (Complemento a 2)
    output [3:0] So, // Salida Suma/Resta (4 bits)
    output Co        // Acarreo de Salida Final (Indica signo si es resta)
);

    wire [4:0] c;
    wire [3:0] B_xor; // Cable interno para conectar la salida de las XOR al sumador

    // Asignamos la señal de control (Sel) al acarreo de entrada inicial. 
    // Si Sel=1 (resta), suma el "1" necesario para el complemento a 2.
    assign c[0] = Sel;

    // --- GENERATE FOR: Instanciación automática ---
    genvar i; // Variable especial para generación de hardware
    generate
        for (i = 0; i < 4; i = i + 1) begin : etapa
            
            // Compuerta XOR: Invierte el bit de B si Sel es 1 (Paso 1 del complemento a 2)
            assign B_xor[i] = B[i] ^ Sel;

            // Instanciamos el sumador de 1 bit 4 veces
            sumador_un_bit inst (
                .A(A[i]),      // Bit i de A
                .B(B_xor[i]),  // Bit i de B modificado por la compuerta XOR
                .Ci(c[i]),     // Acarreo actual (entra)
                .So(So[i]),    // Suma resultante (sale)
                .Co(c[i+1])    // Acarreo siguiente (sale hacia la próxima etapa)
            );
        end
    endgenerate

    // Asignamos el último cable (c[4]) a la salida final Co
    assign Co = c[4];

endmodule