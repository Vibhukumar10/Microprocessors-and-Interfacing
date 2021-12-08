.model small
.stack 100h
.data  
string db 100 dup(?)
msg1 db "Enter a string: $"
msg2 db 0dh, 0ah, "No of words in the string: $"
words dw 0     
.code
main proc
    
     mov ax, @data
     mov ds, ax
     mov es, ax
     
     mov ah, 9
     lea dx, msg1
     int 21h
     
     lea di, string
 
     mov ah, 1
     read:
     int 21h
     cmp al, 0dh
     je endofstring
     stosb
     jmp read
     
     endofstring:
     mov al, "$"
     stosb
     
     xor bx, bx
     
     count:
     mov al, string[bx]
     cmp al, "$"
     je exit
     cmp al, " "
     je word_completed      
     inc bx
     jmp count
     
     word_completed:
     inc words
     inc bx 
     jmp count     
         
     exit:
     inc words
     
     mov ah, 9
     lea dx, msg2
     int 21h
     
     mov ah, 2
     mov dx, words
     add dx, 30h
     int 21h
     
    main endp
end main

