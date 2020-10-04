DATA SEGMENT
    ARR DW 1111H,2222H,3333H,4444H,5555H ;defining 16bit array
    SIZE DW 5                 ;size of array
    SE DW 6666H               ;defining search elementt
    IND DW 0001H              ;defining index = 0
    MSG DB "The element if found at index = AL = $"
    MSG2 DB "Element not found $"
DATA ENDS
 
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    
    
    MOV AX, SE                ;store search element in AX
    LEA SI, ARR               ;defining pointer of array in SI
    MOV CX, SIZE              ;defining CX as size of array
           
    REPEAT:                   ;repeat the loop CX times
    MOV BX,[SI]               ;BX is updated to value of array
    CMP AX,BX                 ;compare AX(SE) and BX(array element)
    JZ BREAK                  ;jump if match
    INC SI                    ;increment SI 2 times
    INC SI                    ;because number are of 16bits
    INC IND                   ;increment index
    LOOP REPEAT
                       
    MOV IND,-1                ;no match so index = -1
    LEA DX,MSG2               ;value of msg to DX
    MOV AH,09H                ;printing msg
    INT 21H
    MOV AX,IND                ;index stored in AX
    JMP EXIT
                           
    BREAK:                    ;if match
    
    LEA DX,MSG                ;value of msg to DX
    MOV AH,09H                ;printing msg
    INT 21H
    MOV DX,IND                ;defining Dl with index
    ADD DX,48                 ;add 48 (ascii of 0)
    MOV AH,2H
    INT 21H                   ;index stored in AX
    MOV AX,IND
    
    EXIT:
    MOV AH,4CH                ;interrupt to exit
    INT 21H
CODE ENDS
END START