;wap to display the date of BIOS of your system.

extra segment
    str1 db 8 dup(0), '$'
extra ends
code segment
    assume cs:code, es:extra
start:  mov ax, extra
    mov es, ax

    mov di, offset str1
    mov ax, 0FFFFh
    mov ds, ax
    mov si, 0005h
    cld
    mov cx, 8

