bits 16
cpu 8086
org 0x7c00

	; stack grows down from top of address space
	mov ax, 0x0f00
	mov ss, ax
	mov sp, 0xffff

	; make all segments overlap (except stack; see above)
	xor ax, ax
	; cs is already 0 from BIOS loading us to 0000:7c00
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; TODO
	; read in more sectors
	mov ah, 0x02 ; ah = 0x02
	al ; al = # sectors to read
	ch ; ch = cylinder
	cl ; cl = sector
	dh ; dh = head
	; dl holds boot drive number given by BIOS
	es:bx ; es:bx = address to read to


; does not return
panic:
	mov ah, 0x0e ; ah = 0x0e
	mov bh, 0 ; page number
	mov bl, 0x44 ; fg color
	pop bx ; address of next char
.putchar:
	mov al, [bx]
	inc bx
	cmp al, 0
	je .stall
	int 0x10
	jmp .putchar
.stall:
	jmp .stall


	times 510-($-$$) db 0
	db 0x55
	db 0xAA
