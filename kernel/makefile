all: kernel.bin
	nasm src/kernel.asm -f bin -o bin/kernel.bin
kernel.bin:
	nasm src/kernel.asm -f bin -o bin/kernel.bin
clean:
	rm bin/kernel.bin
