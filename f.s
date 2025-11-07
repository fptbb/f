BITS 64
org 0x01000000
hello:
	db 0x7F, "ELF"
	db ";x86_64", 10
	times 4 db 0
	dw 2
	dw 62
	dd 1
	dq _start
	dq phdr - $$
cont2:
	mov AL, 4
	int 0x80
	xchg EAX, EDI
	xchg EAX, EBX
	int 0x80
phdr:
	dd 1
	dw 7
	dw 56
	dw 1
	dw 0
	dw 0
	dw 0
	dq $$ + 1
_start:
	inc EBX
	mov DL, 12
	inc ECX
	jmp cont
	dq filesize - 1
cont:
	shl ECX, 24
	db 0x25
	db 0, 0, 0, 0
	xor dword[RCX], 0x3e252b0a
	jmp cont2
filesize equ $ - $$
