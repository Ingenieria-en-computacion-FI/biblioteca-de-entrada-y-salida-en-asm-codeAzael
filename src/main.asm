%include "../include/io.inc"

global _start

SECTION .data
    msg_int    db "Ingrese un numero: ", 0
    msg_char   db "Ingrese un caracter: ", 0
    msg_str    db "Ingrese una cadena: ", 0
    msg_result db 10, "Resultados:", 10, 0


SECTION .bss
    var_int    resd 1    ; guardar el número (4 bytes)
    var_char   resb 1    ; guardar el carácter (1 byte)
    var_str    resb 64   ; guardar la cadena (64 bytes)

SECTION .text
_start:
    ; -------------------------
    ; pedir entero
    ; -------------------------

    mov eax, msg_int
    call print_string
    call scan_int
    mov [var_int], eax   ; guardamos lo que regresó EAX

    ; -------------------------
    ; pedir caracter
    ; -------------------------

    mov eax, msg_char
    call print_string
    call scan_char
    mov [var_char], al   ; guardamos el byte en la variable
    
    call scan_char 

    ; -------------------------
    ; pedir cadena
    ; -------------------------

    mov eax, msg_str
    call print_string
    mov eax, var_str     ; Le pasamos la dirección de nuestra variable
    mov ebx, 64
    call scan_string

    ; -----------------------------------------
    ; MOSTRAR TODO AL FINAL
    ; -----------------------------------------

    mov eax, msg_result
    call print_string

    ; -------------------------
    ; imprimir entero
    ; -------------------------

    mov eax, [var_int]
    call print_int
    call newline

    ; -------------------------
    ; imprimir caracter
    ; -------------------------

    mov al, [var_char]
    call print_char
    call newline

    ; -------------------------
    ; imprimir cadena
    ; -------------------------

    mov eax, var_str
    call print_string
    call newline

    ; -------------------------
    ; salir
    ; -------------------------

    mov eax, 1
    xor ebx, ebx
    int 0x80


    ; -------------------------
    ; salir
    ; -------------------------

    mov eax,1
    xor ebx,ebx
    int 0x80
