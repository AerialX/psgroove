.text
	.quad 0x902120001000080
	.quad 0xFA0904000000FE01
	.quad 0x200000000000000
	.quad 0xFACEB003AABBCCDD		# Heap page magic tag

.globl payload
payload:
	addi 	%r3, %r3, -0x1000
	li	%r5, 0x1000
	li	%r4, 1
	rldicr	%r4, %r4, 63, 0
	oris	%r4, %r4, 0x70

.copy_shellcode:
	addi	%r5, %r5, -8
	ldx	%r6, %r3, %r5
	stdx	%r6, %r4, %r5
	cmpldi	%r5, 0
	bne	.copy_shellcode
	addi	%r4, %r4, 0x80
	mtctr	%r4
	bctr

	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.long 0

	stdu    %sp, -0xA0(%sp)
	std     %r27, 0x78(%sp)
	std     %r28, 0x80(%sp)
	std     %r29, 0x88(%sp)
	std     %r30, 0x90(%sp)
	std     %r31, 0x98(%sp)
	std     %r0, 0xB0(%sp)
	li      %r31, 1
	rldicr  %r31, %r31, 63,0 	# r31 = 1 << 63 (0x8000000000000000)
	mr      %r3, %r31
	oris    %r3, %r3, 5		# r31 |= (5 << 16)
	ori     %r3, %r3, 0xB3C 	# r3 = 0x8000000000050B3C
	mr      %r4, %r31
	oris    %r4, %r4, 0x70
	ori     %r4, %r4, 0x1AC 	# r4 = 0x80000000007001AC
	li      %r5, 1274
	bl      0x7C01C			# memcpy ?
	
	mr      %r3, %r31
	oris    %r3, %r3, 5
	ori     %r3, %r3, 0xB3C
	addi    %r3, %r3, 0x20  	# r3 = 0x8000000000050B5C
	bl      0xD22D8
	
	mr      %r3, %r31
	oris    %r3, %r3, 5
	ori     %r3, %r3, 0xB3C 	# r3 = 0x8000000000050B3C
	mr      %r4, %r31
	oris    %r4, %r4, 0x2E
	ori     %r4, %r4, -0x4ED8 	# r4 = 0x80000000002DB128
	addi    %r3, %r3, 0x10  	# r3 = 0x8000000000050B4C
	std     %r3, 0x120(%r4)
	mr      %r5, %r31
	oris    %r5, %r5, 0x70		# r5 |= (0x70 << 16)
	ori     %r5, %r5, 0x150 	# r5 = 0x8000000000070150

.patch_lv2:
	lwz     %r3, 0(%r5)     	# r5 = 0x8000000000070150
	cmplwi  %r3, 0          	# Iterate until addr != NULL
	beq     .patch_lv2_end
	lwz     %r4, 4(%r5)
	add     %r3, %r3, %r31
	stw     %r4, 0(%r3)
	addi    %r5, %r5, 8
	b       .patch_lv2

.patch_lv2_end:
	b	.shellcode_start

.foo1:
	stdu    %sp, var_B0(%sp)
	mflr    %r0
	std     %r30, arg_A0(%sp)
	std     %r31, arg_A8(%sp)
	std     %r29, arg_98(%sp)
	std     %r0, arg_C0(%sp)
	li      %r30, 0x7D0
	li      %r31, 0xC8 # '+'
	b       0xAB04

.patch_table: // uint32_t addr, uint32_t patch
	.long 0x490E0
	.long 0xE8820F08

	.long 0x490E4
	.long 0xE87C0020 		# ld r3,32(r28)
	
	.long 0x490E8
	.long 0xF8640000 		# std  r3,0(r4)

	.long 0x4F0A8
	.long 0x48001A9D 		# bl 0x1a9c

	.long 0x2AAFC8
	.long 0x4BDA5B80 		# b 0xffda5b80

	.long 0x4ED18
	.long 0x38800000 		# li r4,0

	.long 0x4ED1C
	.long 0x90830000 		# stw r4,0(r3)

	.long 0x4ED20
	.long 0x4E800020 		# blr

	.long 0x3BA890
	.long 0x1000000 		# .long 0x1000000

	.long 0x505D0
	.long 0x38600001 		# li r3,1

	.long 0x505D4
	.long 0x4E800020 		# blr


.unk_data:
	.long 0
	.long 0x38600001
	.long 0x4E800020
	.long 0x48000278
	.long 0x480001EC
	.quad 0x8000000000050CA8
	.quad 0x800000000033E720
	.quad 0x8000000000051032
	.quad 0x8000000000050B7C
	.quad 0x8000000000050B8C
	.quad 0x8000000000050B9C
	.quad 0x8000000000050BD4
	.quad 0x800000000033E720
	.quad 0x8000000000050C1C
	.quad 0x800000000033E720
	.quad 0x8000000000050C78
	.quad 0x800000000033E720
	.quad 0x8000000000050C84
	.quad 0x800000000033E720
	.quad 0
	.quad 0
	.quad 0
	
.shellcode_start:
	ld      %r27, 0x78(%sp)
	ld      %r28, 0x80(%sp)
	ld      %r29, 0x88(%sp)
	ld      %r30, 0x90(%sp)
	ld      %r31, 0x98(%sp)
	ld      %r0, 0xB0(%sp)
	addi    %sp, %sp, 0xA0
	mtlr    %r0
	li      %r3, 1
	rldicr  %r3, %r3, 63,0
	oris    %r3, %r3, 0x70  # r3 = 0x8000000000700000
	li      %r4, 0
	li      %r5, 0x6E8
	b       0x4D144

// EGG: Repeated X times
.egg:
	nop
	nop
	ld      %r27, 0x78(%sp)
	ld      %r28, 0x80(%sp)
	ld      %r29, 0x88(%sp)
	ld      %r30, 0x90(%sp)
	ld      %r31, 0x98(%sp)
	ld      %r0, 0xB0(%sp)
	addi    %sp, %sp, 0xA0
	mtlr    %r0
	li      %r3, 1
	rldicr  %r3, %r3, 63,0
	oris    %r3, %r3, 0x70  # r3 = 0x8000000000700000
	li      %r4, 0
	li      %r5, 0x6E8
	b       0x4D184

