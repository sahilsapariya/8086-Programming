;wap to count the number of 1 bits in the binary representation of a given 16-bit operand.

data segment
    num dw 32AFh
    count db ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, num
    mov count, 0
    mov cx, 16
    
next:   shl ax, 1
    jnc skip
    inc count
skip:   loop next
    
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;0009h