;wap to exchange the nibbles of given number.

data segment
   num db 5Fh
   ans db ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov al, num 
    mov cl, 4
    rol al ,cl
    mov ans, al 

    mov ax, 4c00h
    int 21h
code ends
end start
