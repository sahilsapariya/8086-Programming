;wap to check whether all the elements in the givern array of 16-bits numbers are same or not.
;display appropriate message.

data segment
    block dw 1234h, 1234h, 1234h, 1234h, 1234h, 1234h
    mes1 db "All the elements are same $"
    mes2 db "All the elements are not same $"
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 5
    mov si, offset block
    mov ax, word ptr [si]
    dec cx
next:   
    add si, 2
    cmp ax, word ptr [si]
    loope next

    mov ah, 9
    jnz skip
    lea dx, mes1
    jmp print1
skip:   lea dx, mes2
print1:  int 21h

    mov ax, 4c00h
    int 21h
code ends
end start