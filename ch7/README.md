# Chapter 7: The 8086 Interrupts and I/O

An _interrupt_ is an event caused by sending a signal from an external device or due to an exceptional condition resulting from the execution of some specific instructions or due to execution of a software instruction.

3 types of interrupts:

- Hardware interrupts
- Exceptions
- Software interrupts

## Getting started with Programs

### Program 1: Write an ISR to print a message "Interrupt is processed" when an interrupt type 5 occurs.

```asm
data segment
    mes db "My name is sahil$"
data ends

print macro mes     ;here we are defining the macro
    mov ah, 09h
    lea dx, mes
    int 21h
endm

my_stack segment stack
    dw 50 dup(0)
top_stack label word
my_stack ends

code segment 
    assume cs:code, ds:data, ss:my_stack
start:
    mov ax, data
    mov ds, ax
    mov ax, my_stack
    mov ss, ax
    mov sp, offset top_stack

    mov ax, 0000h   ;initialize es
    mov es, ax

    ;store the IP and CS of prt_mes
    ;into vector table
    mov es: 0014h, offset prt_mes
    mov es: 0016h, seg prt_mes 

    int 5h

    mov ax, 4c00h
    int 21h

prt_mes proc near   ;defining the near procedure
    push ax
    push dx

    print mes   ;calling the macro with parameter

    pop dx
    pop ax
    ret 
prt_mes endp

code ends
end start

```