DATA_SEG SEGMENT 
    BCD DB 25H                   
    BIN DB ?                   
DATA_SEG ENDS 
 
CODE_SEG SEGMENT 
    ASSUME CS:CODE_SEG,DS:DATA_SEG 
    START: 
    MOV AX,DATA_SEG 
    MOV DS,AX 
     
    MOV AH,BCD      
    MOV BH,AH 
    AND BH,0FH 
    AND AH,0F0H 
    ROR AH,04  
    MOV CL,10  
    MOV AL,AH 
    AND AX,00FFH 
    MUL CL 
    ADD AL,BH 
    MOV BIN,AL   
    MOV AH,04CH 
    INT 21H 
    CODE_SEG ENDS 
END START
