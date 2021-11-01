mov ax,16d
mov cx,0000
mov bx,0FFFFh
L1:
add bx,02
inc cx
sub ax,bx
jnz L1

mov ah,02h
mov dl,cl
add dl, '0'
int 21h
hlt