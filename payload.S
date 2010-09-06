.text
	.long 0x09021200
	.long 0x01000080

	.long 0x02000000
	.long 0x00000000

	.long 0xfaceb003
	.long 0xaabbccdd


.globl payload
payload:
	addi 	3, 3, -0x1000
	li	5, 0x1000
	li	4, 1
	rldicr	4, 4, 63, 0
	oris	4, 4, 0x70

.shellcode_copy:
	addi	5, 5, -8
	ldx	6, 3, 5
	stdx	6, 4, 5
	cmpldi	5, 0
	bne	.shellcode_copy
	addi	4, 4, 0x80
	mtctr	4
	bctr


