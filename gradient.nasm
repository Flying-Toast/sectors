bits 16
cpu 8086
org 0x7c00

width equ 320
height equ 200

	mov ax, 0x0013 ; ah = 0x00, al = 0x13 -- 320x200 256 color graphics
	int 0x10 ; set video mode

	mov ax, 0xa000 ; VGA base address >> 4
	mov ds, ax ; data segment starts at VGA memory

	xor di, di ; pixel index
	xor al, al ; pixel color
startline:
	xor bx, bx ; current_x = 0
line:
	mov [di], al ; paint pixel
	inc di ; next index
	inc bx ; current_x++
	cmp bx, width
	jne line
	; current line finished:
	inc al ; next color
	cmp al, height
	jge startline

stall:
	jmp stall

times 510-($-$$) db 0
db 0x55
db 0xAA
