data_new segment
    data1 dw 13h
    data2 dw 0D7h
    data3 dw 1 dup<?>
    data_new ends

code segment
    assume cs:code,ds:data_new
    start:
    mov ax,data_new
    mov ds,ax
    
    mov ax,data1
    mov bx,data2
    add ax,bx
    mov data3,ax
    
    code ends
end start
end