;wap to reverse the givern array of 16-bit numbers.

data segment
    block dw 0006h, 0001h, 0002h, 0003h, 0004h, 0005h, 0006h
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    lea si, block
    mov cx, word ptr [si]
    add si, 2

    mov dx, cx  ;multiply CX by 2
    mov al, dl
    mov bl, 2
    mul bl
    mov dx, ax
    sub dx, 2

    mov di, si  ;di pointing to the end
    add di, dx  

    mov ax, cx
    mov bl, 2
    div bl
    mov cx, 0
    mov cl, al

next:   mov ax, word ptr [si]
    mov bx, word ptr [di]
    mov word ptr [si], bx
    mov word ptr [di], ax
    add si, 2
    sub di, 2
    dec cx
    jnz next

    mov ax, 4c00h
    int 21h
code ends
end start
