/* JIG payload. Must not exceed 40 bytes */
.text
.globl jigcode

	.long	0x80000000
	.long	0x003dee78

	.long	0x80000000
	.long	0x003dee88

	.long	0x80000000
	.long	0x0033e720
	
jigcode:
	ld	4,-16(3)
	ld	3,-8(3)
.1:
	ld	5,24(3)
	addi	3,3,0x1000
	cmpw	4,5
	bne	.1
	addi	6,3,-0xFE0
	mtctr	6
	bctr

	.long 0x04000000
	

	