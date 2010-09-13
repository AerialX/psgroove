// Thank you ***** :)

/* Common Symbols */
#define memcpy 0x7c01c
#define memset 0x4d144
#define strcpy 0x4d2f0
#define strncmp 0x4d344
#define alloc 0x62088
#define free 0x624c8

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
#define QUAD_ABS(base, address) .quad 0x8000000000000000 + base + address
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
	mr	%r3, %r31
	LOADI_LABEL2(%r3, return1)
	mr	%r4, %r31
	LOADI_LABEL1(%r4, return1);
	li	%r5, 0x4fa
	bl	ABS1(memcpy)
	mr	%r3, %r31
	LOADI_LABEL2(%r3, return1)
	addi	%r3, %r3, 0x20
	bl	ABS1(0xd22d8)
	mr	%r3, %r31
	LOADI_LABEL2(%r3, return1)
	mr	%r4, %r31
	LOADI_ABS(%r4, 0x2eb128)
	addi	%r3, %r3, 0x10
	std	%r3, 0x120(%r4)
	mr	%r5, %r31
	LOADI_LABEL1(%r5, patch_table)
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
	PATCH_BRANCH(0x2aafc8, b, 0x050b48) // vsh_open_hook_desc
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
vsh_open_hook_desc:
	b	vsh_open_hook

.org 0x1bc
	// looks like a class
	QUAD_ABS2(game_launch_syscall36)
	.quad 0x800000000033E720
	QUAD_ABS2(strMod)
	QUAD_ABS2(port6_match_desc)
	QUAD_ABS2(port6_plugged_desc)
	QUAD_ABS2(port6_unplugged_desc)

port6_match_desc:
	QUAD_ABS2(port6_match)
	.quad 0x800000000033E720
port6_plugged_desc:
	QUAD_ABS2(port6_plugged)
	.quad 0x800000000033E720
port6_unplugged_desc:
	QUAD_ABS2(port6_unplugged)
	.quad 0x800000000033E720
store_flag_desc:
	QUAD_ABS2(store_flag)
	.quad 0x800000000033E720
game_name:
	.quad 0
game_mountpoint:
	.quad 0
flags:
	.long 0
	.long 0

.org 0x244  // Relocated to 0x50BD4, ABS offset is 0x50990
port6_match:
	stdu	%r1, -0x80(%r1)
	mflr	%r0
	std	%r0, 0x90(%r1)
	li	%r4, 0
	li	%r5, 1
	bl	ABS2(0xd2998)
	lwz	%r5, 8(%r3)
	li	%r3, 0
	lis	%r4, 0xaaaa
	ori	%r4, %r4, 0xc0de
	cmplw	%r4, %r5
	beq	loc_278
	li	%r3, -1
loc_278:
	extsw	%r3, %r3
	ld	%r0, 0x90(%r1)
	mtlr	%r0
	addi	%r1, %r1, 0x80
	blr

.org 0x28c
// Relocated to 0x50C1C
port6_plugged:
	stdu	%r1, -0x80(%r1)
	mflr	%r0
	std	%r0, 0x90(%r1)
	li	%r4, 0
	bl	ABS2(0xd29c4)
	addi	%r4, %r1, 0x70
	li	%r5, 0
	std	%r5, 0(%r4)
	li	%r6, 0x21aa
	sth	%r6, 0(%r4)
	li	%r6, 0
	sth	%r6, 6(%r4)
	MEM_BASE(%r6)
	LOADI_LABEL2(%r6, store_flag_desc)
	li	%r7, 0
	bl	ABS2(0xd292c)
	li	%r3, 0
	ld	%r0, 0x90(%r1)
	mtlr	%r0
	addi	%r1, %r1, 0x80
	blr

.org 0x2e8
// Relocated to 0x50C78
port6_unplugged:
	blr	// was li %r3, 0
	li	%r11, 0xff
	sc	1

store_flag: // 0x50c84
	cmpwi	%r3, 0
	bne	store_flag_return
	MEM_BASE(%r3)
	LOADI_LABEL2(%r3, game_name)
	li	%r4, 1
	stw	%r4, 0x10(%r3)  // store 1 in "flags"
store_flag_return:
	blr

game_launch_syscall36:
	stdu	%r1, -0xd0(%r1)
	mflr	%r0
	std	%r0, 0xe0(%r1)
	std	%r31, 0xc8(%r1)
	addi	%r4, %r1, 0x70
	bl	ABS2(0x1b3b3c)
	MEM_BASE(%r31)
	LOADI_LABEL2(%r31, game_name)
	ld	%r3, 0(%r31)
	cmpdi	%r3, 0
	beq	vsh_launch_hook_loop
	li	%r4, 0x27
	bl	ABS2(free)
vsh_launch_hook_loop:
	li	%r4, 0x27
	li	%r3, 0x800
	bl	ABS2(alloc)
	std	%r3, 0(%r31)
	ld	%r4, 0x70(%r1)
	bl	ABS2(strcpy)
	ld	%r3, 0x70(%r1)
	li	%r4, 0x27
	bl	ABS2(free)
	ld	%r3, 0(%r31)
	bl	ABS2(0x4d318)
	ld	%r4, 0(%r31)
	add	%r3, %r4, %r3
	std	%r3, 8(%r31)
	li	%r3, 0
	ld	%r31, 0xc8(%r1)
	ld	%r0, 0xe0(%r1)
	addi	%r1, %r1, 0xd0
	mtlr	%r0
	blr
vsh_open_hook:
	stdu	%r1, -0xa0(%r1)
	mflr	%r0
	std	%r28, 0x80(%r1)
	std	%r29, 0x88(%r1)
	std	%r31, 0x98(%r1)
	std	%r26, 0x70(%r1)
	std	%r27, 0x78(%r1)
	std	%r0, 0xb0(%r1)
	mr	%r28, %r4
	mr	%r29, %r3
	MEM_BASE(%r31)
	mr	%r3, %r29
	mr	%r4, %r31
	LOADI_LABEL2(%r4, strDevBDVD)
	li	%r5, 9
	bl	ABS2(strncmp)
	cmpldi	%r3, 0
	bne	vsh_open_hook_return
	LOADI_LABEL2(%r31, game_name)
	lwz	%r3, 0x10(%r31)
	cmplwi	%r3, 0
	beq	vsh_open_hook_return
	ld	%r3, 0(%r31)
	cmpldi	%r3, 0
	beq	vsh_open_hook_return
	ld	%r3, 8(%r31)
	addi	%r4, %r29, 9
	bl	ABS2(strcpy)
	ld	%r29, 0(%r31)
vsh_open_hook_return:
	mr	%r3, %r29
	b	ABS2(0x2aaff0)
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

strDevBDVD:
	.string "psgroove!"
strMod:
	.string "mod"

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
