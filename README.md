[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Px-uYaj2)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=23083392&assignment_repo_type=AssignmentRepo)
# Lab02 - Sumador/Restador de 4 bits

# Integrantes
1). Cristian Camilo Cifuentes Rodriguez. 130005
2). Pula Natalia Roa García. 137653

# Informe

Indice:

1. [Documentación](#documentación-de-los-circuitos-implementados-implementado)
2. [Simulaciones](#simulaciones)
3. [Evidencias de implementación](#evidencias-de-implementación)
4. [Preguntas](#preguntas)
5. [Conclusiones](#conclusiones)
6. [Referencias](#referencias)

## Documentación del diseño implementado

### 1. Sumador/Restador

#### 1.1 Descripción
## Resumen
Este documento presenta el diseño, implementación y validación de un circuito sumador/restador de 4 bits. El diseño se destaca por la optimización de hardware, ya que reutiliza la arquitectura de un sumador completo añadiendo compuertas lógicas XOR y una señal de control. Mediante la aplicación del teorema de complemento a 2, el circuito es capaz de transformar las operaciones de resta en sumas, permitiendo manejar números positivos y negativos en binario. El informe detalla la fundamentación teórica, describe la estructura del circuito a nivel de hardware y documenta las simulaciones realizadas para verificar su correcto funcionamiento antes de su implementación física.

## Introducción
En el diseño de sistemas digitales, realizar operaciones aritméticas con números negativos requiere de una representación eficiente que no implique duplicar el hardware para cada operación. Este laboratorio tiene como objetivo principal implementar un circuito restador utilizando la lógica de complemento a 2, lo cual nos permite reutilizar un sumador de 4 bits existente para realizar también operaciones de resta. 

El uso del complemento a 2 simplifica el diseño del circuito al convertir la resta $A - B$ en una suma equivalente $A + (\sim B + 1)$, donde $\sim B$ es la inversión bit a bit. A través de este laboratorio, aprenderemos a adaptar arquitecturas base mediante señales de control y a verificar y validar rigurosamente el diseño en un entorno de simulación, un paso crucial para identificar y corregir errores de lógica antes de proceder con el despliegue en hardware real.
#### 1.2 Diagramas


## Simulaciones 

### 1. Simulación del sumador/restador

#### 1.1 Descripción
El circuito sumador/restador de 4 bits basa su funcionamiento en la capacidad de ejecutar tanto la suma como la resta matemática utilizando el mismo bloque sumador principal. Esto se logra interpretando la resta mediante la aritmética de complemento a 2.

**Fundamento Matemático (Complemento a 2)**
Para restar un número $B$ de un número $A$, aplicamos la siguiente transformación:
$$A - B = A + (\sim B + 1)$$
Para hallar el complemento a 2 de un número, se siguen dos pasos:
1. **Inversión de bits (Complemento a 1):** Se invierten todos los bits del sustraendo. Por ejemplo, si $B = 0101_2$ (5 en decimal), su inversión será $1010_2$.
2. **Sumar 1:** Se le suma un 1 al resultado anterior. Siguiendo el ejemplo: $1010_2 + 1 = 1011_2$. Este resultado final ($1011_2$) representa el número $-5$ en complemento a 2.

Al sumar este valor con el minuendo, digamos $A = 0111_2$ (7 en decimal), obtenemos:
$$0111_2 + 1011_2 = 10010_2$$
Descartando el bit más significativo (acarreo o MSB), el resultado es $0010_2$, que equivale a 2 en decimal, confirmando que $7 - 5 = 2$.

**Implementación a nivel de Hardware**
Para llevar esta lógica al circuito, se utiliza una señal de control denominada $Sel$ y compuertas lógicas XOR acopladas a las entradas del operando $B$.

* **Modo Suma ($Sel = 0$):** Las compuertas XOR dejan pasar los bits del operando $B$ sin modificaciones. Como el acarreo inicial del primer sumador ($Cin$) está conectado a la señal $Sel$, este recibe un 0. El circuito realiza la operación estándar $A + B$.
* **Modo Resta ($Sel = 1$):** La señal en alto hace que las compuertas XOR actúen como inversores lógicos, obteniendo el complemento a 1 del operando $B$ (Paso 1). Simultáneamente, la señal $Sel = 1$ ingresa como acarreo inicial ($Cin$) en el primer bloque sumador, sumando un 1 al número invertido (Paso 2). De esta forma, se consolida el complemento a 2 y el bloque sumador principal ejecuta la operación $A + (\sim B + 1)$, es decir, $A - B$.

Adicionalmente, el bit de acarreo de salida final ($Co$) sirve como indicador del signo del resultado en operaciones de resta: si $Co = 1$, el resultado es positivo; si $Co = 0$, el resultado es negativo y se encuentra expresado en complemento a 2.
#### 1.2 Diagrama


## Evidencias de implementación


## Conclusiones
**Optimización de hardware:** La implementación del circuito sumador/restador de 4 bits demostró de manera exitosa la viabilidad y eficiencia de reutilizar componentes lógicos en el diseño de arquitecturas digitales. Mediante la integración de compuertas XOR y una única señal de control ($Sel$), se logró expandir la funcionalidad de un bloque sumador estándar para incluir operaciones de resta, evitando la necesidad de construir un circuito aritmético independiente y optimizando los recursos del sistema.
* **Validación práctica del complemento a 2:** El desarrollo de este laboratorio permitió comprobar a nivel de hardware el fundamento matemático del complemento a 2. El diseño logró ejecutar de forma precisa operaciones de resta al transformarlas en sumas equivalentes mediante la lógica $A - B = A + (\sim B + 1)$. Se validó que el uso de la señal $Sel$ para invertir el sustraendo y simultáneamente inyectar un 1 en el acarreo inicial ($Cin$) es un enfoque robusto y funcional.
* **Interpretación de resultados y signo:** Se verificó de forma concluyente que el acarreo de salida ($Co$) del último bloque sumador actúa eficazmente como indicador de estado para la operación. El diseño respondió adecuadamente a la teoría, confirmando que cuando $Co = 1$ en una resta, el resultado es positivo; mientras que si $Co = 0$, el circuito entrega correctamente un resultado negativo codificado en formato de complemento a 2.

## Referencias
