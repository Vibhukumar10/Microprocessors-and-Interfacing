DATA SEGMENT
        ARRAY DB 23H,24H,25H,26H,27H
        KEY DB 26H
        N DB 05H
        POS DW ?
        R DB ?
    DATA ENDS
    CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START : MOV AX,DATA         ;DATA SEGMENT INITIALIZATION
            MOV DS,AX
            LEA SI,ARRAY
            MOV AL,KEY          ;INITIALIZE VARIABLES KEY=>AL, LOW=>BL, HIGH=>DL ,MID=>SI & TEMPREG=>CL
            MOV BL,00H
            MOV DL,N
            DEC DL
    BACK  : CMP BL,DL           ;IF(LOW>=HIGH) GOTO UNSUCCESS(00H) ELSE CONTINUE
            JA UNSUCCESS
            MOV CL,BL
            ADD CL,DL           ;MID=(LOW+HIGH)/2
            SHR CL,01H
            MOV SI,CL
            CMP AL,[SI]
            JZ SUCCESS          ;IF(KEY=A[MID]) THEN KEY ELEMENT FOUND GOTO SUCCESS(0FFH)
            JA SHALF            ;IF(KEY>A[MID]) THEN SEARCH SECOND-HALF ELSE SEARCH FIRST-HALF
    FHALF : MOV DL,CL
            DEC DL              ;HIGH=MID-1
            JMP BACK
    SHALF : MOV BL,CL
            INC BL              ;LOW=MID+1
            JMP BACK

    UNSUCCESS : MOV R,00H
                JMP TERMI
    SUCCESS   : MOV R,0FFH
                MOV POS,SI      ;MOVE KEY ELEMENT POSITION INTO „POS"
                JMP TERMI

    TERMI : INT 03H
    CODE ENDS
END START