; wap to perform scalar multiplication of array of five unsigned bytes.
;exp-4
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

