;wap to convert bcd number to binary 
;using passing parameters in registers.

data segment
    bcd_input db 17h
    bin_value db ?
data ends
stack_seg segment stack
    dw 40 dup(0)
stack_top label word
stack_seg ends
code segment
    assume cs:code, ds:data, ss:stack_seg
start:  mov ax, data
    mov ds, ax
    mov ax, stack_seg
    mov ss, ax
    mov sp, offset stack_top

    mov al, bcd_input
    call bcd_to_bin
    mov bin_value, al
    mov ax, 4c00h
    int 21h

bcd_to_bin proc near
    pushf
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

    pop cx
    pop bx
    popf
    ret
bcd_to_bin endp

code ends
end start