;wap to find whether two numbers are equal or not.
;print the appropriate message.

data segment
    mes1 db "Both the numbers are same $"
    mes2 db "Both the numbers are different $"
    n1 dw 1234h
    n2 dw 1234h
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    cmp ax, n2

    mov ah, 9
    jnz noteq
    lea dx, mes1
    jmp over
noteq:  lea dx, mes2
over:   int 21h
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;Both the numbers are same