data_new segment
    data1 dw 13h
    data2 dw 0D7h
    data_new ends

code segment
    assume cs: code, ds: data_new
    start:
    mov ax,data_new
    mov ds,ax
    
    mov ax,data1
    push ax
    mov ax,data2
    push ax
    pop ax
    
    mov ah,0
    end start
    code ends
ret