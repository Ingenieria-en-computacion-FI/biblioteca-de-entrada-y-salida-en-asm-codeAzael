SECTION .text
global scan_string

; ---------------------------------
; scan_string
; Entrada:
;   EAX = buffer destino
;   EBX = tamaño máximo
; ---------------------------------

scan_string:
    ; --- Prólogo de la función ---
    push ebp                    ; Guardar el puntero de base
    mov ebp, esp                ; Establecer el nuevo puntero de base

    ; --- Preservar registros que serán utilizados ---
    push ebx                    ; ebx se usa para el File Descriptor (stdin)
    push edi                    ; edi guardará la dirección base del buffer
    push esi                    ; esi se usará para calcular la posición del fin de cadena

    ; --- 1. Preparar y ejecutar la llamada al sistema (sys_read) ---
    mov edi, eax                ; Guardamos la dirección del buffer en edi para uso posterior
    mov ecx, eax                ; ecx = Dirección del buffer para el syscall
    mov edx, ebx                ; edx = Tamaño máximo a leer

    ; TODO:
    ; 1. syscall read
    mov eax, 3                  ; Syscall ID: sys_read (3)
    mov ebx, 0                  ; File Descriptor: stdin (0)
    int 0x80                    ; Invocar al kernel de Linux
    ; 2. guardar en buffer
    ; Al volver, eax contiene el número de bytes realmente leídos
    cmp eax, 0
    jle ss_fin                  ; Si no se leyó nada o hubo error, saltamos al final

    ; 3. agregar terminador 0
    ; --- 2. Procesar el terminador de cadena ---
    ; Se tiene que encontrar el último carácter (que suele ser \n) 
    ; y asegurar que la cadena termine en 0.

    mov esi, edi                ; Apuntar al inicio del buffer
    add esi, eax                ; Desplazarse hasta el final de los bytes leídos
    dec esi                     ; Retroceder una posición al último byte leído

    ; Comprobamos si el último byte es un Salto de Línea (ASCII 10)
    cmp byte [esi], 10          ; ¿Es un salto de linea?
    je ss_nulo                  ; Si es así, lo reemplazaremos con un 0
    inc esi                     ; Si no es un '\n', el 0 debe ir una posición después

ss_nulo:
    mov byte [esi], 0           ; Insertar el terminador nulo

ss_fin:
    ; --- Restaurar registros y Epílogo ---
    pop esi                     ; Recuperar valor original de esi
    pop edi                     ; Recuperar valor original de edi
    pop ebx                     ; Recuperar valor original de ebx

    mov esp, ebp                ; Limpiar el puntero de base
    pop ebp                     ; Restaurar puntero de base anterior
    ret
