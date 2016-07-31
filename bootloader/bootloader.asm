bits 16
org 0x7c00
jmp main
main:
	cli
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	sti
	mov si, msg
	call print
hang:
	jmp hang
print:
	pusha
	mov bp,sp
	cont:
		lodsb
		or al,al
		jz dne
		mov ah,0x0e
		mov bx,0
		int 10h
		jmp cont
	dne:
		mov sp,bp
		popa
		ret
msg db "Hello Word"
times 510- ($-$$) db 0 
dw 0xaa55
