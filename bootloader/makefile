all: 
	nasm src/bootloader.asm -f bin -o bin/boot.bin
	nasm src/bootloader2nd.asm -f bin -o bin/boot2.bin
boot.bin: src/bootloader.asm
	nasm src/bootloader.asm -f bin -o bin/boot.bin

boot2.bin: src/bootloader2nd.asm
	nasm src/bootloader2nd.asm -f bin -o bin/boot2.bin
clean:
	rm bin/boot.bin
	rm bin/boot2.bin
