data segment
    mes db "My name is sahil$"
data ends
print macro mes
    mov ah, 09h
    lea dx, mes
    int 21h
endm
my_stack segment stack
    dw 50 dup(0)
top_stack label word
my_stack ends

code segment 
    assume cs:code, ds:data, ss:my_stack
start:
    mov ax, data
    mov ds, ax
    mov ax, my_stack
    mov ss, ax
    mov sp, offset top_stack

    mov ax, 0000h   ;initialize es
    mov es, ax

    mov es: 0014h, offset prt_mes
    mov es: 0016h, seg prt_mes 

    int 5h

    mov ax, 4c00h
    int 21h

prt_mes proc near
    push ax
    push dx

    print mes 

    pop dx
    pop ax
    ret 
prt_mes endp

code ends
end start
