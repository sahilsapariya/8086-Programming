;wap to find the sum of first N numbers
;exp-4 exercise
data segment
    n dw 000Ah
    sum dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, 0   
    mov bx, 1
    mov cx, n

next:
    add ax, bx
    inc bx
    dec cx
    jnz next
    mov sum, ax
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;37h