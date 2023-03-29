;Write a program to convert a given alphabt from lowercase to uppercase.

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

; output:
; sS