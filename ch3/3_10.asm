;wap to divide 32-bit unsigned number by 16-bit unsigned number.

data segment
    dividend dd 11204534h
    divisor dw 1250h
    rem dw ?
    quetient dw ?
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    lea bx, dividend
    mov ax, word ptr [bx]
    mov dx, word ptr [bx + 2]
    div divisor
    mov rem, dx
    mov quetient, ax

    mov ax, 4c00h
    int 21h
code ends
end code