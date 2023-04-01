;wap to separate the nibbles of a 16-bit number.
data segment
   num dw 54A2h
   nibbles db 4 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, num
    mov cl, 0
    mov bx, 4
    lea si, nibbles         ;point to nibbles
next:   shr ax, cl          ;shift 4 times right
    mov dx, ax              ;AND with 000Fh
    and dx, 000Fh           ;to separate nibble
    mov byte ptr [si], dl   ;store the nibble
    inc si 
    mov cl, 4               ;make cl = 4
    dec bx
    jnz next                ;goto next, if not zero



    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;02 0A 04 05