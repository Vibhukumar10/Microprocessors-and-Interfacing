;Vibhu Kumar Singh

.model small
.stack 100h
.data

msg1 db 10,13,"Enter a three digit number: $"  
msg2 db 10,13,"The sum of digits: $"
digit db 0
sum db 0

.code                             
start:

       mov ax, @data
       mov ds, ax
       
       lea dx, msg1                        
       mov ah, 09h
       int 21h    
       
  read:       
       
       mov ah, 01
       int 21h   
               
               
       cmp al, 13
       je calculate 
              
       mov digit, al
       sub digit, 30h
              
              
       mov al, sum
       mov bl, 10d
       mul bl
       
       mov ah,0  
       add al, digit
       mov sum, al
    
       jmp read
                                
  calculate:
       
       mov al, sum
  
       aam
      
       mov cl, al 
       
       mov al,ah
        
       aam 
       
       add al, ah
       add al, cl
       
       mov bl, al   
       add bl,30h   

       lea dx, msg2
       mov ah, 09h
       int 21h
       
       mov dl,bl    
       mov ah, 02
       int 21h      
       mov ah, 4ch
       int 21h
      
end start
