;wap to find the minimum from a N 16-bits numbers.

data segment
    block dw 0005h, 1234h, 4567h, 0001h, 7896h, 3610h
    ans dw ?
data ends
code segment
    assume cs: code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov si, offset block
    mov cx, word ptr [si]
    add si, 2
    mov ax, word ptr [si]

next:   
    add si, 2
    dec cx
    jz over
    cmp ax, word ptr [si]
    jc skip
    mov ax, word ptr [si]
skip:   jmp next
over:
    mov ans, ax

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;0001h