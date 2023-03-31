;wap to check the number is _even or _odd.

data segment
    n1 dw 4387h
    _odd db "number is _odd $"
    _even db "number is _even $"
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    and ax, 0001h
    cmp ax, 0001h

    mov ah, 9
    jz skip
    lea dx, _even
    jmp over
skip:   lea dx, _odd
over:   int 21h

    mov ax, 4c00h
    int 21h
code ends
end start
