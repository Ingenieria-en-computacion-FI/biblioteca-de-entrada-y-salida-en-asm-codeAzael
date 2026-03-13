SECTION .bss
char_buffer resb 1              ; Espacio para almacenar el byte leído

SECTION .text
global scan_char

; ---------------------------------
; scan_char
; Salida:
;   AL = caracter leído
; ---------------------------------

scan_char:
    push ebp                    ; Guardar el puntero base
    mov ebp, esp                ; Establecer el nuevo puntero de base
    push ebx                    ; Preservar EBX (estándar de llamadas)

    ; TODO:
    ; 1. usar syscall read
    ; 2. leer 1 byte desde stdin
    ; Preparar syscall read (sys_read)
sc_leer:
    mov eax, 3                  ; Número de syscall para lectura
    mov ebx, 0                  ; File descriptor 0 = teclado (stdin)
    mov ecx, char_buffer        ; Dirección donde se guardará el byte
    mov edx, 1                  ; Leer exactamente 1 byte
    int 0x80                    ; Llamada al kernel de Linux

    ; 3. devolverlo en AL
    mov al, [char_buffer]       ; AL es el estándar para devolver bytes

    pop ebx                     ; Restaurar registros
    mov esp, ebp
    pop ebp
    ret                         ; Regresar al programa principal
