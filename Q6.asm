

data    segment
        num dw ? 
        bcd dw ?
ends

my_stack    segment
            dw50 dup(0)
stack_top   LABEL word
ends

code 	segment
        ASSUME cs:code, ds:data ;initialize the data segment

start:	
        mov ax, 7
        mov bx, 8
        mul bx  
        
        mov cx, 0
        mov bx, 10
        mov num, ax
        
stp1:        
        div bx    
        push dx 
        inc cx
        cmp ax, 10
        jnle stp1
        
        push ax 
        inc cx
        mov ax, 0
stp2:     
        cmp cx, 0
        je exit
        
        dec cx
        pop dx
        shl ax, 4
        add ax, dx 
        jmp stp2
         
exit:           
        mov dx, ax
        mov num, dx
                                                       
        mov ax, 4c00h       ;terminate the program
        int 21h
        
ends     

end start