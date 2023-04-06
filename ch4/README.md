# Chapter 4: Branching and Looping

In this chapter we are going to learn about Jump instrunctions and its types, looping instructions and use it in programs.

## Jump

- Unconditional Jump
- Conditional Jump

### Unconditional Jump

The unconditional jump instruction takes the jump unconditionally, i.e. it always jumps once execute

### Conditional Jump

The conditional jump instruction jumps only if the specified condition is true, otherwise it simply acts as no operation (NOP) and the control moves to the next instruction after it.

### Intrasegment (Near or Short) Jumps

We need to change only the IP value in order to perform the jump.

The intrasegment jump of two types:
- **Direct:** Specifies the offset of the target instruction as displacement directly in the instruction. 
- **Indirect:** Specifies the offset of the target instruction using 16-bit register or memory word indirectly.

### Intersegment (Far) Jumps

Jump needs to change both the segment base in CS and the offset in IP.

The intrasegment jump of two types:
- **Direct:** Specifies the offset and the segment address of the target instruction directly in the instruction. 
- **Indirect:** Specifies the offset and segment address of the target instruction indirectly in memory as double word.


### Conditional Jump Instructions

Six conditional flags:

1. Carry flag (CF)
2. Auxiliary carry flag (AF)
3. Parity flag (PF)
4. Zero flag (ZF)
5. Sign flag (SF)
6. Overflow flag (OF)


<table class="table table-bordered"><thead><tr><th><strong>Opcode</strong><br></th><th><strong>Operand</strong><br></th><th style="text-align: center;"><strong>Description</strong><br></th></tr></thead><tbody><tr><td><strong>JC</strong><br></td><td>address<br></td><td>Used to jump if carry flag CY = 1<br></td></tr><tr><td><strong>JNC</strong><br></td><td>address<br></td><td>Used to jump if no carry flag (CY = 0)<br></td></tr><tr><td><strong>JE/JZ</strong><br></td><td>address<br></td><td>Used to jump if equal/zero flag ZF = 1<br></td></tr><tr><td><strong>JNE/JNZ</strong><br></td><td>address<br></td><td>Used to jump if not equal/zero flag ZF = 0<br></td></tr><tr><td><strong>JO</strong><br></td><td>address<br></td><td>Used to jump if overflow flag OF = 1<br></td></tr><tr><td><strong>JNO</strong><br></td><td>address<br></td><td>Used to jump if no overflow flag OF = 0<br></td></tr><tr><td><strong>JP/ JPE</strong><br></td><td>address<br></td><td>Used to jump if parity/parity even PF = 1<br></td></tr><tr><td><strong>JNP/ JPO</strong><br></td><td>address<br></td><td>Used to jump if not parity/parity odd PF = 0<br></td></tr><tr><td><strong>JS</strong><br></td><td>address<br></td><td>Used to jump if sign flag SF = 1<br></td></tr><tr><td><strong>JNS</strong><br></td><td>address<br></td><td>Used to jump if not sign SF = 0<br></td></tr><tr><td><strong>JA/ JNBE</strong><br></td><td>address<br></td><td>Used to jump if above/not below/equal instruction satisfies.<br></td></tr><tr><td><strong>JAE/ JNB</strong><br></td><td>address<br></td><td>Used to jump if above/not below instruction satisfies.<br></td></tr><tr><td><strong>JBE/ JNA</strong><br></td><td>address<br></td><td>Used to jump if below/equal/ not above instruction satisfies.<br></td></tr><tr><td><strong>JG/ JNLE</strong><br></td><td>address<br></td><td>Used to jump if greater/not less than/equal instruction satisfies.<br></td></tr><tr><td><strong>JGE/ JNL</strong><br></td><td>address<br></td><td>Used to jump if greater than/equal/not less than instruction satisfies.<br></td></tr><tr><td><strong>JL/ JNGE</strong><br></td><td>address<br></td><td>Used to jump if less than/not greater than/equal instruction satisfies.<br></td></tr><tr><td><strong>JLE/ JNG</strong><br></td><td>address<br></td><td>Used to jump if less than/equal/if not greater than instruction satisfies.<br></td></tr><tr><td><strong>JCXZ</strong><br></td><td>address<br></td><td>Used to jump to the provided address if CX = 0<br></td></tr><tr><td><strong>LOOPE/ LOOPZ</strong><br></td><td>address<br></td><td>Used to loop a group of instructions till it satisfies ZF = 1 &amp; CX = 0<br></td></tr><tr><td><strong>LOOPNE/ LOOPNZ</strong><br></td><td>address<br></td><td>Used to loop a group of instructions till it satisfies ZF = 0 &amp; CX = 0<br></td></tr></tbody></table>


## Getting started with Programs

### Program 1: To find whether two numbers are equal or not

```asm
data segment
    mes1 db "Both the numbers are same $"
    mes2 db "Both the numbers are different $"
    n1 dw 1234h
    n2 dw 1234h
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    cmp ax, n2

    mov ah, 9
    jnz noteq
    lea dx, mes1
    jmp over
noteq:  lea dx, mes2
over:   int 21h
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;Both the numbers are same
```

### Program 2: To find minimum of two 16-bit numbers

```asm
data segment
    n1 dw 1234h
    n2 dw 4321h
    min dw ?
data ends
code segment
    assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    cmp ax, n2
    jc skip     ;ax < n2
    mov ax, n2  ;ax > n2
skip:   mov min, ax
    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 3: To check the number is even or odd

```asm
data segment
    n1 dw 4387h
    _odd db "number is _odd $"
    _even db "number is _even $"
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    and ax, 0001h
    cmp ax, 0001h

    mov ah, 9
    jz skip
    lea dx, _even
    jmp over
skip:   lea dx, _odd
over:   int 21h

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 4: To find the sum of first N numbers

```asm 
data segment
    n dw 000Ah
    sum dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, 0   
    mov bx, 1
    mov cx, n

next:
    add ax, bx
    inc bx
    dec cx
    jnz next
    mov sum, ax
    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;37h
```

### Program 5: To find the sum of N 16-bits numbers

```asm
data segment
    block dw 0005h, 1234h,4321h, 1215h, 456Dh, 1593h
        dw ?
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov si, offset block
    mov cx, word ptr [si]
    add si, 2
    mov ax, word ptr [si]

next:    add si, 2
    dec cx
    jz over
    add ax, word ptr [si]
    jmp next
over:
    mov word ptr [si], ax
    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 6: To find the minimum from a N 16-bits numbers

```asm
data segment
    block dw 0005h, 1234h, 4567h, 0001h, 7896h, 3610h
    ans dw ?
data ends
code segment
    assume cs: code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov si, offset block
    mov cx, word ptr [si]
    add si, 2
    mov ax, word ptr [si]

next:   
    add si, 2
    dec cx
    jz over
    cmp ax, word ptr [si]
    jc skip
    mov ax, word ptr [si]
skip:   jmp next
over:
    mov ans, ax

    mov ax, 4c00h
    int 21h
code ends
end start

;output:
;0001h
```

### Program 7: To reverse the givern array of 16-bit numbers

```asm
data segment
    block dw 0006h, 0001h, 0002h, 0003h, 0004h, 0005h, 0006h
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    lea si, block
    mov cx, word ptr [si]
    add si, 2

    mov dx, cx  ;multiply CX by 2
    mov al, dl
    mov bl, 2
    mul bl
    mov dx, ax
    sub dx, 2

    mov di, si  ;di pointing to the end
    add di, dx  

    mov ax, cx
    mov bl, 2
    div bl
    mov cx, 0
    mov cl, al

next:   mov ax, word ptr [si]
    mov bx, word ptr [di]
    mov word ptr [si], bx
    mov word ptr [di], ax
    add si, 2
    sub di, 2
    dec cx
    jnz next

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 8: To sort the given block of 8-bit numbers

```asm
data segment
    block db 05h, 23h, 0A2h, 66h, 12h, 7Dh
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    lea si, block
    mov cx, 0               ;get size
    mov cl, byte ptr [si]   ;into cl
    dec cx                  ;set no. of passes
outer:  mov dx, cx
    inc si
    mov di, si
inner:  inc di
    mov al, byte ptr [si]
    cmp al, byte ptr [di]
    jbe skip
    mov bl, al
    mov al, byte ptr [di]
    mov byte ptr [di], bl
    mov byte ptr [si], al
skip:   dec dx
    jnz inner
    dec cx
    jnz outer
    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 9: To find the factorial of given 8-bit number

```asm
data segment
    n db 05h
    ans dw ?
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 0
    mov cl, n
    mov ax, 1
    mov bx, 1

next:    mul bx
    inc bx
    cmp bx, cx
    jbe next

    mov ans, ax
    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 10: To find the first 10 numbers of fibonacci series

```asm
data segment
    series db 10 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 10
    mov si, offset series
    mov al, 0       ;first number 
    mov byte ptr [si], al
    inc si
    mov al, 1
    mov byte ptr [si], al
    inc si
    mov al, 0
    mov bl, 1
    sub cx, 2

next:   add al, bl
    mov dl, al
    mov byte ptr [si], al
    inc si 
    dec cx
    mov al, bl
    mov bl, dl 
    loop next

    mov ax, 4c00h
    int 21h
code ends
end start
```

### Program 11: To generate first 10 fibonacci numbers in decimal form starting from 0 and 1

```asm
data segment
   fib db 10 dup(0)
data ends
code segment
    assume cs:code, ds:data
start:  mov ax, data
    mov ds, ax

    mov cx, 10
    mov si, offset fib
    mov al, 0
    daa
    mov byte ptr [si], al
    inc si
    mov al, 1
    daa
    mov byte ptr [si], al
    inc si
    sub cx, 2
    mov al, 0
    mov bl, 1
next:   add al, bl
    daa
    mov dl, al
    mov byte ptr [si], al 
    inc si 
    mov al, bl 
    mov bl, dl 
    loop next


    mov ax, 4c00h
    int 21h
code ends
end start
```