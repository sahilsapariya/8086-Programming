;wap to find minimum of two 16-bit numbers

data segment
    n1 dw 1234h
    n2 dw 4321h
    min dw ?
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    cmp ax, n2
    jc skip     ;ax < n2
    mov ax, n2  ;ax > n2
skip:   mov min, ax
    mov ax, 4c00h
    int 21h
code ends
end start