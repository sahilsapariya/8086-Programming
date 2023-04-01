;wap to count the number of similar bits in the two 16-bit numbers.

data segment
    n1 dw 1234h
    n2 dw 4321h
    count db ?
data ends

code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, n1
    mov bx, n2
    xor ax, bx

    mov count , 0
    mov cx, 16
next:   shl ax, 1
    jc skip
    inc count
skip:   loop next

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;000Ah