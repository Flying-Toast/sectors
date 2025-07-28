bits 16
cpu 8086
org 0x7c00

	; connect interval timer channel 2 to pc speaker
	in byte al, 0x61
	or al, 0b11 ; set bit 0 and bit 1
	out byte 0x61, al

	; Bits         Usage
	; 7 and 6      channel:
	;                 0 0 = Channel 0
	;                 0 1 = Channel 1
	;                 1 0 = Channel 2
	;                 1 1 = Read-back command (8254 only)
	; 5 and 4      access:
	;                 0 0 = Latch count value command
	;                 0 1 = Access mode: lobyte only
	;                 1 0 = Access mode: hibyte only
	;                 1 1 = Access mode: lobyte/hibyte (store lo first, then hi)
	; 3 to 1       mode:
	;                 0 0 0 = Mode 0 (interrupt on terminal count)
	;                 0 0 1 = Mode 1 (hardware re-triggerable one-shot)
	;                 0 1 0 = Mode 2 (rate generator)
	;                 0 1 1 = Mode 3 (square wave generator)
	;                 1 0 0 = Mode 4 (software triggered strobe)
	;                 1 0 1 = Mode 5 (hardware triggered strobe)
	;                 1 1 0 = Mode 2 (rate generator, same as 010b)
	;                 1 1 1 = Mode 3 (square wave generator, same as 011b)
	; 0            bcd/binary:
	;                 0 = 16-bit binary
	;                 1 = four-digit BCD

        ;            /-access (how to send 16 data to data port from hi/lo byte(s))
	;            | /-mode
	; channel-\  | | /-bcd/binary (ew, always use 0 here wtf)
	;         ccAAmmmB
	mov al, 0b10110110
	out byte 0x43, al ; write command register
	mov ax, 440 ; frequency
	; write frequency to data register, low byte then high byte:
	out byte 0x42, al ; store lo
	mov al, ah
	out byte 0x42, al ; store hi

stall:
	jmp stall

times 510-($-$$) db 0
db 0x55
db 0xAA
