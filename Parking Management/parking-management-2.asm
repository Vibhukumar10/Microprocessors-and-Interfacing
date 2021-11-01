  .model small
  .stack 100h
  .data
      start db   ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'
      start1 db  ';;                     PARKING MANAGEMENT SYSTEM                     ;;$'
      start2 db  ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'
      start3 db  ';;                                BY                                 ;;$'
      start4 db  ';;                   Vibhu Kumar Singh - 19BCE0215                   ;;$'
      start5 db  ';;                     Mihir Gupta - 19BCE0619                       ;;$'
      start6 db  ';;                    Avnish Tiwari - 19BCE0634                      ;;$'
      start7 db  ';;                     Tushar Goel - 19BCE2185                       ;;$'
      start8 db  ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'
      start9 db  ';;                              TEACHER                              ;;$'
      start10 db ';;                           Mr. Konguvel E.                         ;;$'
      start11 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'



      menu db  ';;;;;;;;;;;;;;;;;;;;MAIN MENU;;;;;;;;;;;;;;;;;;;;$'
      menu1 db ';; Press 1 for Two-Wheelers                    ;;$'                      
      menu2 db ';; Press 2 for Four-Wheelers                   ;;$'
      ; menu3 db ';; Press 3 for                                 ;;$'
      menu4 db ';; Press 3 to Show Record                      ;;$'
      menu5 db ';; Press 4 to Delete Record                    ;;$'
      menu6 db ';; Press 5 to Exit                             ;;$'
      menu7 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'

      two_menu db  ';;;;;;;;;;;;;;;;;TWO-WHEELER MENU;;;;;;;;;;;;;;;;$'
      two_menu1 db ';; Press 1 for Pricing                         ;;$'                      
      two_menu2 db ';; Press 2 to Check Space Availibilty          ;;$'                      
      two_menu3 db ';; Press 3 to Purchase Parking Ticket          ;;$'                      
      two_menu4 db ';; Press 4 to Go Back                          ;;$'     
      two_menu5 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'   
      two_price db 'Rs. 200$'
      four_price db 'Rs. 400$'

      price db 'The price is: $'
      any_key db 'Press any key to start...$'
      choice db 'Please enter your choice:$'
      wrong_choice db 'Wrong Input, Please try again!$'
      goback db 'Press any key to go back...$'

      msg1 db 'Parking Is Full$'
      msg2 db 'Wrong input$'
      msg3 db 'car$'
      msg4 db 'bus$'
      msg5 db 'record$'
      msg6 db 'there is more space$'
      msg7 db 'the total amount is=$'
      msg8 db 'the total numbers of vehicles parked=$'
      msg9 db 'the total number of rikshws parked=$'
      msg10 db 'the total number of cars parked=$'
      msg11 db 'the total number of buses parked=$'
      msg12 db '***Record deleted successfully***$'
      amount dw 0
      count dw '0'
      count1 dw '0'
      ; am1 dw ?
      ; am2 dw ?
      ; am3 dw ?

      two_avail_msg db 'The number of spaces left for Two-Wheelers are: $'
      
      r_left dw '4'
      c_left dw '4'
      
      r dw '0'
      c db '0'
      b db '0'
      
  .code
  ;****************MAIN PROGRAM****************
  main proc
      mov ax,@data
      mov ds,ax

      call start_program

  main endp

  ;************************END OF MAIN PROGRAM***************************

  ;***********************MAIN MENU****************************
  main_menu proc
      while_:   
                  ;Menu
      call clr
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      call put_main_menu

        ;userinput
      
      call user_choice
      
      
        ;now compare
      mov al,bl
      cmp al,'1'
      je two_wheeler
      cmp al,'2'
      je car
      cmp al,'3'
      je rec
      cmp al,'4'
      je del
      cmp al,'5'
      je end_
      
      mov dx,offset wrong_choice
      call puts
      call getc

      jmp while_
      
      car:
      call clr
      call caar
      call back
      
      
      rec:
      call clr
      call recrd
      call back
      
      
      del:
      call clr
      call delt
      call back
      
      
      bus:
      call clr
      call buss
      call back
      
      
      
      end_:
      mov ah,4ch
      int 21h

  main_menu endp

  ;*******************END OF MAIN_MENU*************************
      

      ;*********Two Wheeler************
      two_wheeler proc 
      okay:
      call clr

      call put_two_menu
      call user_choice

      mov al,bl
      cmp al,'1'
      je show_two_price
      cmp al,'2'
      je show_two_avail
      cmp al,'3'
      je purchase_two_ticket
      cmp al,'4'
      je main_menu
      cmp al,'5'
      je del
      cmp al,'6'
      je end_

      show_two_price:
      call put_two_price

      purchase_two_ticket:
      call put_two_ticket

      show_two_avail:
      call put_two_avail

      call getc

      two_wheeler endp


      ;*********PUT_TWO_AVAIL***********
      put_two_avail proc
      call clr
      
      mov dx,offset two_avail_msg
      call puts


      mov dx, r_left
      mov ah,2
      int 21h

      call endl
      call endl

      mov dx,offset goback
      call puts

      call getc

      call two_wheeler

      ret
      put_two_avail endp
      
      ;**********PUT_TWO_TICKET***********
      
      put_two_ticket proc
      call clr
      cmp r,'4'
      jl two1
      mov dx,offset msg1
      mov ah,9
      int 21h
      ; jmp while_
      ; jmp end_

      mov dx,offset goback
      call puts

      call getc

      call two_wheeler
      
      two1:
      mov ax,200
      add amount, ax
      mov dx,0 ; remainder is 0
      mov bx,10 
      mov cx,0
      l2:
              div bx
              push dx
              mov dx,0
              mov ah,0
              inc cx
              cmp ax,0
              jne l2

        
      l3:
              pop dx
              add dx,48
              mov ah,2
              int 21h
      loop l3

      call endl

      inc count
      inc r
      dec r_left

      call endl
      
      call back
      ret
      put_two_ticket endp

      ;*********PUT_TWO_PRICE************
      put_two_price proc
      call clr

      mov dx,offset price
      call puts

      mov dx,offset two_price
      call puts

      call endl

    
      mov dx,offset goback
      call puts

      call getc

      ; call clr
      
      call two_wheeler

      ret
      put_two_price endp
      
      
      
      ;**********CAR***********
      caar proc
      cmp count,'8'
      jle car1
      mov dx,offset msg1
      mov ah,9
      int 21h
      jmp while_
      jmp end_
      
      car1:
      mov ax,300
      add amount, ax
      mov dx,0
      mov bx,10
      mov cx,0
      l22:
              div bx
              push dx
              mov dx,0
              mov ah,0
              inc cx
              cmp ax,0
            jne l22
        
      l33:
              pop dx
              add dx,48
              mov ah,2
              int 21h
      loop l33
      
      inc count
      inc c
      ret

      caar endp
      
      
      
      ;*******BUS*******
      buss proc
      cmp count,'8'
      jle bus1
      mov dx,offset msg1
      mov ah,9
      int 21h
      jmp while_
      jmp end_
      
      bus1:
      mov ax,400
      add amount, ax
      mov dx,0
      mov bx,10
      mov cx,0
      l222:
              div bx
              push dx
              mov dx,0
              mov ah,0
              inc cx
              cmp ax,0
            jne l222
        
      l333:
              pop dx
              add dx,48
              mov ah,2
              int 21h
      loop l333
      
      inc count
      inc b
      ret
      
      buss endp

      
      recrd proc
      mov dx,offset msg7
      mov ah,9
      int 21h
      
      
      ; print here the whole amount
      mov ax, amount
      
      mov dx,0
      mov bx,10
      mov cx,0
      totalpush:
              div bx
              push dx
              mov dx,0
            ;  mov ah,0
              inc cx
              cmp ax,0
            jne totalpush
        
      totalprint:
              pop dx
              add dx,48
              mov ah,2
              int 21h
      loop totalprint
      
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      mov dx,offset msg8
      mov ah,9
      int 21h
      
      mov dx,count
      mov ah,2
      int 21h
      
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      
      mov dx,offset msg9
      mov ah,9
      int 21h
      
      mov dx,r
      mov ah,2
      int 21h
      
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      
      
      mov dx,offset msg10
      mov ah,9
      int 21h
      
      
      mov dl,c
      mov ah,2
      int 21h
      
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      
      
      mov dx,offset msg11
      mov ah,9
      int 21h
      
      mov dl,b
      mov ah,2
      int 21h
      
      ; jmp while_
      ; jmp end_
      ret

      recrd endp


      
      ;********DELETE RECORDS***********
      delt proc
      mov r,'0'
      mov c,'0'
      mov b,'0'
      mov amount,0
      ;sub amount,48
      mov count,'0'
      mov dx,offset msg12
      mov ah,9
      int 21h
      
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      
      ; jmp while_
      ; jmp end_
      ret

      delt endp

      clr proc
      mov ah,00
      mov al,02
      int 10h
      ret
      clr endp

      ;*******GETC******
      getc proc
      mov ah, 1
    int 21h
      ret
      getc endp

      ;*******PUTS*******
      puts proc
      mov ah,9
      int 21h
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      ret
      puts endp

      ;*******BACK******
      back proc
      mov dx,offset goback
      call puts
      call getc
      jmp while_
      ret
      back endp

      ;*****USER_CHOICE******
      user_choice proc
      mov ah,1
      int 21h
      mov bl,al
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h
      ret
      user_choice endp

      ;********START_PROGRAM********
      start_program proc
      call clr
      mov dx,10
      mov ah,2
      int 21h
      mov dx,13
      mov ah,2
      int 21h

      mov dx,offset start
      call puts
      
      mov dx,offset start1
      call puts

      mov dx,offset start2
      call puts

      mov dx,offset start3
      call puts

      mov dx,offset start4
      call puts

      mov dx,offset start5
      call puts

      mov dx,offset start6
      call puts

      mov dx,offset start7
      call puts

      mov dx,offset start8
      call puts

      mov dx,offset start9
      call puts

      mov dx,offset start10
      call puts

      mov dx,offset start11
      call puts

      mov dx,offset any_key
      call puts
      
      call getc
      call main_menu 
      ret

      start_program endp

      ;*********PUT_MAIN_MENU************
      put_main_menu proc
      mov dx,offset menu
      call puts
      
      mov dx,offset menu1
      call puts
      
      mov dx,offset menu2
      call puts
      
      ; mov dx,offset menu3
      ; call puts
      
      mov dx,offset menu4
      call puts
      
      mov dx,offset menu5
      call puts
      
      mov dx,offset menu6
      call puts

      mov dx,offset menu7
      call puts

      mov dx,offset choice
      call puts

      ret
      put_main_menu endp

      ;*********PUT_TWO_MENU*************
      put_two_menu proc
      call clr
      mov dx,offset two_menu
      call puts

      mov dx,offset two_menu1
      call puts

      mov dx,offset two_menu2
      call puts

      mov dx,offset two_menu3
      call puts

      mov dx,offset two_menu4
      call puts

      mov dx,offset two_menu5
      call puts

      mov dx,offset choice
      call puts

      ret

      put_two_menu endp

      endl proc
      mov dx,13
      mov ah,2
      int 21h  
      mov dx,10
      mov ah,2
      int 21h
      ret
      endl endp
  end main