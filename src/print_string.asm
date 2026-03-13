SECTION .text
global print_string

; ---------------------------------
; print_string
; Entrada:
;   EAX = direccion de cadena
;   cadena terminada en 0
; ---------------------------------

print_string:
    ; --- Prólogo de la función ---
    push ebp                        ; Guardar el puntero de base
    mov ebp, esp                    ; Establecer el nuevo puntero de base

    ; --- Preservar registros que serán utilizados ---
    push ebx                        ; ebx se usa para el File Descriptor en el syscall
    push esi                        ; esi se usa como puntero para recorrer la cadena

    ; TODO:
    ; 1. calcular longitud
    mov esi, eax                    ; esi apunta al inicio de la cadena (desde EAX)
    mov ecx, eax                    ; ecx guarda la dirección original para el syscall write
    xor edx, edx                    ; Inicializar edx en 0 (será nuestro contador de longitud)

calcular_len:
    ; Comparamos el byte actual con el terminador nulo (0)
    cmp byte [esi + edx], 0
    je string_imprimir              ; Si encontramos el 0, saltamos a imprimir
    inc edx                         ; Si no es 0, incrementamos el contador de bytes
    jmp calcular_len
    ; 2. syscall write
string_imprimir:
    ; Si la longitud es 0 (cadena vacía), saltamos al final para evitar errores
    cmp edx, 0
    je ps_fin

    ; Configuración para sys_write (int 0x80)
    ; eax = 4 (ID de sys_write)
    ; ebx = 1 (stdout)
    ; ecx = Dirección de la cadena (ya cargada previamente)
    ; edx = Cantidad de bytes a escribir (calculada en el paso anterior)
    mov eax, 4
    mov ebx, 1
    int 0x80

ps_fin:
    ; --- Restaurar registros y Epílogo ---
    pop esi
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret
