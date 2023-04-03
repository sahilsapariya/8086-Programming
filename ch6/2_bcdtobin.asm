;wap to convert bcd number to binary
;using passing parameters in general memory

data segment
    bcd_input db 17h
    bin_value db ?
data ends
stack_seg segment stack
    dw 40 dup(0)
top_stack label word
stack_seg ends
code segment
    assume cs:code, ds:data, ss:stack_seg
start:  mov ax, data
    mov ds, ax
    mov ax, stack_seg
    mov ss, ax
    mov sp, offset top_stack

    call bcd_to_bin
    mov ax, 4c00h
    int 21h

bcd_to_bin proc near
    pushf 
    push ax
    push bx
    push cx

    mov bl, al 
    and bl, 0Fh
    and al, 0F0h
    mov cl, 04h
    shr al, cl
    mov bh, 0Ah
    mul bh
    add al, bl 

    mov bin_value, al
    pop cx
    pop bx
    pop ax
    popf
    ret
bcd_to_bin endp

code ends   
end start 