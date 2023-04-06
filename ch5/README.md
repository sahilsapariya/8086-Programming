# Chapter 5: Shift, Rotate and String Instructions

### String Instructions

- REP/REPE/REPZ/REPNE/REPNZ
- MOVS/MOVSB/MOVSN
- CMPS/CMPSB/CMPSW
- SCAS/SCASB/SCASW
- LODS/LODSB/LODSW
- STOS/STOSB/STOSW

<table width="100%"><thead><tr><th style="padding:8px;background-color:#4cb96b;text-align:center">OPCODE</th><th style="padding:8px;background-color:#4cb96b;text-align:center">OPERAND</th><th style="padding:8px;background-color:#4cb96b;text-align:center">EXPLANATION</th><th style="padding:8px;background-color:#4cb96b;text-align:center">EXAMPLE</th></tr></thead><tbody><tr><td style="text-align:center">REP</td><td style="text-align:center">instruction</td><td>repeat the given instruction till CX != 0</td><td style="text-align:center">REP MOVSB</td></tr><tr><td style="text-align:center">REPE</td><td style="text-align:center">instruction</td><td>repeat the given instruction while CX = 0</td><td style="text-align:center">REPE</td></tr><tr><td style="text-align:center">REPZ</td><td style="text-align:center">instruction</td><td>repeat the given instruction while ZF = 1</td><td style="text-align:center">REPZ</td></tr><tr><td style="text-align:center">REPNE</td><td style="text-align:center">instruction</td><td>repeat the given instruction while CX != 0</td><td style="text-align:center">REPNE</td></tr><tr><td style="text-align:center">REPNZ</td><td style="text-align:center">instruction</td><td>repeat the given instruction while ZF = 0</td><td style="text-align:center">REPNZ</td></tr><tr><td style="text-align:center">MOVSB</td><td style="text-align:center">none</td><td>moves contents of byte given by DS:SI into ES:DI</td><td style="text-align:center">MOVSB</td></tr><tr><td style="text-align:center">MOVSW</td><td style="text-align:center">none</td><td>moves contents of word given by DS:SI into ES:DI</td><td style="text-align:center">MOVSW</td></tr><tr><td style="text-align:center">MOVD</td><td style="text-align:center">none</td><td>moves contents of double word given by DS:SI into ES:DI</td><td style="text-align:center">MOVD</td></tr><tr><td style="text-align:center">LODSB</td><td style="text-align:center">none</td><td>moves the byte at address DS:SI into AL; SI is incr/decr by 1</td><td style="text-align:center">LODSB</td></tr><tr><td style="text-align:center">LODSW</td><td style="text-align:center">none</td><td>moves the word at address DS: SI into AX; SI is incr/decr by 2</td><td style="text-align:center">LODSW</td></tr><tr><td style="text-align:center">LODSD</td><td style="text-align:center">none</td><td>moves the double word at address DS:SI into EAX; SI is incr/decr by 4</td><td style="text-align:center">LODSD</td></tr><tr><td style="text-align:center">STOSB</td><td style="text-align:center">none</td><td>moves contents of AL to byte address given by ES:DI; DI is incr/dec by 1</td><td style="text-align:center">STOSB</td></tr><tr><td style="text-align:center">STOSW</td><td style="text-align:center">none</td><td>moves the contents of AX to the word address given by ES:DI; DI is incr/decr by 2</td><td style="text-align:center">STOSW</td></tr><tr><td style="text-align:center">STOSD</td><td style="text-align:center">none</td><td>moves contents of EAX to the DOUBLE WORD address given by ES:DI; DI is incr/decr by 4</td><td style="text-align:center">STOSD</td></tr><tr><td style="text-align:center">SCASB</td><td style="text-align:center">none</td><td>compares byte at ES:DI with AL and sets flags according to result</td><td style="text-align:center">SCASB</td></tr><tr><td style="text-align:center">SCASW</td><td style="text-align:center">none</td><td>compares word at ES:DI with AX and sets flags</td><td style="text-align:center">SCASW</td></tr><tr><td style="text-align:center">SCASD</td><td style="text-align:center">none</td><td>compares double word at ES:DI with EAX and sets flags</td><td style="text-align:center">SCASD</td></tr><tr><td style="text-align:center">CMPSB</td><td style="text-align:center">none</td><td>compares byte at ES:DI with byte at DS:SI and sets flags</td><td style="text-align:center">CMPSB</td></tr><tr><td style="text-align:center">CMPSW</td><td style="text-align:center">none</td><td>compares word at ES:DI with word at DS:SI and sets flags</td><td style="text-align:center">CMPSW</td></tr><tr><td style="text-align:center">CMPSD</td><td style="text-align:center">none</td><td>compares double word at ES:DI with double word at DS:SI and sets flags</td><td style="text-align:center">CMPSD</td></tr></tbody></table>

## Getting started with Programs

### Program 1: To count the number of 1 bits in the binary representation of a given 16-bit operand

```asm
data segment
    num dw 32AFh
    count db ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, num
    mov count, 0
    mov cx, 16
    
next:   shl ax, 1
    jnc skip
    inc count
skip:   loop next
    
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;0009h
```

### Program 2: To count the number of similar bits in the two 16-bit numbers

```asm
data segment
    n1 dw 1234h
    n2 dw 4321h
    count db ?
data ends

code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, n1
    mov bx, n2
    xor ax, bx

    mov count , 0
    mov cx, 16
next:   shl ax, 1
    jc skip
    inc count
skip:   loop next

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;000Ah
```

### Program 3: To separate the nibbles of a 16-bit number

```asm
data segment
   num dw 54A2h
   nibbles db 4 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov ax, num
    mov cl, 0
    mov bx, 4
    lea si, nibbles         ;point to nibbles
next:   shr ax, cl          ;shift 4 times right
    mov dx, ax              ;AND with 000Fh
    and dx, 000Fh           ;to separate nibble
    mov byte ptr [si], dl   ;store the nibble
    inc si 
    mov cl, 4               ;make cl = 4
    dec bx
    jnz next                ;goto next, if not zero



    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;02 0A 04 05
```

### Program 4: To exchange the nibbles of given number

```asm
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
```

### Program 5: To convert given hex number to decimal number (skip)

```asm
data segment
   mes1 db "Enter hex number : $"
   buf db 5, 6 dup(0)
   mes2 db 0dh, 0ah, "Decimal of given hex is : $"
data ends

code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    ;PART-1 Convert from hex string to binary
    mov ah, 09h
    lea dx, mes1
    int 21h

    mov ah, 0ah     ;read hex string
    lea dx, buf
    int 21h

    lea si, buf + 1 ;get length of string
    mov bx, 0
    mov bl, [si]
    inc si          ;point to first char
    mov cx, 4       ;initialize
    mov ax, 0

next:   mov dx, 0
    mov dl, [si]    ;get next ASCII digit
    cmp dl, '9'     ;convert it to binary
    jle digit
    sub dl, '7'
digit:  sub dl, '0'
    shl ax, cl
    add ax, dx
    inc si
    dec bx
    jnz next
    push ax

    ;PART-2 Convert binary to decimal string
    mov ah, 09h
    lea dx, mes2
    int 21h

    pop ax
    mov cx, 0
    mov bx, 10
next1:  mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    ja next1

    mov ah, 2

next2:  pop dx
    add dx, '0'
    int 21h
    loop next2

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 6: To copy a string defined in data segment

```asm
data segment
   mes1 db "Hello, Sahil!$"
   mes2 db 13 dup (0), '$'
data ends
code segment
    assume cs:code, ds:data, es:data
start:  mov ax, data    ;initialize data segment
    mov ds, ax
    mov es, ax          ;initialize extra segment

    mov si, offset mes1
    mov di, offset mes2
    cld                 ;clear direction flag i.e. DF = 0
    mov cx, 13

rep movsb   ;repeat move instruction

    mov ah, 9
    lea dx, mes2
    int 21h

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 7: To display the date of BIOS of your system (skip)

```asm
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

next:   lodsb
    stosb
    loop next

    mov ah, 9
    mov bx, seg str1
    mov ds, bx
    lea dx, str1
    int 21h

    mov ax, 4c00h
    int 21h

code ends
end start
```