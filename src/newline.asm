extern print_char
global newline

SECTION .text

newline:
    ; --- Prólogo de la función ---
    push ebp                ; Guardar el puntero de base
    mov ebp, esp            ; Establecer el nuevo puntero de base

    ; --- Preservar registros ---
    push eax                ; Guardamos eax para no perder su valor original

    ; TODO:
    ; imprimir '\n'
    ; --- 1. Preparar el carácter de salto de línea ---
    mov al, 10              ; Cargar el código ASCII 10 en el registro AL

    ; --- 2. Llamar a la función de impresión ---
    call print_char

    ; --- Restaurar registros y Epílogo ---
    pop eax                 ; Recuperar el valor original de eax

    mov esp, ebp            ; Restaurar el puntero de pila
    pop ebp                 ; Restaurar el puntero de base
    ret                     ; Retornar al procedimiento que llamó
