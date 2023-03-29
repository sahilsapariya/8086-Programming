;write a program to add 5 words.

data segment
    block dw 1234h, 5634h, 00D2h, 23A1h, AA45h
    ans dw ?
data ends
code segment
    assume cs: code , ds:data
start:  
    mov ax, data
    mov ds, ax

    mov cx, 5
    mov ax, 0
    lea bx, block

next:
    add ax, word ptr [bx]
    add bx, 2               ;move to next number
loop next

    mov word ptr [bx], ax   ;store the result

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;372ah