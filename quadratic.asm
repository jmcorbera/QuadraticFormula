extern printf

section .data
    a dq 0.0
    b dq 0.0
    c dq 0.0 
    root dq 0.0
    sqroot dq 0.0
    c4 dw 4 
    msgx db "Como el discriminate es 0, la ecuacion tiene 1 sola raiz real:", 10, 0
    msgxx db "Como el discriminate es mayor a cero, la ecuacion tiene 2 raicez reales:", 10, 0
    msgx1 db "La raiz X1 es %f", 10, 0 
    msgx2 db "La raiz X2 es %f", 10, 0  
    msga db "El valor de 'a' debe ser mayor a Cero",10,0
    msgb db "Como el discriminate es menor que 0 la ecuacion no tiene resolucion real",10,0
   
section .text
    global quadratic
    
quadratic:
    push ebp
    mov ebp, esp

    fld  dword[ebp + 8]
    fstp  qword[a]
    
    fld  dword[ebp + 12]
    fstp  qword[b]
    
    fld  dword[ebp + 16]
    fstp  qword[c]
    
    fld  qword[a]
    ;verificar a > 0
    FTST            ; comparo st0 con 0.0
    FSTSW AX        ; muevo el estado st0 a AX
    SAHF            ; Cargo los flags con os valores de AH
    JBE a_menor_eq_0; Si es menor o igual 0.0 jbe
    
    FMUL qword[c]   ; multiplico a*c
    FIMUL word[c4]  ; multiplico 4*a*c
    FCHS            ; -4*a*c
    FLD  qword[b]   ; cargo valor de b
    FMUL qword[b]   ; multiplico b*b 
    FADD            ; sumo b*b con -4*a*c
        
    ;verificar b*b -4*a*c >= 0
    FTST            ; comparo st0 con 0.0
    FSTSW AX        ; muevo el estado st0 a AX
    SAHF            ; Cargo los flags con os valores de AH
    JB b4ac_menor_1 ; Si es menor o igual 0.0 jb    
    FSQRT   
    FST  qword[sqroot]; guardo el valor de la discriminante
     
    FTST            ; chequeo si la discriminante da 0
    FSTSW AX        ; muevo el estado st0 a AX
    SAHF            ; Cargo los flags con os valores de AH
    JE msg_one_root ; si es igual 0.0 existe una sola raiz    
    JMP msg_two_root; sino tengo 2 raices posibles
    
msg_one_root:
    push msgx                      
    call printf
    add esp, 4
    call root_one
    jmp quit 
       
msg_two_root:
    push msgxx                      
    call printf
    add esp, 4
    call root_one
    call root_two 
    jmp quit   
    
root_one: 
    FLD1                ; coloco un uno en la pila
    FCHS                ; le cambio el signo
    FMUL qword[sqroot]  ; se lo multiplico a la discriminante
    Call root_x            
    push dword[root+4]
    push dword[root]
    push msgx1                     
    call printf
    add esp, 12   
    ret   
    
root_two:
    FLD qword[sqroot]   ; coloco en la pila el valor de la discriminante
    Call root_x  
    push dword[root+4]
    push dword[root]
    push msgx2                     
    call printf
    add esp, 12
    ret
    
root_x: 
    FLD  qword[b]   ; cargo valor de b
    FCHS            ; hago -b 
    FADD            ; esta suma se define el la llamada anterior b+- discriminante
    FLD qword[a]    ; cargo valor de a
    FADD qword[a]   ; Sumo a+a (2*a)
    fxch            ; hago un swap de st0 y st1
    FDIVRP          ; hago -b +- la raiz dividivo 2*a
    FSTP qword[root] ; guardo resultado de la primera raiz    
    ret   

a_menor_eq_0:
    push msga
    call printf 
    jmp quit  

b4ac_menor_1:
    push msgb
    call printf
    jmp quit
        
quit:
    mov esp, ebp
    pop ebp
        
    ret