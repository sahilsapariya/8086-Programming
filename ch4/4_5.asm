;wap to find the sum of N 16-bits numbers.

data segment
    block dw 0005h, 1234h,4321h, 1215h, 456Dh, 1593h
        dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov si, offset block
    mov cx, word ptr [si]
    add si, 2
    mov ax, word ptr [si]

next:    add si, 2
    dec cx
    jz over
    add ax, word ptr [si]
    jmp next
over:
    mov word ptr [si], ax
    mov ax, 4c00h
    int 21h
code ends
end start