SECTION .text
global print_char

; ---------------------------------
; print_char
; Entrada:
;   AL = caracter a imprimir
; ---------------------------------

print_char:
    ; --- Prólogo de la función ---
    push ebp                    ; Guardar el puntero de base
    mov ebp, esp                ; Establecer el nuevo puntero de base

    ; TODO:
    ; 1. Guardar el caracter en memoria
    push ebx                    ; Preservamos ebx
    push eax                    ; Guardamos eax porque contiene el carácter en AL
    ; 2. Usar syscall write
    ; 3. Imprimir 1 byte
    ; write(fd=1, buffer, 1)
    mov eax, 4                  ; Syscall ID: sys_write (4)
    mov ebx, 1                  ; File Descriptor: stdout (1)
    mov ecx, esp                ; Dirección del buffer: el tope de la pila donde está AL
    mov edx, 1                  ; Longitud: imprimir exactamente 1 byte
    int 0x80                    ; Interrupción de software para invocar al kernel
    
    ; --- Restaurar registros y limpiar ---
    pop eax                     ; Recuperar el valor original de eax
    pop ebx                     ; Recuperar el valor original de ebx
    
    ; --- Epílogo de la función ---
    mov esp, ebp                ; Restaurar el puntero de pila
    pop ebp                     ; Restaurar el puntero de base
    ret                         ; Retornar al procedimiento que llamó
