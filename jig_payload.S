/* JIG payload. Must not exceed 40 bytes */
.text
	.quad	0x80000000003dee78	/* addr 1 */
	.quad	0x80000000003dee88	/* addr 2 */
	.quad	0x800000000033e720	/* addr 3 */

.globl jigcode
jigcode:
	ld	%r4, -0x10(%r3)
	ld	%r3, -0x8(%r3)
.1:
	ld	%r5, 0x18(%r3)
	addi	%r3, %r3, 0x1000
	cmpw	%r4, %r5
	bne	.1
	addi	%r6, %r3, -0xFE0
	mtctr	%r6
	bctr

	.long 0x04000000

