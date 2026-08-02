	.attribute	4, 16
	.attribute	5, "rv32i2p1_b1p0_zba1p0_zbb1p0_zbc1p0_zbkc1p0_zbs1p0"
	.file	"compiler_test.c"
	.text
	.globl	fillInBuf                       # -- Begin function fillInBuf
	.p2align	2
	.type	fillInBuf,@function
fillInBuf:                              # @fillInBuf
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	lui	a0, %hi(.L_MergedGlobals)
	addi	a0, a0, %lo(.L_MergedGlobals)
	lw	a4, 8(a0)
	lw	a3, 12(a0)
	li	a1, 4
	sh	a1, 0(a0)
	addi	a2, a0, 1
	addi	a0, a0, 20
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB0_2
# %bb.1:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB0_2:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	fillInBuf, .Lfunc_end0-fillInBuf
                                        # -- End function
	.globl	getChar                         # -- Begin function getChar
	.p2align	2
	.type	getChar,@function
getChar:                                # @getChar
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	lui	a0, %hi(.L_MergedGlobals)
	lbu	a0, %lo(.L_MergedGlobals+1)(a0)
	lui	s0, %hi(.L_MergedGlobals)
	addi	s0, s0, %lo(.L_MergedGlobals)
	bnez	a0, .LBB1_4
# %bb.1:
	lw	a4, 8(s0)
	lw	a3, 12(s0)
	li	a0, 4
	sb	a0, 0(s0)
	addi	a0, s0, 20
	addi	a2, s0, 1
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB1_3
# %bb.2:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB1_3:
	lui	a1, %hi(.L_MergedGlobals)
	lbu	a0, %lo(.L_MergedGlobals+1)(a1)
	beqz	a0, .LBB1_5
.LBB1_4:
	lbu	a2, 0(s0)
	add	a1, s0, a2
	lbu	a1, 16(a1)
	addi	a0, a0, -1
	addi	a2, a2, 1
	sb	a2, 0(s0)
	sb	a0, 1(s0)
	zext.b	a0, a1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.LBB1_5:
	lbu	a0, %lo(.L_MergedGlobals+3)(a1)
	addi	a2, a0, -255
	seqz	a2, a2
	not	a0, a0
	addi	a2, a2, -1
	sb	a0, %lo(.L_MergedGlobals+3)(a1)
	ori	a1, a2, -39
	zext.b	a0, a1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	getChar, .Lfunc_end1-getChar
                                        # -- End function
	.globl	stuffChar                       # -- Begin function stuffChar
	.p2align	2
	.type	stuffChar,@function
stuffChar:                              # @stuffChar
# %bb.0:
	lui	a1, %hi(.L_MergedGlobals)
	addi	a1, a1, %lo(.L_MergedGlobals)
	lbu	a2, 0(a1)
	lbu	a3, 1(a1)
	addi	a2, a2, -1
	zext.b	a4, a2
	add	a4, a1, a4
	addi	a3, a3, 1
	sb	a2, 0(a1)
	sb	a3, 1(a1)
	sb	a0, 16(a4)
	ret
.Lfunc_end2:
	.size	stuffChar, .Lfunc_end2-stuffChar
                                        # -- End function
	.globl	getOctet                        # -- Begin function getOctet
	.p2align	2
	.type	getOctet,@function
getOctet:                               # @getOctet
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	mv	s0, a0
	lui	a0, %hi(.L_MergedGlobals)
	lbu	a1, %lo(.L_MergedGlobals+1)(a0)
	lui	s1, %hi(.L_MergedGlobals)
	addi	s1, s1, %lo(.L_MergedGlobals)
	bnez	a1, .LBB3_4
# %bb.1:
	lw	a4, 8(s1)
	lw	a3, 12(s1)
	li	a0, 4
	sb	a0, 0(s1)
	addi	a0, s1, 20
	addi	a2, s1, 1
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB3_3
# %bb.2:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB3_3:
	lui	a2, %hi(.L_MergedGlobals)
	lbu	a1, %lo(.L_MergedGlobals+1)(a2)
	beqz	a1, .LBB3_8
.LBB3_4:
	lbu	a2, 0(s1)
	add	a0, s1, a2
	lbu	a0, 16(a0)
	addi	a1, a1, -1
	addi	a2, a2, 1
	sb	a2, 0(s1)
	sb	a1, 1(s1)
	beqz	s0, .LBB3_16
# %bb.5:
	li	a2, 255
	bne	a0, a2, .LBB3_16
# %bb.6:
	zext.b	a0, a1
	beqz	a0, .LBB3_11
# %bb.7:
	lui	a0, %hi(.L_MergedGlobals)
	lbu	a0, %lo(.L_MergedGlobals)(a0)
	j	.LBB3_14
.LBB3_8:
	lbu	a3, %lo(.L_MergedGlobals+3)(a2)
	not	a1, a3
	addi	a4, a3, -255
	li	a0, 255
	sb	a1, %lo(.L_MergedGlobals+3)(a2)
	snez	a1, a4
	bne	a3, a0, .LBB3_10
# %bb.9:
	li	a0, 217
.LBB3_10:
	snez	a2, s0
	and	a1, a2, a1
	beqz	a1, .LBB3_16
.LBB3_11:
	lw	a4, 8(s1)
	lw	a3, 12(s1)
	li	a0, 4
	sb	a0, 0(s1)
	addi	a0, s1, 20
	addi	a2, s1, 1
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB3_13
# %bb.12:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB3_13:
	lui	a2, %hi(.L_MergedGlobals)
	lbu	a1, %lo(.L_MergedGlobals+1)(a2)
	lbu	a0, %lo(.L_MergedGlobals)(a2)
	beqz	a1, .LBB3_17
.LBB3_14:
	add	a2, s1, a0
	lbu	a2, 16(a2)
	addi	a0, a0, 1
	addi	a1, a1, -1
	sb	a0, 0(s1)
	sb	a1, 1(s1)
	bnez	a2, .LBB3_18
# %bb.15:
	li	a0, 255
.LBB3_16:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.LBB3_17:
	lbu	a3, %lo(.L_MergedGlobals+3)(a2)
	addi	a4, a3, -255
	seqz	a4, a4
	not	a3, a3
	addi	a4, a4, -1
	sb	a3, %lo(.L_MergedGlobals+3)(a2)
	ori	a2, a4, -39
.LBB3_18:
	addi	a3, a0, -1
	addi	a4, a0, -2
	zext.b	a0, a3
	zext.b	a3, a4
	add	a5, s1, a0
	add	a3, s1, a3
	li	a0, 255
	addi	a1, a1, 2
	sb	a2, 16(a5)
	sb	a0, 16(a3)
	sb	a4, 0(s1)
	sb	a1, 1(s1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	getOctet, .Lfunc_end3-getOctet
                                        # -- End function
	.globl	getBits                         # -- Begin function getBits
	.p2align	2
	.type	getBits,@function
getBits:                                # @getBits
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	sw	s6, 0(sp)                       # 4-byte Folded Spill
	mv	s0, a0
	lui	s2, %hi(.L_MergedGlobals)
	addi	s2, s2, %lo(.L_MergedGlobals)
	lbu	a2, 4(s2)
	lhu	s5, 6(s2)
	li	a0, 9
	mv	s1, a1
	bltu	s0, a0, .LBB4_3
# %bb.1:
	sll	a0, s5, a2
	addi	s3, s0, -8
	sh	a0, 6(s2)
	mv	a0, s1
	call	getOctet
	lbu	a2, 4(s2)
	lhu	a1, 6(s2)
	li	a3, 8
	or	a0, a1, a0
	sub	a3, a3, a2
	sll	a0, a0, a3
	slli	a1, a0, 16
	andi	a3, s5, -256
	srli	a1, a1, 24
	or	s4, a1, a3
	zext.b	s6, s3
	zext.h	a0, a0
	bltu	a2, s6, .LBB4_4
.LBB4_2:
	sub	a2, a2, s3
	sll	a1, a0, s6
	j	.LBB4_5
.LBB4_3:
	mv	s3, s0
	mv	s4, s5
	zext.b	s6, s0
	zext.h	a0, s5
	bgeu	a2, s6, .LBB4_2
.LBB4_4:
	sll	a0, a0, a2
	sh	a0, 6(s2)
	mv	a0, s1
	call	getOctet
	lhu	a1, 6(s2)
	lbu	a2, 4(s2)
	or	a0, a1, a0
	sub	a1, s6, a2
	sub	a2, a2, s3
	sll	a1, a0, a1
	addi	a2, a2, 8
.LBB4_5:
	li	a0, 16
	sub	a0, a0, s0
	srl	a0, s4, a0
	sb	a2, 4(s2)
	sh	a1, 6(s2)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	lw	s6, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	getBits, .Lfunc_end4-getBits
                                        # -- End function
	.globl	getBits1                        # -- Begin function getBits1
	.p2align	2
	.type	getBits1,@function
getBits1:                               # @getBits1
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	mv	s0, a0
	lui	s1, %hi(.L_MergedGlobals)
	addi	s1, s1, %lo(.L_MergedGlobals)
	lbu	a0, 4(s1)
	lhu	s3, 6(s1)
	li	a1, 9
	bltu	s0, a1, .LBB5_8
# %bb.1:
	lbu	a1, 1(s1)
	sll	a0, s3, a0
	sh	a0, 6(s1)
	bnez	a1, .LBB5_5
# %bb.2:
	lw	a4, 8(s1)
	lw	a3, 12(s1)
	li	a0, 4
	sb	a0, 0(s1)
	addi	a0, s1, 20
	addi	a2, s1, 1
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB5_4
# %bb.3:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB5_4:
	lui	a0, %hi(.L_MergedGlobals)
	lbu	a1, %lo(.L_MergedGlobals+1)(a0)
	beqz	a1, .LBB5_16
.LBB5_5:
	lbu	a0, 0(s1)
	add	a2, s1, a0
	lbu	a2, 16(a2)
	addi	a1, a1, -1
	addi	a0, a0, 1
	sb	a0, 0(s1)
	sb	a1, 1(s1)
.LBB5_6:
	lbu	a0, 4(s1)
	lhu	a1, 6(s1)
	zext.b	a2, a2
	li	a3, 8
	or	a1, a1, a2
	sub	a3, a3, a0
	sll	a1, a1, a3
	andi	a2, s3, -256
	slli	a3, a1, 16
	addi	s4, s0, -8
	srli	a3, a3, 24
	or	s2, a3, a2
	zext.b	s5, s4
	zext.h	a3, a1
	bltu	a0, s5, .LBB5_9
.LBB5_7:
	sub	a2, a0, s4
	sll	a1, a3, s5
	j	.LBB5_15
.LBB5_8:
	mv	s4, s0
	mv	s2, s3
	zext.b	s5, s0
	zext.h	a3, s3
	bgeu	a0, s5, .LBB5_7
.LBB5_9:
	lbu	a1, 1(s1)
	sll	a0, a3, a0
	sh	a0, 6(s1)
	bnez	a1, .LBB5_13
# %bb.10:
	lw	a4, 8(s1)
	lw	a3, 12(s1)
	li	a0, 4
	sb	a0, 0(s1)
	addi	a0, s1, 20
	addi	a2, s1, 1
	li	a1, 252
	jalr	a4
	beqz	a0, .LBB5_12
# %bb.11:
	lui	a1, %hi(.L_MergedGlobals)
	sb	a0, %lo(.L_MergedGlobals+2)(a1)
.LBB5_12:
	lui	a0, %hi(.L_MergedGlobals)
	lbu	a1, %lo(.L_MergedGlobals+1)(a0)
	beqz	a1, .LBB5_17
.LBB5_13:
	lbu	a2, 0(s1)
	add	a0, s1, a2
	lbu	a0, 16(a0)
	addi	a1, a1, -1
	addi	a2, a2, 1
	sb	a2, 0(s1)
	sb	a1, 1(s1)
.LBB5_14:
	lhu	a1, 6(s1)
	lbu	a2, 4(s1)
	zext.b	a0, a0
	or	a0, a1, a0
	sub	a1, s5, a2
	sub	a2, a2, s4
	sll	a1, a0, a1
	addi	a2, a2, 8
.LBB5_15:
	li	a0, 16
	sub	a0, a0, s0
	srl	a0, s2, a0
	sb	a2, 4(s1)
	sh	a1, 6(s1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.LBB5_16:
	lbu	a1, %lo(.L_MergedGlobals+3)(a0)
	addi	a2, a1, -255
	seqz	a2, a2
	not	a1, a1
	addi	a2, a2, -1
	sb	a1, %lo(.L_MergedGlobals+3)(a0)
	ori	a2, a2, -39
	j	.LBB5_6
.LBB5_17:
	lbu	a1, %lo(.L_MergedGlobals+3)(a0)
	addi	a2, a1, -255
	seqz	a2, a2
	not	a1, a1
	addi	a2, a2, -1
	sb	a1, %lo(.L_MergedGlobals+3)(a0)
	ori	a0, a2, -39
	j	.LBB5_14
.Lfunc_end5:
	.size	getBits1, .Lfunc_end5-getBits1
                                        # -- End function
	.globl	getBits2                        # -- Begin function getBits2
	.p2align	2
	.type	getBits2,@function
getBits2:                               # @getBits2
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	mv	s0, a0
	lui	s1, %hi(.L_MergedGlobals)
	addi	s1, s1, %lo(.L_MergedGlobals)
	lbu	a1, 4(s1)
	lhu	s4, 6(s1)
	li	a0, 9
	bltu	s0, a0, .LBB6_3
# %bb.1:
	sll	a0, s4, a1
	addi	s2, s0, -8
	sh	a0, 6(s1)
	li	a0, 1
	call	getOctet
	lbu	a1, 4(s1)
	lhu	a2, 6(s1)
	li	a3, 8
	or	a0, a2, a0
	sub	a3, a3, a1
	sll	a0, a0, a3
	slli	a2, a0, 16
	andi	a3, s4, -256
	srli	a2, a2, 24
	or	s3, a2, a3
	zext.b	s5, s2
	zext.h	a0, a0
	bltu	a1, s5, .LBB6_4
.LBB6_2:
	sub	a2, a1, s2
	sll	a1, a0, s5
	j	.LBB6_5
.LBB6_3:
	mv	s2, s0
	mv	s3, s4
	zext.b	s5, s0
	zext.h	a0, s4
	bgeu	a1, s5, .LBB6_2
.LBB6_4:
	sll	a0, a0, a1
	sh	a0, 6(s1)
	li	a0, 1
	call	getOctet
	lhu	a1, 6(s1)
	lbu	a2, 4(s1)
	or	a0, a1, a0
	sub	a1, s5, a2
	sub	a2, a2, s2
	sll	a1, a0, a1
	addi	a2, a2, 8
.LBB6_5:
	li	a0, 16
	sub	a0, a0, s0
	srl	a0, s3, a0
	sb	a2, 4(s1)
	sh	a1, 6(s1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	getBits2, .Lfunc_end6-getBits2
                                        # -- End function
	.globl	getBit                          # -- Begin function getBit
	.p2align	2
	.type	getBit,@function
getBit:                                 # @getBit
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	lui	s0, %hi(.L_MergedGlobals)
	addi	s0, s0, %lo(.L_MergedGlobals)
	lbu	a2, 4(s0)
	lhu	s1, 6(s0)
	mv	a1, s1
	bnez	a2, .LBB7_2
# %bb.1:
	li	a0, 1
	call	getOctet
	lbu	a2, 4(s0)
	lh	a1, 6(s0)
	or	a1, a1, a0
	addi	a2, a2, 8
.LBB7_2:
	srli	a0, s1, 15
	addi	a2, a2, -1
	slli	a1, a1, 1
	sb	a2, 4(s0)
	sh	a1, 6(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end7:
	.size	getBit, .Lfunc_end7-getBit
                                        # -- End function
	.globl	getExtendTest                   # -- Begin function getExtendTest
	.p2align	2
	.type	getExtendTest,@function
getExtendTest:                          # @getExtendTest
# %bb.0:
	li	a1, 14
	addi	a0, a0, -1
	zext.b	a0, a0
	bltu	a1, a0, .LBB8_2
# %bb.1:
	lui	a1, %hi(.Lswitch.table.huffExtend)
	addi	a1, a1, %lo(.Lswitch.table.huffExtend)
	sh1add	a0, a0, a1
	lhu	a0, 0(a0)
	ret
.LBB8_2:
	li	a0, 0
	ret
.Lfunc_end8:
	.size	getExtendTest, .Lfunc_end8-getExtendTest
                                        # -- End function
	.globl	getExtendOffset                 # -- Begin function getExtendOffset
	.p2align	2
	.type	getExtendOffset,@function
getExtendOffset:                        # @getExtendOffset
# %bb.0:
	li	a1, 14
	addi	a0, a0, -1
	zext.b	a0, a0
	bltu	a1, a0, .LBB9_2
# %bb.1:
	lui	a1, %hi(.Lswitch.table.huffExtend.1)
	addi	a1, a1, %lo(.Lswitch.table.huffExtend.1)
	sh1add	a0, a0, a1
	lhu	a0, 0(a0)
	sext.h	a0, a0
	ret
.LBB9_2:
	li	a0, 0
	ret
.Lfunc_end9:
	.size	getExtendOffset, .Lfunc_end9-getExtendOffset
                                        # -- End function
	.globl	huffExtend                      # -- Begin function huffExtend
	.p2align	2
	.type	huffExtend,@function
huffExtend:                             # @huffExtend
# %bb.0:
	li	a3, 14
	addi	a2, a1, -1
	zext.b	a2, a2
	bltu	a3, a2, .LBB10_3
# %bb.1:
	lui	a3, %hi(.Lswitch.table.huffExtend)
	addi	a3, a3, %lo(.Lswitch.table.huffExtend)
	sh1add	a2, a2, a3
	lhu	a2, 0(a2)
	bgeu	a0, a2, .LBB10_3
# %bb.2:
	lui	a2, %hi(.Lswitch.table.huffExtend.1)
	addi	a2, a2, %lo(.Lswitch.table.huffExtend.1)
	sh1add	a1, a1, a2
	lh	a1, -2(a1)
	add	a0, a1, a0
.LBB10_3:
	sext.h	a0, a0
	ret
.Lfunc_end10:
	.size	huffExtend, .Lfunc_end10-huffExtend
                                        # -- End function
	.globl	huffDecode                      # -- Begin function huffDecode
	.p2align	2
	.type	huffDecode,@function
huffDecode:                             # @huffDecode
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	sw	s7, 12(sp)                      # 4-byte Folded Spill
	mv	s0, a1
	mv	s1, a0
	lui	s2, %hi(.L_MergedGlobals)
	addi	s2, s2, %lo(.L_MergedGlobals)
	lbu	a0, 4(s2)
	lhu	s3, 6(s2)
	mv	s7, s3
	bnez	a0, .LBB11_2
# %bb.1:
	li	a0, 1
	call	getOctet
	lbu	a1, 4(s2)
	lh	a2, 6(s2)
	or	s7, a2, a0
	addi	a0, a1, 8
.LBB11_2:
	srli	s3, s3, 15
	addi	a0, a0, -1
	slli	s7, s7, 1
	sb	a0, 4(s2)
	sh	s7, 6(s2)
	addi	s4, s1, 32
	addi	s1, s1, 64
	lui	s6, 16
	li	s5, 16
	addi	s6, s6, -1
	j	.LBB11_4
.LBB11_3:                               #   in Loop: Header=BB11_4 Depth=1
	addi	a0, a0, -1
	bexti	a2, s7, 15
	slli	s7, a1, 1
	sb	a0, 4(s2)
	sh	s7, 6(s2)
	sh1add	s3, s3, a2
	addi	s1, s1, 1
	addi	s5, s5, -1
	addi	s4, s4, 2
	beqz	s5, .LBB11_8
.LBB11_4:                               # =>This Inner Loop Header: Depth=1
	lhu	a1, 0(s4)
	zext.h	a2, s3
	xor	a3, a1, s6
	sltu	a1, a1, a2
	seqz	a2, a3
	or	a1, a2, a1
	beqz	a1, .LBB11_7
# %bb.5:                                #   in Loop: Header=BB11_4 Depth=1
	zext.b	a2, a0
	mv	a1, s7
	bnez	a2, .LBB11_3
# %bb.6:                                #   in Loop: Header=BB11_4 Depth=1
	li	a0, 1
	call	getOctet
	lbu	a2, 4(s2)
	lh	a1, 6(s2)
	or	a1, a1, a0
	addi	a0, a2, 8
	j	.LBB11_3
.LBB11_7:
	lbu	a0, 0(s1)
	lbu	a1, -32(s4)
	add	a0, a0, s3
	sub	a0, a0, a1
	zext.b	a0, a0
	add	a0, s0, a0
	lbu	a0, 0(a0)
	j	.LBB11_9
.LBB11_8:
	li	a0, 0
.LBB11_9:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	lw	s7, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end11:
	.size	huffDecode, .Lfunc_end11-huffDecode
                                        # -- End function
	.globl	huffCreate                      # -- Begin function huffCreate
	.p2align	2
	.type	huffCreate,@function
huffCreate:                             # @huffCreate
# %bb.0:
	li	a2, 0
	li	a3, 0
	addi	a4, a1, 32
	addi	a1, a1, 64
	addi	a5, a0, 16
	li	a6, -1
	j	.LBB12_2
.LBB12_1:                               #   in Loop: Header=BB12_2 Depth=1
	sh	a3, -32(a4)
	add	a3, a3, a7
	addi	t0, a3, -1
	sh	t0, 0(a4)
	sb	a2, 0(a1)
	add	a2, a7, a2
	slli	a3, a3, 1
	addi	a0, a0, 1
	addi	a4, a4, 2
	addi	a1, a1, 1
	beq	a0, a5, .LBB12_4
.LBB12_2:                               # =>This Inner Loop Header: Depth=1
	lbu	a7, 0(a0)
	bnez	a7, .LBB12_1
# %bb.3:                                #   in Loop: Header=BB12_2 Depth=1
	sh	zero, -32(a4)
	sh	a6, 0(a4)
	sb	zero, 0(a1)
	slli	a3, a3, 1
	addi	a0, a0, 1
	addi	a4, a4, 2
	addi	a1, a1, 1
	bne	a0, a5, .LBB12_2
.LBB12_4:
	ret
.Lfunc_end12:
	.size	huffCreate, .Lfunc_end12-huffCreate
                                        # -- End function
	.globl	getHuffTable                    # -- Begin function getHuffTable
	.p2align	2
	.type	getHuffTable,@function
getHuffTable:                           # @getHuffTable
# %bb.0:
	li	a1, 3
	bltu	a1, a0, .LBB13_2
# %bb.1:
	lui	a1, %hi(.Lswitch.table.readDHTMarker)
	addi	a1, a1, %lo(.Lswitch.table.readDHTMarker)
	sh2add	a0, a0, a1
	lw	a0, 0(a0)
	ret
.LBB13_2:
	li	a0, 0
	ret
.Lfunc_end13:
	.size	getHuffTable, .Lfunc_end13-getHuffTable
                                        # -- End function
	.globl	getHuffVal                      # -- Begin function getHuffVal
	.p2align	2
	.type	getHuffVal,@function
getHuffVal:                             # @getHuffVal
# %bb.0:
	li	a1, 3
	bltu	a1, a0, .LBB14_2
# %bb.1:
	lui	a1, %hi(.Lswitch.table.readDHTMarker.2)
	addi	a1, a1, %lo(.Lswitch.table.readDHTMarker.2)
	sh2add	a0, a0, a1
	lw	a0, 0(a0)
	ret
.LBB14_2:
	li	a0, 0
	ret
.Lfunc_end14:
	.size	getHuffVal, .Lfunc_end14-getHuffVal
                                        # -- End function
	.globl	getMaxHuffCodes                 # -- Begin function getMaxHuffCodes
	.p2align	2
	.type	getMaxHuffCodes,@function
getMaxHuffCodes:                        # @getMaxHuffCodes
# %bb.0:
	li	a1, 2
	bltu	a0, a1, .LBB15_2
# %bb.1:
	li	a0, 255
	ret
.LBB15_2:
	li	a0, 12
	ret
.Lfunc_end15:
	.size	getMaxHuffCodes, .Lfunc_end15-getMaxHuffCodes
                                        # -- End function
	.globl	readDHTMarker                   # -- Begin function readDHTMarker
	.p2align	2
	.type	readDHTMarker,@function
readDHTMarker:                          # @readDHTMarker
# %bb.0:
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	li	a0, 16
	call	getBits1
	li	a1, 2
	bgeu	a0, a1, .LBB16_2
.LBB16_1:
	li	a0, 4
	j	.LBB16_72
.LBB16_2:
	addi	s7, a0, -2
	slli	a0, s7, 16
	beqz	a0, .LBB16_72
# %bb.3:
	lui	s3, %hi(.L_MergedGlobals)
	addi	s3, s3, %lo(.L_MergedGlobals)
	addi	s4, sp, 28
	lbu	a1, 4(s3)
	lhu	s1, 6(s3)
	li	s5, 7
	li	s8, 8
	lui	a0, 16
	addi	s2, a0, -1
	sw	s2, 8(sp)                       # 4-byte Folded Spill
	j	.LBB16_6
.LBB16_4:                               #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 27(sp)
	sh	zero, 28(s11)
	sh	s2, 60(s11)
	sb	zero, 78(s11)
	beqz	a7, .LBB16_70
.LBB16_5:                               #   in Loop: Header=BB16_6 Depth=1
	slli	a3, a3, 1
	add	a4, a3, a7
	addi	a4, a4, -1
	sub	s7, s7, a0
	slli	a0, s7, 16
	sh	a3, 30(s11)
	sh	a4, 62(s11)
	sb	a2, 79(s11)
	beqz	a0, .LBB16_72
.LBB16_6:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB16_18 Depth 2
                                        #     Child Loop BB16_33 Depth 2
	zext.b	a0, a1
	zext.h	s9, s1
	bltu	s5, a0, .LBB16_13
# %bb.7:                                #   in Loop: Header=BB16_6 Depth=1
	lbu	a0, 1(s3)
	sll	a1, s9, a1
	sh	a1, 6(s3)
	bnez	a0, .LBB16_11
# %bb.8:                                #   in Loop: Header=BB16_6 Depth=1
	lw	a4, 8(s3)
	lw	a3, 12(s3)
	li	a0, 4
	sb	a0, 0(s3)
	li	a1, 252
	addi	a0, s3, 20
	addi	a2, s3, 1
	jalr	a4
	lui	a2, %hi(.L_MergedGlobals)
	beqz	a0, .LBB16_10
# %bb.9:                                #   in Loop: Header=BB16_6 Depth=1
	sb	a0, %lo(.L_MergedGlobals+2)(a2)
.LBB16_10:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a0, %lo(.L_MergedGlobals+1)(a2)
	beqz	a0, .LBB16_71
.LBB16_11:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a1, 0(s3)
	add	a2, s3, a1
	lbu	a2, 16(a2)
	addi	a0, a0, -1
	addi	a1, a1, 1
	sb	a1, 0(s3)
	sb	a0, 1(s3)
.LBB16_12:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a1, 4(s3)
	lhu	a0, 6(s3)
	zext.b	a2, a2
	or	a0, a0, a2
	sub	a2, s8, a1
	sll	s9, a0, a2
	srli	a2, s1, 8
	andi	a3, a2, 14
	sb	a1, 4(s3)
	sh	s9, 6(s3)
	li	a0, 3
	beqz	a3, .LBB16_14
	j	.LBB16_72
.LBB16_13:                              #   in Loop: Header=BB16_6 Depth=1
	addi	a1, a1, -8
	slli	s9, s9, 8
	srli	a2, s1, 8
	andi	a3, a2, 14
	sb	a1, 4(s3)
	sh	s9, 6(s3)
	li	a0, 3
	bnez	a3, .LBB16_72
.LBB16_14:                              #   in Loop: Header=BB16_6 Depth=1
	andi	a3, a2, 240
	li	a4, 16
	bltu	a4, a3, .LBB16_72
# %bb.15:                               #   in Loop: Header=BB16_6 Depth=1
	li	s6, 0
	zext.b	a0, a2
	srli	s1, s1, 11
	andi	s1, s1, 2
	andi	a0, a0, 1
	or	s10, s1, a0
	lui	a0, %hi(.Lswitch.table.readDHTMarker)
	addi	a0, a0, %lo(.Lswitch.table.readDHTMarker)
	sh2add	a0, s10, a0
	lui	a2, %hi(.Lswitch.table.readDHTMarker.2)
	addi	a2, a2, %lo(.Lswitch.table.readDHTMarker.2)
	sh2add	a2, s10, a2
	lbu	a3, 5(s3)
	lw	s11, 0(a0)
	lw	s0, 0(a2)
	bset	a0, a3, s10
	sb	a0, 5(s3)
	addi	s2, sp, 12
	j	.LBB16_18
.LBB16_16:                              #   in Loop: Header=BB16_18 Depth=2
	addi	a1, a1, -8
	slli	s1, s1, 8
.LBB16_17:                              #   in Loop: Header=BB16_18 Depth=2
	srli	a0, s9, 8
	sb	a1, 4(s3)
	sh	s1, 6(s3)
	zext.b	a2, a0
	sb	a0, 0(s2)
	addi	s2, s2, 1
	add	s6, a2, s6
	mv	s9, s1
	beq	s2, s4, .LBB16_26
.LBB16_18:                              #   Parent Loop BB16_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a0, a1
	zext.h	s1, s9
	bltu	s5, a0, .LBB16_16
# %bb.19:                               #   in Loop: Header=BB16_18 Depth=2
	lbu	a0, 1(s3)
	sll	a1, s1, a1
	sh	a1, 6(s3)
	bnez	a0, .LBB16_23
# %bb.20:                               #   in Loop: Header=BB16_18 Depth=2
	lw	a4, 8(s3)
	lw	a3, 12(s3)
	li	a0, 4
	sb	a0, 0(s3)
	li	a1, 252
	addi	a0, s3, 20
	addi	a2, s3, 1
	jalr	a4
	lui	a2, %hi(.L_MergedGlobals)
	beqz	a0, .LBB16_22
# %bb.21:                               #   in Loop: Header=BB16_18 Depth=2
	sb	a0, %lo(.L_MergedGlobals+2)(a2)
.LBB16_22:                              #   in Loop: Header=BB16_18 Depth=2
	lbu	a0, %lo(.L_MergedGlobals+1)(a2)
	beqz	a0, .LBB16_25
.LBB16_23:                              #   in Loop: Header=BB16_18 Depth=2
	lbu	a1, 0(s3)
	add	a2, s3, a1
	lbu	a2, 16(a2)
	addi	a0, a0, -1
	addi	a1, a1, 1
	sb	a1, 0(s3)
	sb	a0, 1(s3)
.LBB16_24:                              #   in Loop: Header=BB16_18 Depth=2
	lbu	a1, 4(s3)
	lhu	a0, 6(s3)
	zext.b	a2, a2
	or	a0, a0, a2
	sub	a2, s8, a1
	sll	s1, a0, a2
	j	.LBB16_17
.LBB16_25:                              #   in Loop: Header=BB16_18 Depth=2
	lbu	a0, %lo(.L_MergedGlobals+3)(a2)
	addi	a1, a0, -255
	seqz	a1, a1
	not	a0, a0
	addi	a1, a1, -1
	sb	a0, %lo(.L_MergedGlobals+3)(a2)
	ori	a2, a1, -39
	j	.LBB16_24
.LBB16_26:                              #   in Loop: Header=BB16_6 Depth=1
	li	a0, 2
	bltu	s10, a0, .LBB16_28
# %bb.27:                               #   in Loop: Header=BB16_6 Depth=1
	li	a2, 255
	zext.h	s9, s6
	bgeu	a2, s9, .LBB16_29
	j	.LBB16_72
.LBB16_28:                              #   in Loop: Header=BB16_6 Depth=1
	li	a2, 12
	zext.h	s9, s6
	bltu	a2, s9, .LBB16_72
.LBB16_29:                              #   in Loop: Header=BB16_6 Depth=1
	slli	a0, s6, 16
	beqz	a0, .LBB16_41
# %bb.30:                               #   in Loop: Header=BB16_6 Depth=1
	li	s10, 0
	mv	s2, s1
	j	.LBB16_33
.LBB16_31:                              #   in Loop: Header=BB16_33 Depth=2
	addi	a1, a1, -8
	slli	s1, s1, 8
.LBB16_32:                              #   in Loop: Header=BB16_33 Depth=2
	zext.b	a0, s10
	sb	a1, 4(s3)
	sh	s1, 6(s3)
	srli	a2, s2, 8
	addi	s10, s10, 1
	add	a0, s0, a0
	zext.b	a3, s10
	sb	a2, 0(a0)
	mv	s2, s1
	bgeu	a3, s9, .LBB16_41
.LBB16_33:                              #   Parent Loop BB16_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	zext.b	a0, a1
	zext.h	s1, s2
	bltu	s5, a0, .LBB16_31
# %bb.34:                               #   in Loop: Header=BB16_33 Depth=2
	lbu	a0, 1(s3)
	sll	a1, s1, a1
	sh	a1, 6(s3)
	bnez	a0, .LBB16_38
# %bb.35:                               #   in Loop: Header=BB16_33 Depth=2
	lw	a4, 8(s3)
	lw	a3, 12(s3)
	li	a0, 4
	sb	a0, 0(s3)
	li	a1, 252
	addi	a0, s3, 20
	addi	a2, s3, 1
	jalr	a4
	lui	a2, %hi(.L_MergedGlobals)
	beqz	a0, .LBB16_37
# %bb.36:                               #   in Loop: Header=BB16_33 Depth=2
	sb	a0, %lo(.L_MergedGlobals+2)(a2)
.LBB16_37:                              #   in Loop: Header=BB16_33 Depth=2
	lbu	a0, %lo(.L_MergedGlobals+1)(a2)
	beqz	a0, .LBB16_40
.LBB16_38:                              #   in Loop: Header=BB16_33 Depth=2
	lbu	a1, 0(s3)
	add	a2, s3, a1
	lbu	a2, 16(a2)
	addi	a0, a0, -1
	addi	a1, a1, 1
	sb	a1, 0(s3)
	sb	a0, 1(s3)
.LBB16_39:                              #   in Loop: Header=BB16_33 Depth=2
	lbu	a1, 4(s3)
	lhu	a0, 6(s3)
	zext.b	a2, a2
	or	a0, a0, a2
	sub	a2, s8, a1
	sll	s1, a0, a2
	j	.LBB16_32
.LBB16_40:                              #   in Loop: Header=BB16_33 Depth=2
	lbu	a0, %lo(.L_MergedGlobals+3)(a2)
	addi	a1, a0, -255
	seqz	a1, a1
	not	a0, a0
	addi	a1, a1, -1
	sb	a0, %lo(.L_MergedGlobals+3)(a2)
	ori	a2, a1, -39
	j	.LBB16_39
.LBB16_41:                              #   in Loop: Header=BB16_6 Depth=1
	addi	a0, s6, 17
	zext.h	a2, a0
	zext.h	a3, s7
	bltu	a3, a2, .LBB16_1
# %bb.42:                               #   in Loop: Header=BB16_6 Depth=1
	lbu	a2, 12(sp)
	lbu	a6, 13(sp)
	seqz	a3, a2
	slli	a4, a2, 1
	addi	a3, a3, -1
	and	a2, a3, a2
	and	a3, a3, a4
	addi	a4, a2, -1
	sh	zero, 0(s11)
	sh	a4, 32(s11)
	sb	zero, 64(s11)
	beqz	a6, .LBB16_56
# %bb.43:                               #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a6
	mv	a5, a2
	add	a2, a6, a2
	addi	a6, a3, -1
	lw	s2, 8(sp)                       # 4-byte Folded Reload
	lbu	a7, 14(sp)
	sh	a4, 2(s11)
	sh	a6, 34(s11)
	sb	a5, 65(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_57
.LBB16_44:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 15(sp)
	sh	a4, 4(s11)
	sh	a6, 36(s11)
	sb	a5, 66(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_58
.LBB16_45:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 16(sp)
	sh	a4, 6(s11)
	sh	a6, 38(s11)
	sb	a5, 67(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_59
.LBB16_46:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 17(sp)
	sh	a4, 8(s11)
	sh	a6, 40(s11)
	sb	a5, 68(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_60
.LBB16_47:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 18(sp)
	sh	a4, 10(s11)
	sh	a6, 42(s11)
	sb	a5, 69(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_61
.LBB16_48:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 19(sp)
	sh	a4, 12(s11)
	sh	a6, 44(s11)
	sb	a5, 70(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_62
.LBB16_49:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 20(sp)
	sh	a4, 14(s11)
	sh	a6, 46(s11)
	sb	a5, 71(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_63
.LBB16_50:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 21(sp)
	sh	a4, 16(s11)
	sh	a6, 48(s11)
	sb	a5, 72(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_64
.LBB16_51:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 22(sp)
	sh	a4, 18(s11)
	sh	a6, 50(s11)
	sb	a5, 73(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_65
.LBB16_52:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 23(sp)
	sh	a4, 20(s11)
	sh	a6, 52(s11)
	sb	a5, 74(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_66
.LBB16_53:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 24(sp)
	sh	a4, 22(s11)
	sh	a6, 54(s11)
	sb	a5, 75(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_67
.LBB16_54:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 25(sp)
	sh	a4, 24(s11)
	sh	a6, 56(s11)
	sb	a5, 76(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_68
.LBB16_55:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 26(sp)
	sh	a4, 26(s11)
	sh	a6, 58(s11)
	sb	a5, 77(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_69
	j	.LBB16_4
.LBB16_56:                              #   in Loop: Header=BB16_6 Depth=1
	lw	s2, 8(sp)                       # 4-byte Folded Reload
	lbu	a7, 14(sp)
	sh	zero, 2(s11)
	sh	s2, 34(s11)
	sb	zero, 65(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_44
.LBB16_57:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 15(sp)
	sh	zero, 4(s11)
	sh	s2, 36(s11)
	sb	zero, 66(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_45
.LBB16_58:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 16(sp)
	sh	zero, 6(s11)
	sh	s2, 38(s11)
	sb	zero, 67(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_46
.LBB16_59:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 17(sp)
	sh	zero, 8(s11)
	sh	s2, 40(s11)
	sb	zero, 68(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_47
.LBB16_60:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 18(sp)
	sh	zero, 10(s11)
	sh	s2, 42(s11)
	sb	zero, 69(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_48
.LBB16_61:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 19(sp)
	sh	zero, 12(s11)
	sh	s2, 44(s11)
	sb	zero, 70(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_49
.LBB16_62:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 20(sp)
	sh	zero, 14(s11)
	sh	s2, 46(s11)
	sb	zero, 71(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_50
.LBB16_63:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 21(sp)
	sh	zero, 16(s11)
	sh	s2, 48(s11)
	sb	zero, 72(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_51
.LBB16_64:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 22(sp)
	sh	zero, 18(s11)
	sh	s2, 50(s11)
	sb	zero, 73(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_52
.LBB16_65:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 23(sp)
	sh	zero, 20(s11)
	sh	s2, 52(s11)
	sb	zero, 74(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_53
.LBB16_66:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 24(sp)
	sh	zero, 22(s11)
	sh	s2, 54(s11)
	sb	zero, 75(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_54
.LBB16_67:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 25(sp)
	sh	zero, 24(s11)
	sh	s2, 56(s11)
	sb	zero, 76(s11)
	slli	a3, a3, 1
	bnez	a7, .LBB16_55
.LBB16_68:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a7, 26(sp)
	sh	zero, 26(s11)
	sh	s2, 58(s11)
	sb	zero, 77(s11)
	slli	a3, a3, 1
	beqz	a7, .LBB16_4
.LBB16_69:                              #   in Loop: Header=BB16_6 Depth=1
	mv	a4, a3
	add	a3, a3, a7
	mv	a5, a2
	add	a2, a7, a2
	addi	a6, a3, -1
	lbu	a7, 27(sp)
	sh	a4, 28(s11)
	sh	a6, 60(s11)
	sb	a5, 78(s11)
	bnez	a7, .LBB16_5
.LBB16_70:                              #   in Loop: Header=BB16_6 Depth=1
	sub	s7, s7, a0
	slli	a0, s7, 16
	sh	zero, 30(s11)
	sh	s2, 62(s11)
	sb	zero, 79(s11)
	bnez	a0, .LBB16_6
	j	.LBB16_72
.LBB16_71:                              #   in Loop: Header=BB16_6 Depth=1
	lbu	a0, %lo(.L_MergedGlobals+3)(a2)
	addi	a1, a0, -255
	seqz	a1, a1
	not	a0, a0
	addi	a1, a1, -1
	sb	a0, %lo(.L_MergedGlobals+3)(a2)
	ori	a2, a1, -39
	j	.LBB16_12
.LBB16_72:
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end16:
	.size	readDHTMarker, .Lfunc_end16-readDHTMarker
                                        # -- End function
	.type	ZAG,@object                     # @ZAG
	.section	.rodata,"a",@progbits
	.globl	ZAG
ZAG:
	.ascii	"\000\001\b\020\t\002\003\n\021\030 \031\022\013\004\005\f\023\032!(0)\"\033\024\r\006\007\016\025\034#*1892+$\035\026\017\027\036%,3:;4-&\037'.5<=6/7>?"
	.size	ZAG, 64

	.type	gHuffTab0,@object               # @gHuffTab0
	.bss
	.globl	gHuffTab0
	.p2align	1, 0x0
gHuffTab0:
	.zero	80
	.size	gHuffTab0, 80

	.type	gHuffTab1,@object               # @gHuffTab1
	.globl	gHuffTab1
	.p2align	1, 0x0
gHuffTab1:
	.zero	80
	.size	gHuffTab1, 80

	.type	gHuffTab2,@object               # @gHuffTab2
	.globl	gHuffTab2
	.p2align	1, 0x0
gHuffTab2:
	.zero	80
	.size	gHuffTab2, 80

	.type	gHuffTab3,@object               # @gHuffTab3
	.globl	gHuffTab3
	.p2align	1, 0x0
gHuffTab3:
	.zero	80
	.size	gHuffTab3, 80

	.type	gHuffVal0,@object               # @gHuffVal0
	.globl	gHuffVal0
gHuffVal0:
	.zero	16
	.size	gHuffVal0, 16

	.type	gHuffVal1,@object               # @gHuffVal1
	.globl	gHuffVal1
gHuffVal1:
	.zero	16
	.size	gHuffVal1, 16

	.type	gHuffVal2,@object               # @gHuffVal2
	.globl	gHuffVal2
gHuffVal2:
	.zero	256
	.size	gHuffVal2, 256

	.type	gHuffVal3,@object               # @gHuffVal3
	.globl	gHuffVal3
gHuffVal3:
	.zero	256
	.size	gHuffVal3, 256

	.type	gCoeffBuf,@object               # @gCoeffBuf
	.globl	gCoeffBuf
	.p2align	1, 0x0
gCoeffBuf:
	.zero	128
	.size	gCoeffBuf, 128

	.type	gMCUBufR,@object                # @gMCUBufR
	.globl	gMCUBufR
gMCUBufR:
	.zero	256
	.size	gMCUBufR, 256

	.type	gMCUBufG,@object                # @gMCUBufG
	.globl	gMCUBufG
gMCUBufG:
	.zero	256
	.size	gMCUBufG, 256

	.type	gMCUBufB,@object                # @gMCUBufB
	.globl	gMCUBufB
gMCUBufB:
	.zero	256
	.size	gMCUBufB, 256

	.type	gQuant0,@object                 # @gQuant0
	.globl	gQuant0
	.p2align	1, 0x0
gQuant0:
	.zero	128
	.size	gQuant0, 128

	.type	gQuant1,@object                 # @gQuant1
	.globl	gQuant1
	.p2align	1, 0x0
gQuant1:
	.zero	128
	.size	gQuant1, 128

	.type	gLastDC,@object                 # @gLastDC
	.globl	gLastDC
	.p2align	1, 0x0
gLastDC:
	.zero	6
	.size	gLastDC, 6

	.type	gValidQuantTables,@object       # @gValidQuantTables
	.globl	gValidQuantTables
gValidQuantTables:
	.byte	0                               # 0x0
	.size	gValidQuantTables, 1

	.type	gImageXSize,@object             # @gImageXSize
	.globl	gImageXSize
	.p2align	1, 0x0
gImageXSize:
	.half	0                               # 0x0
	.size	gImageXSize, 2

	.type	gImageYSize,@object             # @gImageYSize
	.globl	gImageYSize
	.p2align	1, 0x0
gImageYSize:
	.half	0                               # 0x0
	.size	gImageYSize, 2

	.type	gCompsInFrame,@object           # @gCompsInFrame
	.globl	gCompsInFrame
gCompsInFrame:
	.byte	0                               # 0x0
	.size	gCompsInFrame, 1

	.type	gCompIdent,@object              # @gCompIdent
	.globl	gCompIdent
gCompIdent:
	.zero	3
	.size	gCompIdent, 3

	.type	gCompHSamp,@object              # @gCompHSamp
	.globl	gCompHSamp
gCompHSamp:
	.zero	3
	.size	gCompHSamp, 3

	.type	gCompVSamp,@object              # @gCompVSamp
	.globl	gCompVSamp
gCompVSamp:
	.zero	3
	.size	gCompVSamp, 3

	.type	gCompQuant,@object              # @gCompQuant
	.globl	gCompQuant
gCompQuant:
	.zero	3
	.size	gCompQuant, 3

	.type	gRestartInterval,@object        # @gRestartInterval
	.globl	gRestartInterval
	.p2align	1, 0x0
gRestartInterval:
	.half	0                               # 0x0
	.size	gRestartInterval, 2

	.type	gNextRestartNum,@object         # @gNextRestartNum
	.globl	gNextRestartNum
	.p2align	1, 0x0
gNextRestartNum:
	.half	0                               # 0x0
	.size	gNextRestartNum, 2

	.type	gRestartsLeft,@object           # @gRestartsLeft
	.globl	gRestartsLeft
	.p2align	1, 0x0
gRestartsLeft:
	.half	0                               # 0x0
	.size	gRestartsLeft, 2

	.type	gCompsInScan,@object            # @gCompsInScan
	.globl	gCompsInScan
gCompsInScan:
	.byte	0                               # 0x0
	.size	gCompsInScan, 1

	.type	gCompList,@object               # @gCompList
	.globl	gCompList
gCompList:
	.zero	3
	.size	gCompList, 3

	.type	gCompDCTab,@object              # @gCompDCTab
	.globl	gCompDCTab
gCompDCTab:
	.zero	3
	.size	gCompDCTab, 3

	.type	gCompACTab,@object              # @gCompACTab
	.globl	gCompACTab
gCompACTab:
	.zero	3
	.size	gCompACTab, 3

	.type	gScanType,@object               # @gScanType
	.globl	gScanType
	.p2align	2, 0x0
gScanType:
	.word	0                               # 0x0
	.size	gScanType, 4

	.type	gMaxBlocksPerMCU,@object        # @gMaxBlocksPerMCU
	.globl	gMaxBlocksPerMCU
gMaxBlocksPerMCU:
	.byte	0                               # 0x0
	.size	gMaxBlocksPerMCU, 1

	.type	gMaxMCUXSize,@object            # @gMaxMCUXSize
	.globl	gMaxMCUXSize
gMaxMCUXSize:
	.byte	0                               # 0x0
	.size	gMaxMCUXSize, 1

	.type	gMaxMCUYSize,@object            # @gMaxMCUYSize
	.globl	gMaxMCUYSize
gMaxMCUYSize:
	.byte	0                               # 0x0
	.size	gMaxMCUYSize, 1

	.type	gMaxMCUSPerRow,@object          # @gMaxMCUSPerRow
	.globl	gMaxMCUSPerRow
	.p2align	1, 0x0
gMaxMCUSPerRow:
	.half	0                               # 0x0
	.size	gMaxMCUSPerRow, 2

	.type	gMaxMCUSPerCol,@object          # @gMaxMCUSPerCol
	.globl	gMaxMCUSPerCol
	.p2align	1, 0x0
gMaxMCUSPerCol:
	.half	0                               # 0x0
	.size	gMaxMCUSPerCol, 2

	.type	gNumMCUSRemainingX,@object      # @gNumMCUSRemainingX
	.globl	gNumMCUSRemainingX
	.p2align	1, 0x0
gNumMCUSRemainingX:
	.half	0                               # 0x0
	.size	gNumMCUSRemainingX, 2

	.type	gNumMCUSRemainingY,@object      # @gNumMCUSRemainingY
	.globl	gNumMCUSRemainingY
	.p2align	1, 0x0
gNumMCUSRemainingY:
	.half	0                               # 0x0
	.size	gNumMCUSRemainingY, 2

	.type	gMCUOrg,@object                 # @gMCUOrg
	.globl	gMCUOrg
gMCUOrg:
	.zero	6
	.size	gMCUOrg, 6

	.type	gReduce,@object                 # @gReduce
	.globl	gReduce
gReduce:
	.byte	0                               # 0x0
	.size	gReduce, 1

	.type	.Lswitch.table.huffExtend,@object # @switch.table.huffExtend
	.section	.rodata,"a",@progbits
	.p2align	1, 0x0
.Lswitch.table.huffExtend:
	.half	1                               # 0x1
	.half	2                               # 0x2
	.half	4                               # 0x4
	.half	8                               # 0x8
	.half	16                              # 0x10
	.half	32                              # 0x20
	.half	64                              # 0x40
	.half	128                             # 0x80
	.half	256                             # 0x100
	.half	512                             # 0x200
	.half	1024                            # 0x400
	.half	2048                            # 0x800
	.half	4096                            # 0x1000
	.half	8192                            # 0x2000
	.half	16384                           # 0x4000
	.size	.Lswitch.table.huffExtend, 30

	.type	.Lswitch.table.huffExtend.1,@object # @switch.table.huffExtend.1
	.p2align	1, 0x0
.Lswitch.table.huffExtend.1:
	.half	65535                           # 0xffff
	.half	65533                           # 0xfffd
	.half	65529                           # 0xfff9
	.half	65521                           # 0xfff1
	.half	65505                           # 0xffe1
	.half	65473                           # 0xffc1
	.half	65409                           # 0xff81
	.half	65281                           # 0xff01
	.half	65025                           # 0xfe01
	.half	64513                           # 0xfc01
	.half	63489                           # 0xf801
	.half	61441                           # 0xf001
	.half	57345                           # 0xe001
	.half	49153                           # 0xc001
	.half	32769                           # 0x8001
	.size	.Lswitch.table.huffExtend.1, 30

	.type	.Lswitch.table.readDHTMarker,@object # @switch.table.readDHTMarker
	.p2align	2, 0x0
.Lswitch.table.readDHTMarker:
	.word	gHuffTab0
	.word	gHuffTab1
	.word	gHuffTab2
	.word	gHuffTab3
	.size	.Lswitch.table.readDHTMarker, 16

	.type	.Lswitch.table.readDHTMarker.2,@object # @switch.table.readDHTMarker.2
	.p2align	2, 0x0
.Lswitch.table.readDHTMarker.2:
	.word	gHuffVal0
	.word	gHuffVal1
	.word	gHuffVal2
	.word	gHuffVal3
	.size	.Lswitch.table.readDHTMarker.2, 16

	.type	.L_MergedGlobals,@object        # @_MergedGlobals
	.local	.L_MergedGlobals
	.comm	.L_MergedGlobals,272,4
	.globl	gInBufOfs
gInBufOfs = .L_MergedGlobals
	.size	gInBufOfs, 1
	.globl	gInBufLeft
gInBufLeft = .L_MergedGlobals+1
	.size	gInBufLeft, 1
	.globl	gCallbackStatus
gCallbackStatus = .L_MergedGlobals+2
	.size	gCallbackStatus, 1
	.globl	gTemFlag
gTemFlag = .L_MergedGlobals+3
	.size	gTemFlag, 1
	.globl	gBitsLeft
gBitsLeft = .L_MergedGlobals+4
	.size	gBitsLeft, 1
	.globl	gValidHuffTables
gValidHuffTables = .L_MergedGlobals+5
	.size	gValidHuffTables, 1
	.globl	gBitBuf
gBitBuf = .L_MergedGlobals+6
	.size	gBitBuf, 2
	.globl	g_pNeedBytesCallback
g_pNeedBytesCallback = .L_MergedGlobals+8
	.size	g_pNeedBytesCallback, 4
	.globl	g_pCallback_data
g_pCallback_data = .L_MergedGlobals+12
	.size	g_pCallback_data, 4
	.globl	gInBuf
gInBuf = .L_MergedGlobals+16
	.size	gInBuf, 256
	.ident	"clang version 24.0.0git (https://github.com/llvm/llvm-project.git 60f965b1f62c0c77bcdb2997ea9bb6603aa0d002)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gHuffTab0
	.addrsig_sym gHuffTab1
	.addrsig_sym gHuffTab2
	.addrsig_sym gHuffTab3
	.addrsig_sym gHuffVal0
	.addrsig_sym gHuffVal1
	.addrsig_sym gHuffVal2
	.addrsig_sym gHuffVal3
	.addrsig_sym .L_MergedGlobals
