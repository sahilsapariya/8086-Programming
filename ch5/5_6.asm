;wap to copy a string defined in data segment.


data segment
   mes1 db "Hello, Sahil!$"
   mes2 db 13 dup (0), '$'
data ends
code segment
    assume cs:code, ds:data, es:data
start:  mov ax, data    ;initialize data segment
    mov ds, ax
    mov es, ax          ;initialize extra segment

    mov si, offset mes1
    mov di, offset mes2
    cld                 ;clear direction flag i.e. DF = 0
    mov cx, 13

rep movsb   ;repeat move instruction

    mov ah, 9
    lea dx, mes2
    int 21h

    mov ax, 4c00h
    int 21h
code ends
end start
