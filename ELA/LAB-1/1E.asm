MOV AX,0D7h   
MOV BX,0D7h
MOV CX,0D7h
MOV DX,0D7h

SHR AX,2
SAR BX,2
ROL CX,4
RCL DX,1
HLT
