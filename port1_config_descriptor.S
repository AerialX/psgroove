.text
.globl payload

payload:	
		.quad 0x902120001000080
		.quad 0xFA0904000000FE01
		.quad 0x200000000000000
		.quad 0xFACEB003AABBCCDD
# ---------------------------------------------------------------------------
		addi	%r3, %r3, -0x1000 # Add	Immediate
		li	%r5, 0x1000	# Load Immediate
		li	%r4, 1		# Load Immediate
		rldicr	%r4, %r4, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r4, %r4, 0x70	# r4=0x800000001C000000

loc_34:					# CODE XREF: ROM:0000000000000044
		addi	%r5, %r5, -8	# Add Immediate
		ldx	%r6, %r3, %r5	# Load Double Word Indexed
		stdx	%r6, %r4, %r5	# Store	Double Word Indexed
		cmpldi	%r5, 0		# Compare Logical Double Word Immediate
		bne	loc_34		# Branch if not	equal
		addi	%r4, %r4, 0x80	# Add Immediate
		mtctr	%r4		# Move to count	register
		bctr			# Branch unconditionally
# ---------------------------------------------------------------------------
		.quad 0
		.quad 0
		.quad 0
		.quad 0
		.quad 0
		.long 0
# ---------------------------------------------------------------------------
		mflr	%r0		# Move from link register
		stdu	%sp, -0xA0(%sp)	# Store	Double Word with Update
		std	%r27, 0x78(%sp)	# Store	Double Word
		std	%r28, 0x80(%sp)	# Store	Double Word
		std	%r29, 0x88(%sp)	# Store	Double Word
		std	%r30, 0x90(%sp)	# Store	Double Word
		std	%r31, 0x98(%sp)	# Store	Double Word
		std	%r0, 0xB0(%sp)	# Store	Double Word
		li	%r31, 1		# Load Immediate
		rldicr	%r31, %r31, 63,0 # r31=0x8000000000000000
		mr	%r3, %r31	# r3=r31
		oris	%r3, %r3, 5	# r3=r3|(5 << 16) -> 0x8000000000050000
		ori	%r3, %r3, 0xB3C	# r3=0x8000000000050B3C
		mr	%r4, %r31	# Move Register
		oris	%r4, %r4, 0x70	# r4=r4|(0x70 << 16) ->	0x8000000000700000
		ori	%r4, %r4, 0x1AC	# r4=0x80000000007001AC
		li	%r5, 0x4FA	# Load Immediate
		bl	0xFF97C01C	# Branch
		mr	%r3, %r31	# Move Register
		oris	%r3, %r3, 5	# OR Immediate Shifted
		ori	%r3, %r3, 0xB3C	# OR Immediate
		addi	%r3, %r3, 0x20	# Add Immediate
		bl	0xFF9D22D8	# Branch
		mr	%r3, %r31	# Move Register
		oris	%r3, %r3, 5	# OR Immediate Shifted
		ori	%r3, %r3, 0xB3C	# OR Immediate
		mr	%r4, %r31	# Move Register
		oris	%r4, %r4, 0x2E	# OR Immediate Shifted
		ori	%r4, %r4, 0xB128 # OR Immediate
		addi	%r3, %r3, 0x10	# Add Immediate
		std	%r3, 0x120(%r4)	# Store	Double Word
		mr	%r5, %r31	# Move Register
		oris	%r5, %r5, 0x70	# r5=0x8000000000700000
		ori	%r5, %r5, 0x150	# r5=0x8000000000700150

apply_patches:				# CODE XREF: ROM:0000000000000124
		lwz	%r3, 0(%r5)	# r3 = *(0x8000000000700150)
		cmplwi	%r3, 0		# r3 ==	0 ?
		beq	loc_128		# Branch if equal
		lwz	%r4, 4(%r5)	# r4 = *(0x8000000000700150+4)
		add	%r3, %r3, %r31	# r3 +=	0x8000000000000000
		stw	%r4, 0(%r3)	# *(r3)	= r4
		addi	%r5, %r5, 8	# r5 = 0x800000001C000158
		b	apply_patches	# r3 = *(0x8000000000700150)
# ---------------------------------------------------------------------------

loc_128:				# CODE XREF: ROM:0000000000000110
		b	unk_6B0		# Branch
# ---------------------------------------------------------------------------
		stdu	%sp, -0xB0(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r30, 0xA0(%sp)	# Store	Double Word
		std	%r31, 0xA8(%sp)	# Store	Double Word
		std	%r29, 0x98(%sp)	# Store	Double Word
		std	%r0, 0xC0(%sp)	# Store	Double Word
		li	%r30, 0x7D0	# Load Immediate
		li	%r31, 0xC8
		b	0xFF90AB04	# Branch
# ---------------------------------------------------------------------------
		.long 0x490E0
		.long 0xE8820F08 
					
		.long 0x490E4
		.long 0xE87C0020
	
		.long 0x490E8
		.long 0xF8640000
	
		.long 0x4F0A8
		.long 0x48001A9D
	
		.long 0x2AAFC8
		.long 0x4BDA5B80
	
		.long 0x4ED18
		.long 0x38800000
	
		.long 0x4ED1C
		.long 0x90830000
	
		.long 0x4ED20
		.long 0x4E800020
	
		.long 0x3BA890
		.long 0x1000000
	
		.long 0x505D0
		.long 0x38600001
	
		.long 0x505D4
		.long 0x4E800020
	
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
	
# ---------------------------------------------------------------------------
		stdu	%sp, -0x80(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r0, 0x90(%sp)	# Store	Double Word
		li	%r4, 0		# Load Immediate
		li	%r5, 1		# Load Immediate
		bl	0x82008		# Branch
		lwz	%r5, 8(%r3)	# Load Word and	Zero
		li	%r3, 0		# Load Immediate
		lis	%r4, -0x5556 # 0xAAAAC0DE # Load Immediate Shifted
		ori	%r4, %r4, 0xC0DE # 0xAAAAC0DE # OR Immediate
		cmplw	%r4, %r5	# Compare Logical Word
		beq	loc_278		# Branch if equal
		li	%r3, -1		# Load Immediate

loc_278:				# CODE XREF: ROM:0000000000000270
		extsw	%r3, %r3	# Extend Sign Word
		ld	%r0, 0x90(%sp)	# Load Double Word
		mtlr	%r0		# Move to link register
		addi	%sp, %sp, 0x80	# Add Immediate
		blr			# Branch unconditionally
# ---------------------------------------------------------------------------
		stdu	%sp, -0x80(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r0, 0x90(%sp)	# Store	Double Word
		li	%r4, 0		# Load Immediate
		bl	0x82034		# Branch
		addi	%r4, %sp, 0x70	# Add Immediate
		li	%r5, 0		# Load Immediate
		std	%r5, 0(%r4)	# Store	Double Word
		li	%r6, 0x21AA	# Load Immediate
		sth	%r6, 0(%r4)	# Store	Half Word
		li	%r6, 0		# Load Immediate
		sth	%r6, 6(%r4)	# Store	Half Word
		li	%r6, 1		# Load Immediate
		rldicr	%r6, %r6, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r6, %r6, 5	# OR Immediate Shifted
		ori	%r6, %r6, 0xBAC	# OR Immediate
		li	%r7, 0		# Load Immediate
		bl	0x81F9C		# Branch
		li	%r3, 0		# Load Immediate
		ld	%r0, 0x90(%sp)	# Load Double Word
		mtlr	%r0		# Move to link register
		addi	%sp, %sp, 0x80	# Add Immediate
		blr			# Branch unconditionally
# ---------------------------------------------------------------------------
		li	%r3, 0		# Load Immediate
		li	%r11, 0xFF	# Load Immediate
# ---------------------------------------------------------------------------
		.long 0x44000022
# ---------------------------------------------------------------------------
		cmpwi	%r3, 0		# Compare Word Immediate
		bne	locret_314	# Branch if not	equal
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 5	# OR Immediate Shifted
		ori	%r3, %r3, 0xBBC	# OR Immediate
		li	%r4, 1		# Load Immediate
		stw	%r4, 0x10(%r3)	# Store	Word

locret_314:				# CODE XREF: ROM:00000000000002F8
		blr			# Branch unconditionally
# ---------------------------------------------------------------------------
		stdu	%sp, -0xD0(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r0, 0xE0(%sp)	# Store	Double Word
		std	%r31, 0xC8(%sp)	# Store	Double Word
		addi	%r4, %sp, 0x70	# Add Immediate
		bl	0x1631AC	# Branch
		li	%r31, 1		# Load Immediate
		rldicr	%r31, %r31, 63,0 # Rotate Left Double Word Immediate then Clear	Right
		oris	%r31, %r31, 5	# OR Immediate Shifted
		ori	%r31, %r31, 0xBBC # OR Immediate
		ld	%r3, 0(%r31)	# Load Double Word
		cmpdi	%r3, 0		# Compare Double Word Immediate
		beq	loc_354		# Branch if equal
		li	%r4, 0x27 # ''' # Load Immediate
		bl	0x11B38		# Branch

loc_354:				# CODE XREF: ROM:0000000000000348
		li	%r4, 0x27 # ''' # Load Immediate
		li	%r3, 0x800	# Load Immediate
		bl	0x116F8		# Branch
		std	%r3, 0(%r31)	# Store	Double Word
		ld	%r4, 0x70(%sp)	# Load Double Word
		bl	0xFFFFC960	# Branch
		ld	%r3, 0x70(%sp)	# Load Double Word
		li	%r4, 0x27 # ''' # Load Immediate
		bl	0x11B38		# Branch
		ld	%r3, 0(%r31)	# Load Double Word
		bl	0xFFFFC988	# Branch
		ld	%r4, 0(%r31)	# Load Double Word
		add	%r3, %r4, %r3	# Add
		std	%r3, 8(%r31)	# Store	Double Word
		li	%r3, 0		# Load Immediate
		ld	%r31, 0xC8(%sp)	# Load Double Word
		ld	%r0, 0xE0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xD0	# Add Immediate
		mtlr	%r0		# Move to link register
		blr			# Branch unconditionally
# ---------------------------------------------------------------------------
		stdu	%sp, -0xA0(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r28, 0x80(%sp)	# Store	Double Word
		std	%r29, 0x88(%sp)	# Store	Double Word
		std	%r31, 0x98(%sp)	# Store	Double Word
		std	%r26, 0x70(%sp)	# Store	Double Word
		std	%r27, 0x78(%sp)	# Store	Double Word
		std	%r0, 0xB0(%sp)	# Store	Double Word
		mr	%r28, %r4	# Move Register
		mr	%r29, %r3	# Move Register
		li	%r31, 1		# Load Immediate
		rldicr	%r31, %r31, 63,0 # Rotate Left Double Word Immediate then Clear	Right
		mr	%r3, %r29	# Move Register
		mr	%r4, %r31	# Move Register
		oris	%r4, %r4, 5	# OR Immediate Shifted
		ori	%r4, %r4, 0x1028 # OR Immediate
		li	%r5, 9		# Load Immediate
		bl	0xFFFFC9B4	# Branch
		cmpldi	%r3, 0		# Compare Logical Double Word Immediate
		bne	loc_424		# Branch if not	equal
		oris	%r31, %r31, 5	# OR Immediate Shifted
		ori	%r31, %r31, 0xBBC # OR Immediate
		lwz	%r3, 0x10(%r31)	# Load Word and	Zero
		cmplwi	%r3, 0		# Compare Logical Word Immediate
		beq	loc_424		# Branch if equal
		ld	%r3, 0(%r31)	# Load Double Word
		cmpldi	%r3, 0		# Compare Logical Double Word Immediate
		beq	loc_424		# Branch if equal
		ld	%r3, 8(%r31)	# Load Double Word
		addi	%r4, %r29, 9	# Add Immediate
		bl	0xFFFFC960	# Branch
		ld	%r29, 0(%r31)	# Load Double Word

loc_424:				# CODE XREF: ROM:00000000000003F0
					# ROM:0000000000000404
		mr	%r3, %r29	# Move Register
		b	0x25A660	# Branch
# ---------------------------------------------------------------------------
		mflr	%r0		# Move from link register
		stdu	%sp, -0x1A0(%sp) # Store Double	Word with Update
		std	%r27, 0x78(%sp)	# Store	Double Word
		std	%r28, 0x80(%sp)	# Store	Double Word
		std	%r29, 0x88(%sp)	# Store	Double Word
		std	%r30, 0x90(%sp)	# Store	Double Word
		std	%r31, 0x98(%sp)	# Store	Double Word
		std	%r0, 0x1B0(%sp)	# Store	Double Word
		mr	%r29, %r3	# Move Register
		mr	%r30, %r4	# Move Register
		li	%r31, 1		# Load Immediate
		rldicr	%r31, %r31, 63,0 # Rotate Left Double Word Immediate then Clear	Right
		ld	%r28, -0x6A00(%rtoc) # Load Double Word
		ld	%r28, 0x68(%r28) # Load	Double Word
		ld	%r28, 0x18(%r28) # Load	Double Word
		ld	%r27, 0xF08(%rtoc) # Load Double Word
		ld	%r9, 0x18(%r29)	# Load Double Word
		lwz	%r9, 0x30(%r9)	# Load Word and	Zero
		rldicl	%r9, %r9, 48,16	# Rotate Left Double Word Immediate then Clear Left
		cmpwi	%r9, 0x29	# Compare Word Immediate
		bne	loc_4D4		# Branch if not	equal
		ld	%r4, 0x10(%r28)	# Load Double Word
		rldicr	%r5, %r4, 24,39	# Rotate Left Double Word Immediate then Clear Right
		rldicl	%r5, %r5, 8,56	# Rotate Left Double Word Immediate then Clear Left
		cmpwi	%r5, 0xFF	# Compare Word Immediate
		beq	loc_4A8		# Branch if equal
		ori	%r4, %r4, 3	# OR Immediate
		std	%r4, 0x10(%r28)	# Store	Double Word
		li	%r3, 6		# Load Immediate
		stw	%r3, 0(%r30)	# Store	Word
		b	loc_4B8		# Branch
# ---------------------------------------------------------------------------

loc_4A8:				# CODE XREF: ROM:0000000000000490
		ori	%r4, %r4, 2	# OR Immediate
		std	%r4, 0x10(%r28)	# Store	Double Word
		li	%r3, 0x2C # ',' # Load Immediate
		stw	%r3, 0(%r30)	# Store	Word

loc_4B8:				# CODE XREF: ROM:00000000000004A4
		lwz	%r5, 4(%r28)	# Load Word and	Zero
		ld	%r4, 8(%r28)	# Load Double Word
		ld	%r3, 0(%r27)	# Load Double Word
		add	%r9, %r3, %r5	# Add
		std	%r9, 0(%r27)	# Store	Double Word
		bl	0x2B68C		# Branch
		b	loc_594		# Branch
# ---------------------------------------------------------------------------

loc_4D4:				# CODE XREF: ROM:000000000000047C
		mr	%r3, %r29	# Move Register
		mr	%r4, %r30	# Move Register
		bl	0xFFFFDE8C	# Branch
		mr	%r29, %r31	# Move Register
		oris	%r29, %r29, 5	# OR Immediate Shifted
		ori	%r29, %r29, 0xBD0 # OR Immediate
		lwz	%r3, 0(%r29)	# Load Word and	Zero
		lwz	%r5, 4(%r28)	# Load Word and	Zero
		add	%r3, %r3, %r5	# Add
		stw	%r3, 0(%r29)	# Store	Word
		ld	%r4, 0x10(%r28)	# Load Double Word
		rldicr	%r5, %r4, 24,39	# Rotate Left Double Word Immediate then Clear Right
		rldicl	%r5, %r5, 8,56	# Rotate Left Double Word Immediate then Clear Left
		cmpwi	%r5, 0xFF	# Compare Word Immediate
		bne	loc_594		# Branch if not	equal
		ld	%r3, 0(%r27)	# Load Double Word
		li	%r4, 0		# Load Immediate
		li	%r6, 0		# Load Immediate

loc_51C:				# CODE XREF: ROM:0000000000000530
		add	%r7, %r3, %r4	# Add
		lwz	%r5, 0(%r7)	# Load Word and	Zero
		xor	%r6, %r6, %r5	# XOR
		addi	%r4, %r4, 4	# Add Immediate
		cmpldi	%r4, 0x400	# Compare Logical Double Word Immediate
		bne	loc_51C		# Branch if not	equal
		lwz	%r3, 0(%r29)	# Load Word and	Zero
		rldicr	%r6, %r6, 32,31	# Rotate Left Double Word Immediate then Clear Right
		or	%r6, %r6, %r3	# OR
		li	%r3, 0		# Load Immediate
		stw	%r3, 0(%r29)	# Store	Word
		mr	%r7, %r31	# Move Register
		oris	%r7, %r7, 5	# OR Immediate Shifted
		ori	%r7, %r7, 0xF70	# OR Immediate

loc_554:				# CODE XREF: ROM:0000000000000568
		ld	%r3, 0(%r7)	# Load Double Word
		cmpldi	%r3, 0		# Compare Logical Double Word Immediate
		beq	loc_594		# Branch if equal
		addi	%r7, %r7, 0x10	# Add Immediate
		cmpld	%r3, %r6	# Compare Logical Double Word
		bne	loc_554		# Branch if not	equal
		ld	%r5, -8(%r7)	# Load Double Word
		ld	%r7, 0(%r27)	# Load Double Word

loc_574:				# CODE XREF: ROM:0000000000000590
		lwz	%r3, 0(%r5)	# Load Word and	Zero
		cmplwi	%r3, 0		# Compare Logical Word Immediate
		beq	loc_594		# Branch if equal
		lwz	%r4, 4(%r5)	# Load Word and	Zero
		add	%r3, %r3, %r7	# Add
		stw	%r4, 0(%r3)	# Store	Word
		addi	%r5, %r5, 8	# Add Immediate
		b	loc_574		# Branch
# ---------------------------------------------------------------------------

loc_594:				# CODE XREF: ROM:00000000000004D0
					# ROM:000000000000050C
		li	%r3, 0		# Load Immediate
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0x1B0(%sp)	# Load Double Word
		addi	%sp, %sp, 0x1A0	# Add Immediate
		mtlr	%r0		# Move to link register
		blr			# Branch unconditionally
# ---------------------------------------------------------------------------
		stdu	%sp, -0xB0(%sp)	# Store	Double Word with Update
		mflr	%r0		# Move from link register
		std	%r30, 0xA0(%sp)	# Store	Double Word
		std	%r31, 0xA8(%sp)	# Store	Double Word
		std	%r29, 0x98(%sp)	# Store	Double Word
		std	%r0, 0xC0(%sp)	# Store	Double Word
		li	%r30, 0xFA0	# Load Immediate
		li	%r31, 0xC8
		b	0xFFFBA174	# Branch
# ---------------------------------------------------------------------------
		.byte 0xA0
		.byte 0x55 # U
		.byte 0x6F # o
		.byte 0x3D # =
		.byte	 0
		.byte 0x2C # ,
		.byte 0xB8 #
		.byte 0xFD #
		.byte 0x80
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 5
		.byte  0xF
		.byte 0xB8 #
		.byte 0x8C
		.byte  0xA
		.byte 0x94 #
		.byte 0x8C #
		.byte	 0
		.byte  0xD
		.byte 0x99 #
		.byte 0xB1 #
		.byte 0x80
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 5
		.byte  0xF
		.byte 0xE0 #
		.byte 0xA2
		.byte 0xBC #
		.byte 0x1A
		.byte 0x56 # V
		.byte	 0
		.byte	 5
		.byte 0x2A # *
		.byte 0xDC #
		.byte 0x80
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 5
		.byte 0x10
		.byte	 4
		.byte 0x6B
		.byte 0x70 # p
		.byte 0x28 # (
		.byte	 2
		.byte	 0
		.byte	 2
		.byte	 0
		.byte 0x17
		.byte 0x80
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 5
		.byte  0xF
		.byte 0xD4 #
		.byte 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte 0
		.byte 0x30 # 0
		.byte 0x53 # S
		.byte 0x54 # T
		.byte 0x38 # 8
		.byte 0x60 # `
		.byte	 0
		.byte 0x82 #
		.byte 0
		.byte 0x5F # _
		.byte 0x3F # ?
		.byte 0xC0 #
		.byte 0x38 # 8
		.byte 0x60 # `
		.byte	 0
		.byte 1
		.byte	 0
		.byte 0x5F # _
		.byte 0x3F # ?
		.byte 0xC4 #
		.byte 0x4E # N
		.byte 0x80 #
		.byte	 0
		.byte 0x20
		.byte 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 2
		.byte 0xED #
		.byte  0xC
		.byte 0x3B
		.byte 0xA0 #
		.byte	 0
		.byte	 1
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte 0
		.byte 0x22 #
		.byte 0xB8 #
		.byte 0x88 #
		.byte 0x5F # _
		.byte 0x74 # t
		.byte 0x6F # o
		.byte 0x6F # o
		.byte 0
		.byte 0x22 #
		.byte 0xB8 #
		.byte 0x8C #
		.byte 0x6C # l
		.byte 0x32 # 2
		.byte 0x2E # .
		.byte 0x78 # x
		.byte 0
		.byte 0x22 #
		.byte 0xB8 #
		.byte 0x90 #
		.byte 0x6D # m
		.byte 0x6C # l
		.byte 0x23 # #
		.byte 0x72 # r
		.byte 0
		.byte 0x22 #
		.byte 0xB8 #
		.byte 0x94 #
		.byte 0x6F # o
		.byte 0x6F # o
		.byte 0x74 # t
		.byte	 0
		.byte 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte  0xD
		.byte 0x68 #
		.byte 0xB8 #
		.byte 0x5F
		.byte 0x74 # t
		.byte 0x6F # o
		.byte 0x6F # o
		.byte	 0
		.byte  0xD
		.byte 0x68 # h
		.byte 0xBC #
		.byte 0x6C
		.byte 0x32 # 2
		.byte 0x2E # .
		.byte 0x78 # x
		.byte	 0
		.byte  0xD
		.byte 0x68 # h
		.byte 0xC0 #
		.byte 0x6D
		.byte 0x6C # l
		.byte 0x23 # #
		.byte 0x72 # r
		.byte	 0
		.byte  0xD
		.byte 0x68 # h
		.byte 0xC4 #
		.byte 0x6F
		.byte 0x6F # o
		.byte 0x74 # t
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte 0x2F
		.byte 0x64 # d
		.byte 0x65 # e
		.byte 0x76 # v
		.byte 0x5F # _
		.byte 0x62 # b
		.byte 0x64 # d
		.byte 0x76 # v
		.byte 0x64
		.byte	 0
		.byte 0x6D # m
		.byte 0x6F # o
		.byte 0x64 # d
		.byte	 0
		.byte	 0
		.byte	 0
		.byte 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
		.byte	 0
unk_6B0:	.byte 0xEB #
		.byte 0x61 # a
		.byte	 0
		.byte 0x78 # x
# ---------------------------------------------------------------------------
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D144	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D184	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D1C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D204	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D244	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D284	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D2C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D304	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D344	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D384	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D3C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D404	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D444	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D484	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D4C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D504	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D544	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D584	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D5C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D604	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D644	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D684	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D6C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D704	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D744	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D784	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D7C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D804	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D844	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D884	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D8C4	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D904	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word
		ld	%r31, 0x98(%sp)	# Load Double Word
		ld	%r0, 0xB0(%sp)	# Load Double Word
		addi	%sp, %sp, 0xA0	# Add Immediate
		mtlr	%r0		# Move to link register
		li	%r3, 1		# Load Immediate
		rldicr	%r3, %r3, 63,0	# Rotate Left Double Word Immediate then Clear Right
		oris	%r3, %r3, 0x70	# OR Immediate Shifted
		li	%r4, 0		# Load Immediate
		li	%r5, 0x6E8	# Load Immediate
		b	0xFF94D944	# Branch
# ---------------------------------------------------------------------------
		nop			# No Operation
		nop			# No Operation
		ld	%r27, 0x78(%sp)	# Load Double Word
		ld	%r28, 0x80(%sp)	# Load Double Word
		ld	%r29, 0x88(%sp)	# Load Double Word
		ld	%r30, 0x90(%sp)	# Load Double Word

