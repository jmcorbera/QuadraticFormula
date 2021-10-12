sudo nasm -f elf32 funcionCuadratica.asm -o funcionCuadratica.o
sudo gcc -m32 funcionCuadratica.c funcionCuadratica.o -o main
./main