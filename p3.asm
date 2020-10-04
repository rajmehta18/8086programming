DATA SEGMENT  
    ARRAY DB 5,2,3                  ;DEFINING AN ARRAY
    LEN_ARRAY DW $-ARRAY            ; LEN VARIABLE HAS LENGTH OF THE ARRAY
    ANS DB ?
DATA ENDS
CODE SEGMENT
    ASSUME DS:DATA CS:CODE
START:
    MOV AX,DATA                     ;POINTING TO THE DATA OF DATA SEGMENT    
    MOV DS,AX              
    
    LEA SI,ARRAY            ;LOADING EFFECTING ADDRESS OF THE ARRAY
    XOR AL,AL
    MOV ANS,AL               ;INIATIALLY THE ANSWER IS ZERO
    MOV CX,LEN_ARRAY        ; CX HAS THE VALUE OF LENGTH OF THE ARRAY
    
    LOOPING:
        MOV AL,ARRAY[SI]
        XOR ANS,AL
    INC SI
    LOOP LOOPING
    
                            ;PRINTING THE ANS TO THE OUTPUT
    MOV AL,ANS    
    mov DL,ANS              ;MOVING THE DATA TO DL REGISTER 
    ADD DL,48               ; ADDING 48 SO NUMBERS ARE PRINTED
    mov Ah,02H               ; CALLING THE INTERRUPT
    int 21h 
    
    mov ah,4ch              ; SAFE EXIT
    int 21h
    
    
    CODE ENDS 
END START