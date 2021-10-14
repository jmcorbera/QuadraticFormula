nasm -f elf32 scalarProduct.asm -o scalarProduct.o;
gcc -m32 scalarProduct.c scalarProduct.o -o execProduct;
./execProduct;
