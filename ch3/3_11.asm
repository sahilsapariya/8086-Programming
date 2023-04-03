;wap to perform ORing of two 16-bits number without using OR instruction.
;exp-4 exercise
data segment
    n1 dw 1234h
    n2 dw 4321h
    ans dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    not ax
    mov bx, n2
    not bx

    and ax, bx
    not axd
    mov ans, ax

    mov ax, 4c00h
    int 21h
code ends
end start
