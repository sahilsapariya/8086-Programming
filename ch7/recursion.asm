data segment
    n db 04h
    fact dw ?
data ends
stack_seg segment stack
    dw 40 dup(0)
top_stack label word
stack_seg ends

code segment
    assume cs:code, ds:data, ss:stack_seg
start:
    mov ax, data
    mov ds, ax
    mov ax, stack_seg
    mov ss, ax
    mov sp, offset top_stack

    mov ax, 1
    mov bl, n
    mov bh, 0
    call factorial

    mov fact, ax
    mov ax, 4c00h
    int 21h

factorial proc near
    cmp bx, 1
    je skip

    push bx
    dec bx

    call factorial

    pop bx
    mul bx

skip:   ret
factorial endp

code ends
end start





; mov ax, 1
; mov cx, n
; next :  mul cx
;     loop next