# Arquitectura de Computadores: Proyecto 2

Este proyecto utiliza un `Makefile` para automatizar la simulación y síntesis del diseño en Verilog.

### Archivos del Proyecto

* `computer.v`, `testbench.v`, etc.: Los archivos fuente en Verilog para el diseño y su banco de pruebas.
* `yosys.tcl`: El script para la síntesis lógica.
* `Makefile`: El script principal para ejecutar todos los comandos.

### Cómo Ejecutar

Utiliza los siguientes comandos en tu terminal:

| Comando | Descripción |
|---|---|
| `make build` | Compila los archivos en Verilog. |
| `make run` | Ejecuta la simulación. |
| `make wave` | Abre las formas de onda con GTKWave. |
| `make synth` | Ejecuta la síntesis lógica. |
| `make clean` | Elimina todos los archivos generados. |

### Formato de instrucción

Cada instrucción ocupa 16 bits en `im.dat`. Los 8 bits más significativos corresponden al opcode y
los 8 bits menos significativos al literal inmediato (cuando aplica). El set básico implementado es el
mostrado en la guía del curso:

| Opcode | Instrucción | Descripción |
|---|---|---|
| `0x00` | `MOV A,B` | Copia el valor del registro B en A. |
| `0x01` | `MOV B,A` | Copia el valor del registro A en B. |
| `0x02` | `MOV A, Lit` | Carga el literal en el registro A. |
| `0x03` | `MOV B, Lit` | Carga el literal en el registro B. |
| `0x04` | `ADD A,B` | Suma B a A. |
| `0x05` | `ADD B,A` | Suma A a B. |
| `0x06` | `ADD A, Lit` | Suma el literal al registro A. |
| `0x07` | `ADD B, Lit` | Suma el literal al registro B. |
| `0x08` | `SUB A,B` | Resta B de A. |
| `0x09` | `SUB B,A` | Resta A de B. |
| `0x0A` | `SUB A, Lit` | Resta el literal del registro A. |
| `0x0B` | `SUB B, Lit` | Resta el literal del registro B. |
| `0x0C` | `AND A,B` | AND lógico entre A y B, resultado en A. |
| `0x0D` | `AND B,A` | AND lógico entre B y A, resultado en B. |
| `0x0E` | `AND A, Lit` | AND lógico de A con el literal. |
| `0x0F` | `AND B, Lit` | AND lógico de B con el literal. |
| `0x10` | `OR A,B` | OR lógico entre A y B, resultado en A. |
| `0x11` | `OR B,A` | OR lógico entre B y A, resultado en B. |
| `0x12` | `OR A, Lit` | OR lógico de A con el literal. |
| `0x13` | `OR B, Lit` | OR lógico de B con el literal. |
| `0x14` | `NOT A` | Niega bit a bit el registro A. |
| `0x15` | `NOT B` | Niega bit a bit el registro B. |
| `0x16` | `XOR A,B` | XOR entre A y B, resultado en A. |
| `0x17` | `XOR B,A` | XOR entre B y A, resultado en B. |
| `0x18` | `XOR A, Lit` | XOR entre A y el literal. |
| `0x19` | `XOR B, Lit` | XOR entre B y el literal. |
| `0x1A` | `SHL A` | Desplaza A una posición a la izquierda. |
| `0x1B` | `SHL B` | Desplaza B una posición a la izquierda. |
| `0x1C` | `SHR A` | Desplaza A una posición a la derecha. |
| `0x1D` | `SHR B` | Desplaza B una posición a la derecha. |
| `0x1E` | `INC A` | Incrementa A en una unidad (literal debe ser `0x01`). |
| `0x1F` | `INC B` | Incrementa B en una unidad (literal debe ser `0x01`). |

Los registros de estado mantienen los flags `zero`, `negative`, `carry` y el último opcode ejecutado.

### Ejemplo en `im.dat`
El archivo incluido muestra un programa de ejemplo que ejercita todas las instrucciones básicas.
