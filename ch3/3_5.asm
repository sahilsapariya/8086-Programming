;wap to read string and display it.
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

;output:
;Enter a string : Hello Sahil!
;Entered string is : Hello Sahil!