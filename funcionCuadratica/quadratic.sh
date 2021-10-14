sudo nasm -f elf32 quadratic.asm -o quadratic.o;
sudo gcc -m32 quadratic.c quadratic.o -o execQuadratic;
./execQuadratic;
