DATA SEGMENT
    N DB ?
    R DB ?
    DIFF DB ?
    NN DW ?
    RR DW ?
    NR DW ?
    FACT DW 1H
    RES DB 10 DUP ('$')
    MSG1 DB "ENTER R : $"
    MSG2 DB 10,13,"ENTER N : $"
    MSG3 DB 10,13,"nCr : $"
    MSG4 DB 10,13,"N must be greater than R! $" 
    MSG5 DB 10,13,"nPr: $"
DATA ENDS
CODE SEGMENT
    ASSUME DS:DATA,CS:CODE
    START:
        MOV AX,DATA
        MOV DS,AX
        LEA DX,MSG1
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        SUB AL,30H
        MOV R,AL
        LEA DX,MSG2
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        SUB AL,30H
        MOV N,AL
        SUB AL,R
        MOV DIFF,AL
        CMP AL,0
        JL LABEL4
        MOV AX,FACT
        MOV CH,0
        MOV CL,N
        LABEL1: MUL CL
        LOOP LABEL1
        MOV NN,AX
        MOV AX,FACT
        MOV CH,0
        MOV CL,R
        LABEL2: MUL CL
        LOOP LABEL2
        MOV RR,AX
        MOV AX,FACT
        MOV CH,0
        MOV CL,DIFF
        LABEL3: MUL CL
        LOOP LABEL3
        MOV NR,AX
        ;MOV DX,0 
        ;MOV BX,RR
        ;MUL BX
        MOV BX,AX
        MOV DX,0
        MOV AX,NN 
        DIV BX
        LEA SI,RES
        CALL HEX2DEC
        LEA DX,MSG5
        MOV AH,9
        INT 21H
        LEA DX,RES
        MOV AH,9
        INT 21H
        JMP EXIT
        LABEL4: LEA DX,MSG4
        MOV AH,9
        INT 21H
        EXIT: MOV AH,4CH
        INT 21H
    CODE ENDS    

        HEX2DEC PROC NEAR
            MOV CX,0
            MOV BX,10
            LOOP1: MOV DX,0
            DIV BX
            ADD DL,30H
            PUSH DX
            INC CX
            CMP AX,9
            JG LOOP1
            ADD AL,30H
            MOV [SI],AL
            LOOP2: POP AX
            INC SI
            MOV [SI],AL
            LOOP LOOP2
            RET
        HEX2DEC ENDP  
        
END START