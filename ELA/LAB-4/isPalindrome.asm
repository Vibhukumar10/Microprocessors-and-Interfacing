;macro for printing a string
print macro m
mov ah,09h
mov dx,offset m
int 21h
endm

.model small


;******  Data Segment ******
.data

empty db 10,13, "   $"
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
len db ?
mstring db 10,13, "Enter the string: $"
notpalin db 10,13, "String is not a palindrome. $"
palin db 10,13, "String is a palindrome. $"



;********** Code Segment ************

.code

start:
mov ax,@data
mov ds,ax

again:

		print mstring
        call accept_string
        

        mov si,offset str1
		mov cl,str1+1        ;store the length
		mov ch,00h
		mov len,cl
		inc si
		add si,cx            ;si points to last
		        
		mov di,offset str1   ;di to start of string
		add di,0002h         ;di to actual start of string;
		
		;in string 0th byte->size
		;          1st byte->length of string
        ;          from 2nd byte->actual string 		
         
		mov cl,len ;load counter
 cmpagain: mov al,[si]
           mov ah,[di]
		   inc di
		   dec si
           cmp al,ah
           jne nopalin
		   dec cl
		   jnz cmpagain
          	
		print palin
		jmp exit
		
nopalin: print notpalin

exit:
mov ah,4ch       ;exit the program
int 21h


;accept procedure

accept proc near

mov ah,01
int 21h
ret
accept endp

display1 proc near

   mov al,bl
   mov bl,al
   and al,0f0h
   mov cl,04
   rol al,cl

   cmp al,09
   jbe number
   add al,07
number:  add al,30h
         mov dl,al
         mov ah,02
         int 21h

         mov al,bl
         and al,00fh
         cmp al,09
         jbe number2
         add al,07
number2:  add al,30h
          mov dl,al
          mov ah,02
          int 21h
ret
display1 endp



accept_string proc near

mov ah,0ah          ;accept string from user function
mov dx,offset str1  ; store the string in memory pointed by "DX"
int 21h
ret
accept_string endp

end start
end