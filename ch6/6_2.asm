;rewrite program 6_1 with the mainline program as the procedure.

data segment
    mes db "Hello world", 0dh, 0ah, '$'
data ends
my_stack segment stack
    dw 10 dup(0)
stack_top label word
my_stack ends
code segment
    assume cs:code, ds:data, ss:my_stack

main    proc far
    mov ax, data
    mov ds, ax
    mov ax, my_stack
    mov ss, ax
    mov sp, offset mes

    mov cx, 5
next:   call prt_msg
    loop next

    int 3
main endp

prt_msg proc near
    mov ah, 9
    lea dx, mes
    int 21h
    ret
prt_msg endp

code ends
end main