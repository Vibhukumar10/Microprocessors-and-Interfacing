.stack
.data
arr dw 0101h,0202h,0303h,0404h,0505h
len dw 5
key equ 0202h
msg1 db "key found at position "
res db " ",13,10,"$"
msg2 db 'key not found $'

.code
mov ax,@data
mov ds,ax
mov bx,00
mov dx,len
mov cx,key

loop1:
    cmp bx,dx
    ja no
    mov ax,bx
    add ax,dx
    shr ax,1
    mov si,ax
    add si,si
    cmp cx,arr[si]
    jae l1
    dec ax
    mov dx,ax
    jmp loop1

l1:
    je yes
    inc ax
    mov bx,ax
    jmp loop1

yes:
    add al,01
    add al,'0'
    mov res,al
    lea dx,msg1
    jmp disp

no:
    lea dx,msg2

disp:
    mov ah,09h
    int 21h
    mov ah,4ch
