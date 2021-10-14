extern printf

section .data

puntero dq 15.0,2.0,1.0,5.0
psize   dq $-puntero
resul dq 0.0
formato db "El producto Scalar del Array es : %f", 10,13,0
n dq 4.0

section .text
    global scalarProduct
scalarProduct:
    mov ebp, esp; for correct debugging
    
    push puntero
    mov edx, [n+4]
    push edx
    mov edx, [n]
    push edx
    call producto_rvf
    add esp, 12
    push dword[resul+4]
    push dword[resul] 
    push formato
    call printf
    add esp, 12
    xor eax, eax
    ret
    
    producto_rvf:
        ;#Considerar metodo enter y leave
        push ebp                ; metodo enter
        mov ebp, esp            ; metodo enter
        
        mov ebx, [ebp + 16]     ; direccion del primer elemento del Array
        mov eax, dword[psize]   ; guardo el tamaño del array en ecx
        mov ecx, 8              ; al tamaño del array lo divido por 8 porque son doubles
        div ecx                 ; el resultado lo almaceno en eax
        xor edx, edx            ; establezco un contador para el loop 

    loopProdScalar:  
        ;#Desarrollar la logica para recorrer el vector y hacer el producto escalar 
        fld qword[ebp + 8]      ; cargo en la pila del FPU la variable r
        fld qword[ebx + edx * 8]; tomo un valor del array                                      
        fmul                    ; multiplico la var r * val double del array
        fld qword[resul]        ; cargo la variable resul     
        fadd                    ; le sumo a resul el resultado del producto
        FSTP qword[resul]       ; guardo resultado resul   
        inc edx                 ; incremento el contador
        cmp eax, edx            ; verifico si el ultimo valor del array y loopeo
        jg loopProdScalar
        
        mov esp, ebp            ; metodo leave
        pop ebp                 ; metodo leave
 
    ret
