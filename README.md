# TP 1 - Organizacion del Computador II

El primer desarrollo consiste en un programa en *C* que ejecuta una función en *assembler* para la arquitectura **IA32**, dicha función calcula las raíces de una función
cuadrática (**ax<sup>2</sup> + bx + c**) a través de la fórmula resolvente. Los coeficientes a, b y c son pasados como parámetros por consola.

El segundo desarrollo consiste en una función en *assembler* **IA-32**, la cual calcula el producto escalar a partir un numero r y un puntero a un vector de números de punto flotante.

## Función Cuadrática

### Ejecución de la función cuadrática


#### Abrir carpeta del programa
```
Abrir la terminal
cd funcionCuadratica
```

#### Ejecutar el programa
```
sh quadratic.sh
```

#### Ingresar los 3 factores
```
Ingresar los valores para las variables a, b, c
```

### Informe

Para el desarrollo de esta función se tomó como base los videos y las diapositivas de las presentaciones de FPU. Se utilizo la IDE de **SASM** para la lógica de la función en *assembler* y la IDE de **Visual Studio Code** para la programación en *C*.
Como primer paso se desarrolló la función en assembler que calcula las raíces de una función cuadrática. Se elaboró la lógica de la función sin asumir ninguna restricción simplemente cargar variables a la FPU y ejecutando las instrucciones necesarias para la lógica pensada. Luego se establecieron las etiquetas de saltos para las diferentes restricciones que pedía el enunciado (**𝑏2 − 4𝑎𝑐 ≥ 0, ∀ 𝑎, 𝑏, 𝑐 ϵ 𝑅** y **𝑎 > 0, 𝑎 ϵ 𝑅**).
Después de tener la función lista se hicieron las modificaciones necesarias para obtener las variables desde una aplicación externa, en nuestro caso *C*.
Una vez obtenida la funcionalidad requerida, se desarrolló en *C* la aplicación que llama a la función, le pasa los parámetros de los coeficientes y muestra en pantallas el resultado de las raícez calculadas.
Por último, para sumarle una mejor presentación al desarrollo se le agregaron a la función distintos mensajes de los resultados obtenidos. A continuación, se muestran algunos de los *printScreen* con los diferentes resultados obtenidos.

Caso de Ecuación con 2 Raíces 

![Ecuación de 2 Raices](https://user-images.githubusercontent.com/9463666/137333277-1d624c78-5a77-4869-b400-1e22126118c7.png)

Caso de Ecuación con 1 raíz

![Ecuación de 1 Raiz](https://user-images.githubusercontent.com/9463666/137334473-32d27196-72fd-4f3c-b510-2d5f5386db6e.png)

Caso de Ecuación con a <= 0

![Ecuación con a <= 0](https://user-images.githubusercontent.com/9463666/137334690-6e735923-e6fb-4074-9baa-2bf867a123e4.png)

Caso de Ecuación conb<sup>2</sup> − 4ac < 0

![Ecuación con b^2 − 4ac < 0](https://user-images.githubusercontent.com/9463666/137335044-52327efa-617c-4c8c-a8bd-d946afe255b5.png)

### Conclusiones

Se trabajó mucho en la prolijidad del código, comentando las líneas más importantes e intentando reutilizar las instrucciones, acotando la cantidad de líneas de código con respecto al prototipo con el cual se empezó a trabajar. Para muchas de estas optimizaciones se requirió una investigación minuciosa de algunas instrucciones del **FPU**. Se utilizo de la bibliografía entregada de **x87** y las presentaciones de **FPU** y **Pila**.

En general no hubo grandes inconvenientes para llevar a cabo el TP, ya que fueron de bastante ayuda los videos explicativos y la documentación con que se contaba. El único inconveniente que se presento fue con el ejecutable .sh que al parecer en la virtual muestra algunos carteles de error pero que no impiden el correcto funcionamiento de la aplicación.


## Producto Escalar

### Ejecución de la función Producto Escalar


#### Abrir carpeta del programa
```
Abrir la terminal
cd funcionScalar
``` 

#### Ejecutar el programa
```
sh scalarProduct.sh
``` 

### Informe

Para el desarrollo de esta función se tomó como base los videos y las diapositivas de las presentaciones de **PILA**, princiaplmente y lo aprendido de la función anterior con **FPU**. Se utilizo la IDE de **SASM** para la lógica de la función en *assembler* y la IDE de **Visual Studio Code** para la programación en *C*.
Se comenzó a desarrollar está funcinalidad con la base de la aplicación *baseVector.asm*. Se trabajo con la etiqueta *producto_rvf* dentro de la cual se llevó a cabo la logica de la funcionalidad del calculo del producto escalar. A diferencia del la aplicación anterior en este caso no existe el pasaje de parametros desde *C*, ya que no se exijia dicha tarea. Las variables se encuentran establecidas en el archivo *assembler*, si el usuario desea modificar los valores del vector los debe realizar directamente en el codigo. La aplicación en *C* nos permite ver el resultado del producto escalar por pantalla.



### Conclusiones

