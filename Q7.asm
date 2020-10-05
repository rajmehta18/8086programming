

DIS MACRO STR
MOV AH,09H
LEA DX,STR
INT 21H
ENDM
DATA SEGMENT  
    MSG2 DB "Hexadecimal: $"
    STR1 DB 20 DUP('$')
    STR2 DB 20 DUP('$')
    NO DW 1111
    LINE DB 10,13,'$'
DATA ENDS

CODE SEGMENT   
         ASSUME DS:DATA,CS:CODE
START:
         MOV AX,DATA	;initialize data segment
         MOV DS,AX
         LEA SI,STR1
         MOV AX,NO
         MOV BH,00
         MOV BL,16
      R1:DIV BL
         ADD AH,'0'
         MOV BYTE PTR[SI],AH
         MOV AH,00
         INC SI
         INC BH
         CMP AL,00
         JNE R1

         MOV CL,BH
         LEA SI,STR1
         LEA DI,STR2
         MOV CH,00
         ADD SI,CX
         DEC SI

      R2:MOV AH,BYTE PTR[SI]
         MOV BYTE PTR[DI],AH
         DEC SI
         INC DI
         LOOP R2

         DIS LINE
         DIS MSG2
         DIS STR2
         MOV AH,4CH	;terminate the program
         INT 21H
CODE ENDS
END START