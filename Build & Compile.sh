nasm -f elf64 request_compiler.asm -o request_compiler.o
gcc -no-pie -o request_jit request_jit.c request_compiler.o
