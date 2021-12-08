print macro m
mov ah,09h
lea dx,m
int 21h
endm


.model small

.data

take_num_count db 10,13, "Enter the count: $"   ;message prompt
count db ?                                      ;variable to store number count
array db 20 dup(0)                              ; array to store numbers(default size is taken as 20) 
prompt db 10,13, "Enter another number: $"      ;message prompt
total_m db 10,13, "The total is : $"            ;message
mean_m db 10,13, "Mean: $"                   ;message
space db 10,13, "  $"                           ;printing space
newline db 10,13, "$"                           ;printing newline
total dw ?                                      ;variable to store total of given numbers
quotient db 10,13, "Quotient is: $"             ;variable to store quotient when total is divided by count
remainder db 10,13, "Remainder is: $"           ;variable to store remainder of total/count
answer dw ?                                     


.code

start: 
     mov ax,@data
	 mov ds,ax
	 
	 print take_num_count    ;prompt
     call accept             ;take input
	 mov count,bl            ;store the count
	 
	 mov ch,count            ; as cl is used in acccept procedure and the value may get overwritten,we use ch for counting
	 mov si,offset array     ;point to the start of the array
	 
	 
	 ; take "count" numbers from the user
	 
inputs: print prompt      ;prompt
        call accept       ;take input number
        mov [si],bl       ;store in the array
        inc si            
        dec ch
        jnz inputs		  ;continue untill all numbers are accepted
   

   
;***********    calculate the total of the numbers  *********************


	    mov ch,count            ;store count value
		mov si,offset array     ;point to start of array
		mov ax,00               ;initialize ax=00 
adding: mov bl,[si]             ;copy to ax the content at memory location pointed by "si"
        mov bh,00               
        add ax,bx               ;add to ax the contents of bx
         inc si                 ;point to next location in the array
		 dec ch                 ;decrement count
		 jnz adding             ;continue untill all numbers are added
		 
		mov total,ax            ;store total
		mov bx,total            ;copy total in bx

		print total_m           ;display message
		call displaynum         ;print the value in bl
		 
		 
;********** Calculating the mean ***************		 
		 ; 
		 ;mean=total/count
		 ; The answer is represented in the form of quotient and remainder after dividing total/count
		 ;
average:  mov ax,total
          mov bl,count
          div bl		    ; quotient in AL,remainder in AH
		  
		  mov answer,ax     ;store the answer(quotient + remainder)
		  
		  mov ax,answer     ;copy the answer in ax
		  mov bl,al         ;copy the quotient in bl in oreder to display
		  
		  print newline     ;print newline
		  print mean_m      ;display message 
		  print quotient    ;print message 
		  call displaynum   ;print the quotient in bl
		  
		  print remainder   ;print message
		  mov ax,answer     ;copy answer in ax. Since we've used "ax" in "displaynum" function,we need to reload the answer
		  mov bl,ah         ;copy remainder in bl,for displaying 
		  call displaynum   ;display the remainder
         
		  

          mov ah,4ch       ;terminate the program
	      int 21h


	   
	   
	   

;accept procedure. Accepts and stores the number in BL

accept proc near

        mov ah,01
        int 21h

        sub al,30h
        cmp al,09
        jbe num
        sub al,07             ;be careful here. This procedure takes care
                              ; of only capital letter(A-F) which are 
num:    mov cl,04             ; correctly converted to proper number
        rol al,cl             ;   For small letters the code will have to
        mov bl,al             ;   be modified as they have different ASCII 
                              ;   values
        mov ah,01
        int 21h
        sub al,30h
        cmp al,09
        jbe num2
        sub al,07

num2:  or bl,al           ; ORing is necessary to store the 8 bit num in
                          ; appropriate format. Adding would also work.
						  ; eg: add bl,al

ret
accept endp


;display procedure. Expects the number to be displayed in "BL"

displaynum proc near


        mov al,bl
        mov cl,04
        and al,0f0h
        shr al,cl
        cmp al,09
        jbe number
        add al,07

number: add al,30h
        mov dl,al
        mov ah,02
        int 21h

        mov al,bl
        and al,00fh
        cmp al,09
        jbe number2
        add al,07
number2: add al,30h
         mov  dl,al
         mov ah,02
         int 21h

ret
displaynum endp

end start