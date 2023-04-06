# Chapter 6: Stacks, Procedures and Macros

## Getting started with Programs

### Program 1: Write a procedure to print the message "Hello world" five times

```asm
data segment
    mes db "hello, world", 0dh, 0ah, '$'
data ends

my_stack segment stack
    dw 10 dup(0)
stack_top label word
my_stack ends

code segment
    assume cs:code, ds:data, ss:my_stack
start:
    mov ax, data
    mov ds, ax
    mov ax, my_stack        ;initialize ss
    mov ss, ax
    mov sp, offset stack_top    ;initialize sp

    mov cx, 5
next:   call prt_msg    ;call the procedure
    loop next
    int 3

prt_msg proc near   ;defining the procedure
    mov ah, 9
    lea dx, mes
    int 21h
    ret
prt_msg endp

code ends
end start
```

### Program 2: Rewrite program 1 with the mainline program as the procedure

```asm
data segment
    mes db "Hello world", 0dh, 0ah, '$'
data ends

my_stack segment stack
    dw 10 dup(0)
stack_top label word
my_stack ends

code segment
    assume cs:code, ds:data, ss:my_stack

main    proc far
    mov ax, data
    mov ds, ax
    mov ax, my_stack
    mov ss, ax
    mov sp, offset mes

    mov cx, 5
next:   call prt_msg
    loop next

    int 3
main endp

prt_msg proc near
    mov ah, 9
    lea dx, mes
    int 21h
    ret
prt_msg endp

code ends
end main
```

## Write the program to convert BCD to Binary using all the parameter passing methods.

### Program 3.1: Using passing parameters in registers

```asm
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

;output:
;11
```

### Program 3.2: Using passing parameters in general memory

```asm
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

;output:
;11
```

### Program 3.3: Using passing parameters using pointers

```asm
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

    mov si, offset bcd_input
    mov di, offset bin_value

    call bcd_to_bin
    mov ax, 4c00h
    int 21h

bcd_to_bin proc near
    pushf
    push ax
    push bx
    push cx

    mov al, [si]
    mov bl, al
    and bl, 0Fh
    and al, 0F0h
    mov cl, 04h
    shr al, cl 
    mov bh, 0Ah
    mul bh 
    add al, bl 
    mov [di], al 

    popf
    pop ax
    pop bx
    pop cx
    ret
bcd_to_bin endp

code ends   
end start 

;output:
;11
```

### Program 3.4: Using passing parameters using the stack

```asm
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

;output:
;11
```

### Program 4: Develop a recursive procedure that calculates factorial of a number

```asm
data segment
    n db 04h
    fact dw ?
data ends 

stack_seg segment stack
    dw 40 dup(0)
top_stack label word
stack_seg ends

code segment
    assume cs:code, ds:data, ss:stack_seg
start:
    mov ax, data
    mov ds, ax
    mov ax, stack_seg
    mov ss, ax
    mov sp, offset top_stack

    mov ax, 1
    mov bl, n
    mov bh, 0
    call factorial

    mov fact, ax
    mov ax, 4c00h
    int 21h

factorial proc near
    cmp bx, 1
    je skip

    push bx
    dec bx

    call factorial

    pop bx
    mul bx

skip:   ret
factorial endp

code ends
end start

; below code is iterative method
; mov ax, 1
; mov cx, n
; next :  mul cx
;     loop next
```

### Program 5: Develop a far procedure to compute the 1's in a given 16-bit value in a module with the file name 'proc.asm'. Call it from the module written with the file name 'main.asm'. Assemble both the modules independently and link them together to generate an executable program as 'main.exe'

**main.asm**

```asm
data segment public
    num dw 0AAAAh
    count db ?
data ends

my_stack segment stack 
    dw 40 dup(0)
top_stack label word
my_stack ends

public num  ;declaring the num as public

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
```

**proc.asm**

```asm

data segment
    extern num:word ;num is acessing from main.asm
data ends

public bin_cnt  ;procedure bin_cnt declare as public

code_proc segment public

bin_cnt proc far
    assume cs:code_proc, ds:data

    pushf
    push bx
    push cx
    push dx

    mov bx, num
    mov cx, 16
    mov dx, 0

next:    shr bx, 1
    jnz skip 
    inc dx
skip:   loop next

    mov al, dl

    pop dx
    pop cx
    pop bx
    popf
    ret
bin_cnt endp

code_proc ends
end 
```

Follow the commands to compile it:

> - tasm main.asm
> - tasm proc.asm
> - tlink main.obj proc.obj
> - tasm main
> - tasm proc
> - debug main.exe

Will add the theory part and more programs...