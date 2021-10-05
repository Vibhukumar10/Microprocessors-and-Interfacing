.model small
.stack 100h
    CR equ 13d
    LF equ 10d
.data
msg1 db 'Enter an uppercase letter: $'
result db CR, LF, 'The lowercase equivalent is: $'
.code
;main program
start:
    mov ax, @data
    mov ds, ax
    mov dx, offset msg1
    call puts; prompt for uppercase letter
    call getc; read uppercase letter
    mov bl, al; save character in bl
    add bl, 32d; convert to lowercase
    mov dx, offset result
    call puts; display result message
    mov dl, bl
    call putc; display lowercase letter
    mov ax, 4c00h
    int 21h; return to ms-dos
    
 
; user defined subprograms
puts:; display a string terminated by $; dx contains address of string
    mov ah, 9h
    int 21h; output string
    ret
putc:; display character in dl
    mov ah, 2h
    int 21h
    ret
getc:; read character into al
    mov ah, 1h
    int 21h
    ret
end start