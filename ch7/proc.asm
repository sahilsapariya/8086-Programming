
data segment
    extern num:word 
data ends

public bin_cnt  ;procedure bin_cnt declare as public

code_proc segment public

bin_cnt proc far
    assume cs:code_proc, ds:data

    pushf
    push bx
    push cx
    push dx

    mov bx, num
    mov cx, 16
    mov dx, 0

next:    shr bx, 1
    jnz skip 
    inc dx
skip:   loop next

    mov al, dl

    pop dx
    pop cx
    pop bx
    popf
    ret
bin_cnt endp

code_proc ends
end 