;wap to sort the given block of 8-bit numbers.

data segment
    block db 05h, 23h, 0A2h, 66h, 12h, 7Dh
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    lea si, block
    mov cx, 0               ;get size
    mov cl, byte ptr [si]   ;into cl
    dec cx                  ;set no. of passes
outer:  mov dx, cx
    inc si
    mov di, si
inner:  inc di
    mov al, byte ptr [si]
    cmp al, byte ptr [di]
    jbe skip
    mov bl, al
    mov al, byte ptr [di]
    mov byte ptr [di], bl
    mov byte ptr [si], al
skip:   dec dx
    jnz inner
    dec cx
    jnz outer
    mov ax, 4c00h
    int 21h
code ends
end start