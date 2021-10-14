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
        push ebp
        mov ebp, esp
        mov ebx, [ebp + 16]     ; address of first element in array
        mov eax, dword[psize]   ; store size of array in ecx
        mov ecx, 8              ; store size of array in ecx
        div ecx
        xor edx, edx        ; counter for loop 

    loopProdScalar:  
        ;#Desarrollar la logica para recorrer el vector y hacer el producto escalar 
        fld qword[ebp + 8]     
        fld qword[ebx + edx * 8]                                      
        fmul
        fld qword[resul]
        fadd
        FSTP qword[resul] ; guardo resultado de la primera raiz    
        inc edx
        cmp eax, edx 
        jg loopProdScalar
        
        mov esp, ebp
        pop ebp
 
    ret