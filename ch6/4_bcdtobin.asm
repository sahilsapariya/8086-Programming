;wap to convert bcd number to binary number
;using passing parameters using the stack

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

    mov al, bcd_input
    push ax

    call bcd_to_bin

    pop ax
    mov bin_value, al

    mov ax, 4c00h
    int 21h

bcd_to_bin proc near
    pushf
    push ax
    push bx
    push cx
    push bp

    mov bp, sp
    mov ax, [bp + 12]

    mov bl, al 
    and bl, 0Fh
    and al, 0F0h
    mov cl, 04h
    shr al, cl 
    mov bh, 0Ah
    mul bh 
    add al, bl 

    mov [bp + 12], ax
    pop bp  
    pop cx  
    pop bx  
    pop ax
    popf
    ret
bcd_to_bin endp


code ends   
end start 