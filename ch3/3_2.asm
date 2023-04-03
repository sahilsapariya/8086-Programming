; addition of two 16 bits numbers using the data segment
;exp-4
data segment
    n1 dw 1234h
    n2 dw 4321h
    ans dw ?
data ends

code segment
    assume cs: code, ds: data

start:
    mov ax, data
    mov ds, ax

    mov ax, n1
    add ax, n2

    mov ans, ax
    mov ax, 4c00h
    int 21h

code ends
end start

;output:
;55 55