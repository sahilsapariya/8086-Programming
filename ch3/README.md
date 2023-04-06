# Chapter 3: Programming with Data transfer, Arithmetic & Logical Instructions

In this chapter we are going to see the assember directives, instructions and programms related to the instructions. We will discuss the instructions and programs related to 8086 microprocessor.

## Basic Assembler Directive

- The 8086 <u>instructions</u> are the statements which are converted to machine codes whereas the <u>assembler directives</u> are the statements that help the assembler to convert the assembly language program to machine language program correctly and efficiently.

- Ex. SEGMENT, ENDS, ASSUME, END, DB, DW, WORD, PTR, BYTE, SEG, OFFSET these are the basic assebler directives.

## Getting started with 8086 programming

### Program 1: To add 16-bit numbers 1234h and 4321h

add.asm
```asm
code segment
    assume cs: code
start:
    mov ax, 1234h
    mov bx, 4321h

    add ax, bx

    int 3h

code ends
end start
```

<b>Output:</b>
We will compile the program using dosbox tasm. So follow the commands to compile and run it.

- tasm add.asm
- tlink add.obj
- tasm add
- debug add.exe

```
- g
 program terminated normally
- d 076a:0000
076a:0000 55 55 ...
```

### Program 2: To add two 16-bit numbers using data segment

Here we are going to define data segment and then initialize it into code segment and then perform the addition operation

```asm
data segment
    n1 dw 1234h
    n2 dw 4321h
    ans dw ?
data ends

code segment
    assume cs: code, ds: data

start:
    mov ax, data    ;initialize the data segment
    mov ds, ax

    mov ax, n1
    add ax, n2

    mov ans, ax

    mov ax, 4c00h   ;terminate the program
    int 21h

code ends
end start
```

<b>Output:</b>
To see the output of the program compile the program like above and see the output in dosbox.

### Program 3: To convert a given alphabt from lowercase to uppercase

Some instructions
- Read character:  mov AH, 1
- Print character: mov AH, 2

```asm
code segment
    assume cs: code
start:
    mov ah, 1   ; read a character
    int 21h

    sub al, 20h
    mov ah, 2   ; print a character
    mov dl, al
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start  
```

### Program 4: To display message "Hello world"

```asm
data segment
    mes db "Hello world$"
data ends

code segment
    assume cs: code, ds: data
start:
    mov ax, data        ;initialize the data segment
    mov ds, ax

    mov ah, 9           ;function number to display string
    mov bx, seg mes     ;get segment address
    mov ds, bx          
    mov dx, offset mes  ;get offset address
    int 21h

    mov ax, 4c00h       ;terminate the program
    int 21h
code ends
end start

```

### Program 5: To read string and display it

Some instructions
- Read string:  mov AH, 10
- Print string: mov AH, 9

```asm
data segment
    mes1 db "Enter a string : $"
    str_buf db 255, 256 dup(0)
    n1 db 0dh, 0ah, '$'
    mes2 db "String entered is : $"
data ends

code segment
    assume cs: code, ds:data
start:
    mov ax, data        ;data segment initialize
    mov ds, ax

    mov ah, 9           ;display mes1
    mov dx, offset mes1
    int 21h

    mov ah, 10          ;read a string
    mov dx, offset str_buf
    int 21h

    mov si, offset str_buf + 1  ;replace end of string
    mov cx, 0                   ;with '$'
    mov cl, byte ptr [si]
    inc si
    add si, cx
    mov byte ptr [si], '$'

    mov ah, 9           ;print new line
    mov dx, offset n1
    int 21h

    mov ah, 9           ;print mes2
    mov dx, offset mes2
    int 21h

    mov ah, 9           ;print entered string
    mov dx, offset str_buf + 2
    int 21h

    mov ax, 4c00h       ;terminate program
    int 21h
code ends
end start
```

### Program 6: To exchange the content of two words stored in memory

```asm
data segment
    n1 dw 1234h
    n2 dw 4321h
data ends

code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    xchg ax, n2
    mov n1, ax

    mov ax, 4c00h
    mov 21h
code ends
end start
```

### Program 7: To add 5 words

```asm
data segment
    block dw 1234h, 5634h, 00D2h, 23A1h, AA45h
    ans dw ?
data ends
code segment
    assume cs: code , ds:data
start:  
    mov ax, data
    mov ds, ax

    mov cx, 5
    mov ax, 0
    lea bx, block

next:
    add ax, word ptr [bx]
    add bx, 2               ;move to next number
loop next

    mov word ptr [bx], ax   ;store the result

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;372ah
```

### Program 8: To perform scalar multiplication of array of five unsigned bytes

```asm
data segment
    n db 03h
    val db 12h, 0A5h, 0FFh, 34h, 98h
    s_val dw 5 dup(0)
data ends

code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov cx, 5
    mov bl, n
    lea si, val
    lea di, s_val

next:
    mov al, byte ptr [si]
    mul bl
    mov word ptr [di], ax
    inc si
    add di, 2
    loop next

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 9: To divide 32-bit unsigned number by 16-bit unsigned number

```asm
data segment
    dividend dd 11204534h
    divisor dw 1250h
    rem dw ?
    quetient dw ?
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    lea bx, dividend
    mov ax, word ptr [bx]
    mov dx, word ptr [bx + 2]
    div divisor
    mov rem, dx
    mov quetient, ax

    mov ax, 4c00h
    int 21h
code ends
end code
```

### Program 10: To perform ORing of two 16-bits number without using OR instruction

```asm
data segment
    n1 dw 1234h
    n2 dw 4321h
    ans dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    not ax
    mov bx, n2
    not bx

    and ax, bx
    not axd
    mov ans, ax

    mov ax, 4c00h
    int 21h
code ends
end start
```

That's all for this chapter I will be continuously updating this files and add some explanations and many other stuff, till then
Keep coding...!!