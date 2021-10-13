#include <stdio.h>
#include <stdlib.h>

extern void quadratic(float, float, float);

int main(){

    float a,b,c;

    printf("Resolucion de la Cuadratica: ax² + bx + c = 0 \n");

    printf("Ingrese el valor de a: ");
	scanf("%f", &a); 
	printf("Ingrese el valor de b: ");
	scanf("%f", &b); 
	printf("Ingrese el valor de c: ");
	scanf("%f", &c);

    quadratic(a, b, c);

    return 0;
}
