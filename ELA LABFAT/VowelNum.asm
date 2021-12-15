;Vibhu Kumar Singh 19BCE0215

.model small
.stack 100h
.data  
string db 100 dup(?)
msg1 db "Enter a string: $"
msg2 db 0dh, 0ah, "No. of Vowels: $"
vowels dw 0     
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
     cmp al, "a"
     je vowel
     cmp al, "e"
     je vowel
     cmp al, "i"
     je vowel
     cmp al, "o"
     je vowel
     cmp al, "u"
     je vowel
     cmp al, "a"
     je vowel
     cmp al, "e"
     je vowel
     cmp al, "i"
     je vowel
     cmp al, "o"
     je vowel
     cmp al, "u"
     je vowel      
     inc bx
     jmp count
     
     vowel:
     mov cx, vowels
     inc cx
     mov vowels, cx
     inc bx 
     jmp count 
      exit:
     
     mov ah, 9
     lea dx, msg2
     int 21h
     
     mov ah, 2
     mov dx, vowels
     add dx, 30h
     int 21h
     
    main endp
end main
 