extern printf

section .data
    a dq 1.0
    b dq 0.0
    c dq -4.0 
    root1 dq 0.0
    root2 dq 0.0
    c4 dw 4

    msg db "Las raices son : %f, %f", 10, 0  
    msga db "a es menor a 0",10,0
    msgb db "el cuadrado de b menos 4ac es menor a 1",10,0
   
section .text
    global quadratic
    
quadratic:
    push ebp
    mov ebp, esp
    
    FLD qword[a]   ; cargo valor de a

    ;verificar a > 0
    FTST            ; comparo st0 con 0.0
    FSTSW AX        ; muevo el estado st0 a AX
    SAHF            ; Cargo los flags con os valores de AH
    JBE a_menor_a_0 ; Si es menor a 0.0 jbe
    
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
    FLD ST0         ; Guardo el valor de la raiz al final de la pila
     
    FLD  qword[b]   ; cargo valor de b
    FCHS            ; le cambio el signo a b
    FSUBRP          ; le resto a -b con el resultado de la raiz cuadrada     
    FLD qword[a]    ; cargo valor de a
    FADD qword[a]   ; Sumo a+a (2*a)
    fxch            ; hago un swap de st0 y st1
    FDIVRP          ; hago -b - la raiz dividivo 2*a
    FSTP qword[root1] ; guardo resultado de la primera raiz
    
    FLD  qword[b]   ; cargo valor de b
    FCHS            ; le cambio el signo a b    
    FADD            ; le suma el valor de la raiz que estaba en pila
    FLD qword[a]    ; cargo valor de a
    FADD qword[a]   ; Suma a+a (2*a)
    fxch            ; hago un swap de st0 y st1
    FDIVRP          ; hago -b - la raiz dividivo 2*a
    FSTP qword[root2]

    push dword[root2+4]
    push dword[root2]
    push dword[root1+4]
    push dword[root1]
    push msg                      
    call printf
    add esp, 20

    ;mov eax, 1
    jmp short quit 

a_menor_a_0:
    push msga
    call printf 
    ;mov eax, 0
    jmp quit  

b4ac_menor_1:
    push msgb
    call printf
    ;mov eax, 0
    jmp quit

quit:
    mov esp, ebp
    pop ebp
  
    ret