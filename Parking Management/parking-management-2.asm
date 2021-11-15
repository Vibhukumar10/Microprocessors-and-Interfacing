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
      menu3 db ';; Press 3 for Space Availability              ;;$'
      menu4 db ';; Press 4 to Show Record                      ;;$'
      menu5 db ';; Press 5 to Delete Record                    ;;$'
      menu6 db ';; Press 6 to Exit                             ;;$'
      menu7 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'

      two_menu db  ';;;;;;;;;;;;;;;;;TWO-WHEELER MENU;;;;;;;;;;;;;;;;$'
      two_menu1 db ';; Press 1 for Pricing                         ;;$'                      
      two_menu2 db ';; Press 2 to Check Space Availibilty          ;;$'                      
      two_menu3 db ';; Press 3 to Purchase Parking Ticket          ;;$'                      
      two_menu4 db ';; Press 4 to Go Back                          ;;$'     
      two_menu5 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'   
      two_price db 'Rs. 200$'

      four_menu db  ';;;;;;;;;;;;;;;;;FOUR-WHEELER MENU;;;;;;;;;;;;;;;$'
      four_menu1 db ';; Press 1 for Pricing                         ;;$'                      
      four_menu2 db ';; Press 2 to Check Space Availibilty          ;;$'                      
      four_menu3 db ';; Press 3 to Purchase Parking Ticket          ;;$'                      
      four_menu4 db ';; Press 4 to Go Back                          ;;$'     
      four_menu5 db ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$'   
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
      msg7 db 'The total amount is = $'
      msg8 db 'The total numbers of vehicles parked = $'
      msg9 db 'The total number of Two-Wheelers parked = $'
      msg10 db 'The total number of Four-Wheelers parked = $'
      msg12 db '***Record Deleted Successfully***$'
      amount dw 0
      count dw '0'
      count1 dw '0'

      two_avail_msg db 'The number of spaces left for Two-Wheelers are: $'
      four_avail_msg db 'The number of spaces left for Four-Wheelers are: $'
      total_avail_msg db 'The number of spaces left are: $'
      
      r_left dw '4'
      c_left dw '4'
      
      r dw '0'
      c db '0'

      
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
      je four_wheeler
      cmp al,'3'
      je avail_total
      cmp al,'4'
      je rec
      cmp al,'5'
      je del
      cmp al,'6'
      je end_
      
      mov dx,offset wrong_choice
      call puts
      call getc

      jmp while_
      
      avail_total:
      call clr
      call avail_main
      call back


      rec:
      call clr
      call recrd
      call back
      
      del:
      call clr
      call delt
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
      call main_menu
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

      ;*********Four wheeler************

      four_wheeler proc 
;       okay:
      call clr

      call put_four_menu
      call user_choice

      mov al,bl
      cmp al,'1'
      je show_four_price
      cmp al,'2'
      je show_four_avail
      cmp al,'3'
      je purchase_four_ticket
      cmp al,'4'
      call main_menu
      cmp al,'5'
      je del
      cmp al,'6'
      je end_

      show_four_price:
      call put_four_price

      purchase_four_ticket:
      call put_four_ticket

      show_four_avail:
      call put_four_avail

      call getc

      four_wheeler endp

      ;**********avail_main***********
      avail_main proc
      mov dx,offset total_avail_msg
      call puts

      ;sum of cars + bikes
      mov ax,r_left
      mov bx,c_left
      add ax,bx
      mov dx,ax
      mov ah,2
      int 21h

      call endl
      call endl

      mov dx,offset two_avail_msg
      call puts


      mov dx, r_left
      mov ah,2
      int 21h

      call endl
      call endl

      mov dx,offset four_avail_msg
      call puts


      mov dx, c_left
      mov ah,2
      int 21h

      call endl
      call endl

      ret
      avail_main endp


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

      ;*********PUT_FOUR_AVAIL***********
      put_four_avail proc
      call clr
      
      mov dx,offset four_avail_msg
      call puts


      mov dx, c_left
      mov ah,2
      int 21h

      call endl
      call endl

      mov dx,offset goback
      call puts

      call getc

      call four_wheeler

      ret
      put_four_avail endp
      
      ;**********PUT_TWO_TICKET***********
      
      put_two_ticket proc
      call clr
      cmp r,'4'
      jl two1
      mov dx,offset msg1
      mov ah,9
      int 21h

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

      ;**********PUT_FOUR_TICKET***********
      
      put_four_ticket proc
      call clr
      cmp c,'4'
      jl four1
      mov dx,offset msg1
      mov ah,9
      int 21h

      mov dx,offset goback
      call puts

      call getc

      call four_wheeler
      
      four1:
      mov ax,400
      add amount, ax
      mov dx,0 ; remainder is 0
      mov bx,10 
      mov cx,0
      l4:
              div bx
              push dx
              mov dx,0
              mov ah,0
              inc cx
              cmp ax,0
              jne l4

        
      l5:
              pop dx
              add dx,48
              mov ah,2
              int 21h
      loop l5

      call endl

      inc count
      inc c
      dec c_left

      call endl
      
      call back
      ret
      put_four_ticket endp

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

      ;*********PUT_FOUR_PRICE************
      put_four_price proc
      call clr

      mov dx,offset price
      call puts

      mov dx,offset four_price
      call puts

      call endl

    
      mov dx,offset goback
      call puts

      call getc

      ; call clr
      
      call four_wheeler

      ret
      put_four_price endp

      ;*********recrd*********
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
      
      call endl
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
      
      call endl
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
      
      
      call endl
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
      
      call endl 
      call endl
      
      
;       mov dx,offset msg11
;       mov ah,9
;       int 21h
      
;       mov dl,b
;       mov ah,2
;       int 21h
      
      ret

      recrd endp


      
      ;********DELETE RECORDS***********
      delt proc
      mov r,'0'
      mov c,'0'
      mov r_left,'4'
      mov c_left,'4'

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
      
      mov dx,offset menu3
      call puts
      
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

      ;**********put_four_menu*********

      put_four_menu proc
      call clr
      mov dx,offset four_menu
      call puts

      mov dx,offset four_menu1
      call puts

      mov dx,offset four_menu2
      call puts

      mov dx,offset four_menu3
      call puts

      mov dx,offset four_menu4
      call puts

      mov dx,offset four_menu5
      call puts

      mov dx,offset choice
      call puts

      ret
      put_four_menu endp

      ;*******endline*******
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