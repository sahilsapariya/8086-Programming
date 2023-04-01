;wap to find the factorial of given 8-bit number.

data segment
    n db 05h
    ans dw ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 0
    mov cl, n
    mov ax, 1
    mov bx, 1

next:    mul bx
    inc bx
    cmp bx, cx
    jbe next

    mov ans, ax
    mov ax, 4c00h
    int 21h
code ends
end start