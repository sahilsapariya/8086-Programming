;wap to convert given hex number to decimal number.

data segment
   num db 5Fh
   ans db ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax




    mov ax, 4c00h
    int 21h
code ends
end start
