

data   SEGMENT
        msg1 DB "Binary number: $"
        bff  DB 18,19 dup(0)
        msg2 DB 0Dh,0Ah,"Octal Number is: $"
data   ENDS
 
my_stack   SEGMENT stack
           DW 50 dup(0)
stack_top  LABEL word
my_stack   ENDS

code   SEGMENT
        ASSUME cs:code,ds:data
     
start: MOV AX, data     ;initialize data segment
        MOV DS, AX
MOV AX, my_stack   ;initialize stack segment
        MOV SS, AX
        MOV SP, offset stack_top

        ;Convert from hex string to binary

        MOV AH, 09h     
        LEA DX, msg1
        INT 21h
 
        MOV AH, 0ah     
        LEA DX, bff
        INT 21h

        LEA SI, bff+1   
        MOV BX, 0
        MOV BL, [si]
        INC SI           
        MOV CX, 1       
        MOV AX, 0
R:   MOV DX, 0
        MOV DL, [si]     
        CMP DL, '9'     
        JLE dig
        SUB DL, 7
dig: SUB DL, '0'
        SHL AX, CL       
        ADD AX, DX       
        INC SI           
        DEC BX           
        JNZ R         

        PUSH AX         

        ;Convert binary to decimal string

        MOV AH, 09h    
        LEA DX, msg2
        INT 21h

        POP AX           
        MOV CX, 0       
        MOV BX, 8         
R1: MOV DX, 0
        DIV BX           
        PUSH DX         
        INC CX           
        CMP AX, 0       
        JA R1         
     
        MOV AH, 2      
R2: POP DX           
        ADD DX,'0'       
        INT 21h         
        LOOP R2
       
        MOV AX,4C00h     ;terminate the program
        INT 21h

code   ENDS
        END start