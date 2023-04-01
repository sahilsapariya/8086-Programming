;wap to find the first 10 numbers of fibonacci series.

data segment
    series db 10 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 10
    mov si, offset series
    mov al, 0       ;first number 
    mov byte ptr [si], al
    inc si
    mov al, 1
    mov byte ptr [si], al
    inc si
    mov al, 0
    mov bl, 1
    sub cx, 2

next:   add al, bl
    mov dl, al
    mov byte ptr [si], al
    inc si 
    dec cx
    mov al, bl
    mov bl, dl 
    loop next

    mov ax, 4c00h
    int 21h
code ends
end start