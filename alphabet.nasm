bits 16
cpu 8086
org 0x7c00
	mov ax, 0x0003 ; ah = 0, al = 3 -- 80x25 16 color text
	int 0x10

	mov ax, 0xb800 ; text mode video RAM address >>4
	mov ds, ax

	mov bx, 0x4b00+'A' ; high byte is bg/fg
	xor cx, cx
loop:
	mov word [ds:ecx], bx
	inc bl
	add cx, 2
	cmp bl, 'Z'
	jle loop

stall:
	jmp stall

times 510-($-$$) db 0
db 0x55
db 0xAA
