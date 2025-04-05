# EsPascal
EsPascal es un lenguaje interpretado diseñado como proyecto final para la materia Sintaxis y Semántica de los Lenguajes de Programación. Esta basado en Pascal, simplificandolo y adaptandolo al español.
El interprete analiza léxica y sintácticamente el código fuente, y si no se detectan errores, lo ejecuta inmediatamente.

---

## Características del lenguaje

- Variables sin declaración previa.
- Operaciones aritméticas: `+`, `-`, `*`, `/`,`^`,`sqrt()`
- Estructuras cíclicas:
  - `para` (similar al `for`)
  - `mientras` (similar al `while`)
- Estructuras condicionales:
  - `si` (if)
  - `si - sino` (if - else)
  - `casos` (switch / case)
- Entrada de datos: `leer(variable)`
- Salida de datos: `mostrar(...)`
- Un programa se compone de una o mas funciones.
- Cada función tiene uno o más parametros.

---

## 🚀 Cómo usarlo

1. Ejecutar el intérprete:

   ```bash
   INTERPRETE_ESPASCAL.exe
2. **Ingresá o arrastrá la ruta del archivo `.txt` que contiene el código fuente en EsPascal en la consola.**

   > ⚠️ **Importante:** La ruta del archivo y su nombre **no deben contener espacios**, de lo contrario el programa fallará.

3. **El programa realiza los siguientes pasos:**
   - ✅ Análisis léxico
   - ✅ Análisis sintáctico
   - ✅ Ejecución del código (si pasa ambos análisis)

---

- `INTERPRETE_ESPASCAL.exe` – Ejecutable del intérprete.
- `Documentación/` – Archivos relacionados a la semántica (TAS, CFG, etc).
- `Ejemplos/` – Programas de ejemplo en EsPascal.
- `src/` – Código fuente del intérprete (en Pascal).

---

## Ejemplo de código en EsPascal

```EsPascal
funcion principal() {
    mostrar("Ingrese un número:");
    leer(numero);

    si (numero > 0) {
        mostrar("El número es positivo.");
    } sino {
        mostrar("El número es cero o negativo.");
    }

    para (i = 1; i <= numero; i = i + 1) {
        mostrar("Valor actual:", i);
    }
}