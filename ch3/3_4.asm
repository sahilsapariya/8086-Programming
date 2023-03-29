; write a program to display message "Hello world"

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

;output:
;Hello world