;wap to generate first 10 fibonacci numbers in decimal form
;starting from 0 and 1
data segment
   fib db 10 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 10
    mov si, offset fib
    mov al, 0
    daa
    mov byte ptr [si], al
    inc si
    mov al, 1
    daa
    mov byte ptr [si], al
    inc si
    sub cx, 2
    mov al, 0
    mov bl, 1
next:   add al, bl
    daa
    mov dl, al
    mov byte ptr [si], al 
    inc si 
    mov al, bl 
    mov bl, dl 
    loop next


    mov ax, 4c00h
    int 21h
code ends
end start