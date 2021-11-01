DATA SEGMENT
    ARRAY DB 01H,02H,03H,04H,05H 
    MSG DB 'Enter the key: $'
    MSG1 DB ' Element is found!$'
    MSG2 DB ' Element NOT found!$'  
    KEY DB ?
DATA ENDS

CODE SEGMENT
START:

    ASSUME CS:CODE, DS:DATA 
    MOV AX, DATA
    MOV DS, AX
    
    LEA DX,MSG
    MOV AH,09H
    INT 21H 
             
    MOV AH,01H
    INT 21H
    SUB AL,30H
             
    MOV SI, 0000h
    MOV KEY,AL
    
  NEXT:               
    CMP SI,05H
    JGE NOTFOUND
    MOV AL, ARRAY[SI]
    
    CMP AL,KEY
    JE RESULT
    
    ADD SI,1   
    LOOP NEXT
  NOTFOUND:
    LEA DX,MSG2
    JMP DISP 
    
  RESULT:
    LEA DX,MSG1 
    JMP DISP    
    
  DISP:
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODE ENDS

END START