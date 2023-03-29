; write a program to exchange the content of two words stored in memory.

data segment
    n1 dw 1234h
    n2 dw 4321h
data ends

code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    xchg ax, n2
    mov n1, ax

    mov ax, 4c00h
    mov 21h
code ends
end start

