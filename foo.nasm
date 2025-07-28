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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	times 510-($-$$) db 0
	db 0x55
	db 0xAA
