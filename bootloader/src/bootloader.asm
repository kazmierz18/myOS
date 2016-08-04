%define loc 0x1000
%define ftable 0x2000
%define drive 0x80
%define sec_stage_boot 3
%define ftabsect 2
;1 sector: 1st stage of bootloader
;2: primitive file table for bootloader
;3,4 sector:  second stage of bootloader


[bits 16] ;starting in 16 bit mode
[org 0]

jmp 0x7c0:start	;bootloader needs to start from this addres

start:

	mov ax,cs	
	mov ds,ax
	mov es,ax

	mov al,03h
	mov ah,0	
	int 10h			;video interrupt


	mov si,msg		;set pointer si to the text msg
	call print		;print message pointed by si

	mov ah,0		;read character
	int 16h			;keyboard interrupt

	mov ax,loc		;points where in memory program will be loaded
	mov es,ax		
	mov cl,sec_stage_boot 	;sector of the rest of bootloader
	mov al,1 		;number of sectors to read

	call loadsector
	jmp loc:0000 	;jump to further program


loop:
	jmp $			;infinite loop

loadsector:
	mov bx,0
	mov dl,drive 	;read from this PC drive
	mov dh,0 		;read from first head
	mov ch,0 		;read from first track
	mov ah,2		;read sectors command
	int 0x13		;disk interrupt
	jc error		;jump to error if carry flag set
	ret
error:
	mov si,errormsg		;set pointer si to the text errormsg
	call print
	ret
print:
	mov bp,sp		;save stack pointer
	cont:
		lodsb		;load char to be printed
		or al,al	;check if null
		jz dne		;jump to end if null
		mov ah,0x0e	;Write Character in TTY Mode
		mov bx,0
		int 10h		;video interrupt
		jmp cont	;print next char
dne:
	mov sp,bp		;restore stack pointer
	ret				;return from function

msg db "Booting Successful..",10,13,"Press any key to continue !",10,13,10,13,0
errormsg db "Error loading sector ",10,13,0
times 510 - ($-$$) db 0 ;adds 0 to the end of 512 byte sector
dw 0xaa55  ;adds signature of end of boot sector
