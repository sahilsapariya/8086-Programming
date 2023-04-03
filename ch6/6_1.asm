;write a procedure to print the message "Hello world" five times.

data segment
    mes db "hello, world", 0dh, 0ah, '$'
data ends
my_stack segment stack
    dw 10 dup(0)
stack_top label word
my_stack ends
code segment
    assume cs:code, ds:data, ss:my_stack
start:
    mov ax, data
    mov ds, ax
    mov ax, my_stack        ;initialize ss
    mov ss, ax
    mov sp, offset stack_top    ;initialize sp

    mov cx, 5
next:   call prt_msg
    loop next
    int 3

prt_msg proc near
    mov ah, 9
    lea dx, mes
    int 21h
    ret
prt_msg endp

code ends
end start