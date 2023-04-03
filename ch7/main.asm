data segment public
    num dw 0AAAAh
    count db ?
data ends

my_stack segment stack 
    dw 40 dup(0)
top_stack label word
my_stack ends

public num

code_proc segment public
    extern bin_cnt far
code_proc ends

code segment public 
    assume cs:code, ds:data, ss:my_stack
start:
    mov ax, data
    mov ds, ax
    mov ax, my_stack
    mov ss, ax
    mov sp, offset top_stack

    call bin_cnt

    mov count, al 

    mov ax, 4c00h
    int 21h

code ends
end start