; addition of two 16 bits numbers without using the data segment

code segment
    assume cs: code
start:
    mov ax, 1234h
    mov bx, 4321h

    add ax, bx

    int 3h

code ends
end start


;output:
;55 55