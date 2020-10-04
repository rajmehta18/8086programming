.model small

.data
    msg db 60 dup(?)

.code
main proc
    mov ax,@data       ;pointing to the address of data part
    mov ds,ax
    mov si,offset msg

input:                 ;inputing a string
    mov ah,1           ;inputting a character
    int 21h            ; comparing with enter key
    cmp al,13          ; if it is enter key then jump to display
    je display         
    mov [si],al        ;moving the data in al to si
    cmp [si],32        ; skipping whiter spaces
    je e
    sub [si],32        ; increamenting si by 32 to covert to caps
    inc si
    jmp input  
    e:
    inc si
    jmp input  
    

display: 
    mov [si],'$'            ;adding $ to last  index at the string
    mov di,offset msg       ; loading the string
    mov dl,13               ; printing new line
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h

again: 
    cmp [di],'$'             ;display all the characters till $ is encountered
    je last
    mov dl,[di]
    mov ah,2
    int 21h
    inc di
    jmp again

      
last: 
    mov ah,4ch
    int 21h

main endp

end