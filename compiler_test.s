	.file	"compiler_test.c"
	.option nopic
	.attribute arch, "rv32i2p1_b1p0_zba1p0_zbb1p0_zbs1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	decode_unary
	.type	decode_unary, @function
decode_unary:
	mv	a7,a0
	li	a4,0
	li	a3,0
	li	a2,7
	li	a0,0
	add	a5,a7,a3
	sub	a6,a2,a4
	bleu	a1,a3,.L3
.L11:
	lbu	a5,0(a5)
	bext	a5,a5,a6
	beq	a4,a2,.L4
	addi	a4,a4,1
	bne	a5,zero,.L9
.L12:
	addi	a0,a0,1
	add	a5,a7,a3
	sub	a6,a2,a4
	bgtu	a1,a3,.L11
.L3:
	j	.L3
.L4:
	addi	a3,a3,1
	li	a4,0
	beq	a5,zero,.L12
.L9:
	ret
	.size	decode_unary, .-decode_unary
	.align	2
	.globl	decode_unary_fast
	.type	decode_unary_fast, @function
decode_unary_fast:
	clz	a0,a0
	ret
	.size	decode_unary_fast, .-decode_unary_fast
	.align	2
	.globl	decode_elias_gamma
	.type	decode_elias_gamma, @function
decode_elias_gamma:
	li	a5,0
	li	a4,0
	li	a2,7
	li	a7,0
	add	a3,a0,a4
	sub	a6,a2,a5
	bleu	a1,a4,.L16
.L31:
	lbu	a3,0(a3)
	bext	a3,a3,a6
	beq	a5,a2,.L17
	addi	a5,a5,1
	bne	a3,zero,.L30
.L19:
	addi	a7,a7,1
	add	a3,a0,a4
	sub	a6,a2,a5
	bgtu	a1,a4,.L31
.L16:
	j	.L16
.L17:
	addi	a4,a4,1
	li	a5,0
	beq	a3,zero,.L19
.L30:
	beq	a7,zero,.L25
	li	a2,0
	li	a3,1
	li	t4,7
	li	t3,8
.L24:
	sub	t1,t4,a5
	add	a6,a0,a4
	addi	a5,a5,1
	slli	a3,a3,1
	bleu	a1,a4,.L21
	lbu	a6,0(a6)
	bext	a6,a6,t1
	or	a3,a3,a6
	bne	a5,t3,.L22
	addi	a4,a4,1
	li	a5,0
.L22:
	addi	a2,a2,1
	bne	a7,a2,.L24
.L14:
	mv	a0,a3
	ret
.L25:
	li	a3,1
	mv	a0,a3
	ret
.L21:
	addi	a2,a2,1
	beq	a7,a2,.L14
.L23:
	addi	a2,a2,1
	slli	a3,a3,1
	bgtu	a7,a2,.L23
	mv	a0,a3
	ret
	.size	decode_elias_gamma, .-decode_elias_gamma
	.align	2
	.globl	decode_elias_gamma_fast
	.type	decode_elias_gamma_fast, @function
decode_elias_gamma_fast:
	beq	a1,zero,.L49
	li	a3,1
	lbu	a4,0(a0)
	li	a5,0
	beq	a1,a3,.L50
	lbu	a2,1(a0)
	srli	a5,a4,24
	li	a3,2
	slli	a4,a4,8
	or	a4,a4,a2
	beq	a1,a3,.L51
	lbu	a5,2(a0)
	slli	a4,a4,8
	li	a3,3
	or	a4,a4,a5
	li	a5,0
	beq	a1,a3,.L52
	lbu	a3,3(a0)
	slli	a5,a4,8
	li	a2,4
	or	a5,a5,a3
	srli	a3,a4,24
	beq	a1,a2,.L63
	lbu	a2,4(a0)
	srli	a6,a5,24
	slli	a3,a3,8
	slli	a5,a5,8
	li	a4,5
	add	a3,a6,a3
	or	a5,a5,a2
	beq	a1,a4,.L64
	lbu	a2,5(a0)
	srli	a6,a5,24
	slli	a3,a3,8
	slli	a5,a5,8
	li	a4,6
	add	a3,a6,a3
	or	a5,a5,a2
	beq	a1,a4,.L65
	lbu	a2,6(a0)
	srli	a6,a5,24
	slli	a3,a3,8
	slli	a5,a5,8
	li	a4,7
	add	a3,a6,a3
	or	a5,a5,a2
	beq	a1,a4,.L66
	srli	a4,a5,24
	slli	a3,a3,8
	add	a3,a4,a3
	lbu	a1,7(a0)
	clz	a6,a3
	li	a2,63
	sub	a2,a2,a6
	slli	a5,a5,8
	addi	a4,a2,-32
	or	a5,a5,a1
	blt	a4,zero,.L45
	li	a0,-1
	sll	a0,a0,a4
	li	a4,0
.L46:
	andn	a4,a5,a4
	andn	a5,a3,a0
.L56:
	sub	a3,a2,a6
	addi	a2,a3,-32
	srl	a0,a5,a2
	bge	a2,zero,.L59
	li	a2,31
	slli	a5,a5,1
	sub	a2,a2,a3
	srl	a0,a4,a3
	sll	a5,a5,a2
	add	a0,a5,a0
.L59:
	bset	a0,a0,a6
	ret
.L45:
	li	a4,31
	li	a1,-2147483648
	sub	a4,a4,a2
	addi	a1,a1,-1
	srl	a1,a1,a4
	li	a4,-1
	sll	a0,a4,a2
	add	a0,a1,a0
	sll	a4,a4,a2
	j	.L46
.L63:
	clz	a6,a5
	li	a4,31
	bne	a6,a4,.L67
	li	a2,0
	li	a4,0
	li	a5,0
	j	.L56
.L49:
	li	a6,32
	li	a2,-33
	li	a4,0
	li	a5,0
	j	.L56
.L50:
	li	a6,32
	li	a2,-25
	j	.L56
.L51:
	li	a6,32
	li	a2,-17
	j	.L56
.L52:
	li	a6,32
	li	a2,-9
	j	.L56
.L64:
	slli	a4,a3,24
	srli	a6,a5,8
	add	a6,a4,a6
	clz	a6,a6
	li	a2,39
	sub	a2,a2,a6
	addi	a4,a2,-32
	blt	a4,zero,.L43
.L62:
	li	a1,-1
	sll	a1,a1,a4
	li	a4,0
.L44:
	andn	a4,a5,a4
	andn	a5,a3,a1
	j	.L56
.L65:
	slli	a4,a3,16
	srli	a6,a5,16
	add	a6,a4,a6
	clz	a6,a6
	li	a2,47
	sub	a2,a2,a6
	addi	a4,a2,-32
	bge	a4,zero,.L62
.L43:
	li	a4,31
	li	a0,-2147483648
	sub	a4,a4,a2
	addi	a0,a0,-1
	srl	a0,a0,a4
	li	a4,-1
	sll	a1,a4,a2
	add	a1,a0,a1
	sll	a4,a4,a2
	j	.L44
.L66:
	slli	a4,a3,8
	srli	a6,a5,24
	add	a6,a4,a6
	clz	a6,a6
	li	a2,55
	sub	a2,a2,a6
	addi	a4,a2,-32
	bge	a4,zero,.L62
	j	.L43
.L67:
	li	a2,31
	addi	sp,sp,-32
	sub	a2,a2,a6
	li	a0,-1
	li	a1,-1
	sw	a3,12(sp)
	sw	a5,8(sp)
	sw	a6,4(sp)
	sw	a2,0(sp)
	sw	ra,28(sp)
	call	__ashldi3
	lw	a5,8(sp)
	lw	a3,12(sp)
	lw	a2,0(sp)
	lw	a6,4(sp)
	andn	a4,a5,a0
	andn	a5,a3,a1
	sub	a3,a2,a6
	addi	a2,a3,-32
	srl	a0,a5,a2
	bge	a2,zero,.L48
	li	a2,31
	slli	a5,a5,1
	sub	a2,a2,a3
	srl	a0,a4,a3
	sll	a5,a5,a2
	add	a0,a5,a0
.L48:
	lw	ra,28(sp)
	bset	a0,a0,a6
	addi	sp,sp,32
	jr	ra
	.size	decode_elias_gamma_fast, .-decode_elias_gamma_fast
	.align	2
	.globl	decode_elias_delta
	.type	decode_elias_delta, @function
decode_elias_delta:
	li	a5,0
	li	a4,0
	li	a2,7
	li	a7,0
	add	a3,a0,a4
	sub	a6,a2,a5
	bleu	a1,a4,.L70
.L97:
	lbu	a3,0(a3)
	bext	a3,a3,a6
	beq	a5,a2,.L71
	addi	a5,a5,1
	bne	a3,zero,.L96
.L73:
	addi	a7,a7,1
	add	a3,a0,a4
	sub	a6,a2,a5
	bgtu	a1,a4,.L97
.L70:
	j	.L70
.L71:
	addi	a4,a4,1
	li	a5,0
	beq	a3,zero,.L73
.L96:
	beq	a7,zero,.L74
	li	a2,0
	li	a3,1
	li	t4,7
	li	t3,8
.L84:
	add	a6,a0,a4
	sub	t1,t4,a5
	slli	a3,a3,1
	bleu	a1,a4,.L75
	lbu	a6,0(a6)
	addi	a5,a5,1
	bext	a6,a6,t1
	or	a3,a3,a6
	bne	a5,t3,.L76
	addi	a4,a4,1
	li	a5,0
.L76:
	addi	a2,a2,1
	bne	a2,a7,.L84
.L77:
	li	a6,1
	mv	a2,a6
	li	t4,7
	li	t3,8
	bleu	a3,a6,.L74
.L79:
	sub	t1,t4,a5
	add	a7,a0,a4
	addi	a5,a5,1
	slli	a2,a2,1
	bleu	a1,a4,.L81
	lbu	a7,0(a7)
	bext	a7,a7,t1
	or	a2,a2,a7
	bne	a5,t3,.L82
	addi	a4,a4,1
	li	a5,0
.L82:
	addi	a6,a6,1
	bne	a3,a6,.L79
.L68:
	mv	a0,a2
	ret
.L74:
	li	a2,1
	mv	a0,a2
	ret
.L75:
	addi	a2,a2,1
	beq	a7,a2,.L77
.L78:
	addi	a2,a2,1
	slli	a3,a3,1
	bgtu	a7,a2,.L78
	j	.L77
.L81:
	addi	a6,a6,1
	beq	a6,a3,.L68
.L83:
	addi	a6,a6,1
	slli	a2,a2,1
	bltu	a6,a3,.L83
	mv	a0,a2
	ret
	.size	decode_elias_delta, .-decode_elias_delta
	.align	2
	.globl	decode_rice
	.type	decode_rice, @function
decode_rice:
	mv	t3,a0
	beq	a1,zero,.L109
	li	a5,0
	li	a7,0
	li	a4,0
	li	t1,7
	li	a6,8
.L100:
	add	a3,t3,a7
	lbu	a3,0(a3)
	sub	a0,t1,a5
	addi	a5,a5,1
	bext	a3,a3,a0
	beq	a5,a6,.L117
.L101:
	beq	a3,zero,.L116
	addi	a4,a4,1
	bgtu	a1,a7,.L100
.L116:
	sll	a0,a4,a2
.L99:
	beq	a2,zero,.L98
	li	a3,0
	li	a4,0
	li	t5,7
	li	t4,8
.L108:
	sub	t1,t5,a5
	add	a6,t3,a7
	addi	a5,a5,1
	slli	a4,a4,1
	bleu	a1,a7,.L104
	lbu	a6,0(a6)
	bext	a6,a6,t1
	or	a4,a4,a6
	bne	a5,t4,.L105
	addi	a7,a7,1
	li	a5,0
.L105:
	addi	a3,a3,1
	bne	a2,a3,.L108
.L106:
	or	a0,a0,a4
	ret
.L117:
	addi	a7,a7,1
	li	a5,0
	j	.L101
.L98:
	ret
.L109:
	li	a0,0
	li	a5,0
	li	a7,0
	j	.L99
.L104:
	addi	a3,a3,1
	beq	a2,a3,.L106
.L107:
	addi	a3,a3,1
	slli	a4,a4,1
	bgtu	a2,a3,.L107
	or	a0,a0,a4
	ret
	.size	decode_rice, .-decode_rice
	.align	2
	.globl	decode_rice_fast
	.type	decode_rice_fast, @function
decode_rice_fast:
	not	a5,a0
	li	a3,31
	clz	a5,a5
	sub	a3,a3,a1
	sub	a3,a3,a5
	li	a4,-1
	srl	a0,a0,a3
	sll	a4,a4,a1
	sll	a5,a5,a1
	andn	a0,a0,a4
	or	a0,a0,a5
	ret
	.size	decode_rice_fast, .-decode_rice_fast
	.align	2
	.globl	decode_golomb
	.type	decode_golomb, @function
decode_golomb:
	addi	sp,sp,-32
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	mv	s2,a1
	mv	s4,a0
	mv	s3,a2
	beq	a1,zero,.L143
	li	s0,0
	li	s1,0
	li	a1,0
	li	a2,7
	li	a3,8
.L121:
	add	a5,s4,s1
	lbu	a5,0(a5)
	sub	a4,a2,s0
	addi	s0,s0,1
	bext	a5,a5,a4
	beq	s0,a3,.L159
.L122:
	beq	a5,zero,.L157
	addi	a1,a1,1
	bgtu	s2,s1,.L121
.L157:
	mv	a0,s3
	call	__mulsi3
	li	a4,1
	bleu	s3,a4,.L124
.L163:
	li	a5,0
.L125:
	mv	a3,a5
	addi	a5,a5,1
	bset	a4,x0,a5
	bltu	a4,s3,.L125
	sub	t3,a4,s3
	beq	a4,s3,.L160
	beq	a3,zero,.L119
.L128:
	li	a2,0
	li	a5,0
	li	t1,7
	li	a7,8
.L142:
	add	a1,s4,s1
	sub	a6,t1,s0
	slli	a5,a5,1
	bleu	s2,s1,.L136
	lbu	a1,0(a1)
	addi	s0,s0,1
	bext	a1,a1,a6
	or	a5,a5,a1
	bne	s0,a7,.L137
	addi	s1,s1,1
	li	s0,0
.L137:
	addi	a2,a2,1
	bne	a2,a3,.L142
.L138:
	bgtu	t3,a5,.L158
	slli	a5,a5,1
	bleu	s2,s1,.L141
	add	s1,s4,s1
	lbu	a3,0(s1)
	li	a2,7
	sub	a2,a2,s0
	bext	a3,a3,a2
	or	a5,a5,a3
.L141:
	add	a0,s3,a0
	sub	a0,a0,a4
.L158:
	add	a0,a0,a5
.L119:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	addi	sp,sp,32
	jr	ra
.L159:
	addi	s1,s1,1
	li	s0,0
	j	.L122
.L160:
	li	a1,0
	li	a4,0
	li	t1,7
	li	a7,8
	beq	a5,zero,.L119
	sub	a6,t1,s0
	add	a2,s4,s1
	addi	s0,s0,1
	slli	a4,a4,1
	bleu	s2,s1,.L132
.L162:
	lbu	a2,0(a2)
	bext	a2,a2,a6
	or	a4,a4,a2
	beq	s0,a7,.L161
.L133:
	beq	a3,a1,.L134
	sub	a6,t1,s0
	addi	a1,a1,1
	add	a2,s4,s1
	addi	s0,s0,1
	slli	a4,a4,1
	bgtu	s2,s1,.L162
.L132:
	addi	a2,a1,1
	beq	a3,a1,.L134
.L135:
	addi	a2,a2,1
	slli	a4,a4,1
	bgtu	a5,a2,.L135
.L134:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	add	a0,a0,a4
	addi	sp,sp,32
	jr	ra
.L161:
	addi	s1,s1,1
	li	s0,0
	j	.L133
.L143:
	li	a4,1
	li	a0,0
	li	s0,0
	li	s1,0
	bgtu	s3,a4,.L163
.L124:
	mv	t3,a4
	li	a3,-1
	bne	s3,a4,.L128
	j	.L119
.L136:
	addi	a2,a2,1
	beq	a3,a2,.L138
.L139:
	addi	a2,a2,1
	slli	a5,a5,1
	bltu	a2,a3,.L139
	j	.L138
	.size	decode_golomb, .-decode_golomb
	.align	2
	.globl	decode_uleb128
	.type	decode_uleb128, @function
decode_uleb128:
	beq	a1,zero,.L170
	slli	t3,a1,3
	sub	t3,t3,a1
	mv	a6,a0
	li	a5,0
	li	a0,0
	li	a1,0
	li	t4,31
	j	.L169
.L173:
	sll	a2,a3,a2
	sext.b	a4,a4
	li	a3,0
	addi	a5,a5,7
	or	a0,a0,a3
	or	a1,a1,a2
	bge	a4,zero,.L164
.L174:
	addi	a6,a6,1
	beq	t3,a5,.L172
.L169:
	lbu	a4,0(a6)
	addi	a2,a5,-32
	sub	a7,t4,a5
	andi	a3,a4,127
	srli	t1,a3,1
	bge	a2,zero,.L173
	sll	a3,a3,a5
	srl	a2,t1,a7
	sext.b	a4,a4
	addi	a5,a5,7
	or	a0,a0,a3
	or	a1,a1,a2
	blt	a4,zero,.L174
.L164:
	ret
.L172:
	ret
.L170:
	li	a0,0
	ret
	.size	decode_uleb128, .-decode_uleb128
	.align	2
	.globl	decode_sleb128
	.type	decode_sleb128, @function
decode_sleb128:
	beq	a1,zero,.L184
	slli	t3,a1,3
	sub	t3,t3,a1
	mv	a6,a0
	li	a3,0
	li	a0,0
	li	a1,0
	li	t4,31
	j	.L183
.L191:
	sll	a4,a5,a4
	li	a5,0
	or	a5,a0,a5
	or	a4,a1,a4
	sext.b	a2,a7
	addi	a3,a3,7
	mv	a0,a5
	mv	a1,a4
	bge	a2,zero,.L189
.L179:
	addi	a6,a6,1
	beq	a3,t3,.L190
.L183:
	lbu	a7,0(a6)
	addi	a4,a3,-32
	sub	a2,t4,a3
	andi	a5,a7,127
	srli	t1,a5,1
	bge	a4,zero,.L191
	srl	a4,t1,a2
	sll	a5,a5,a3
	or	a5,a0,a5
	or	a4,a1,a4
	sext.b	a2,a7
	addi	a3,a3,7
	mv	a0,a5
	mv	a1,a4
	blt	a2,zero,.L179
.L189:
	li	a2,63
	bgtu	a3,a2,.L175
	andi	a7,a7,64
	beq	a7,zero,.L175
	addi	a1,a3,-32
	bset	a2,x0,a3
	li	a3,0
	blt	a1,zero,.L182
	bset	a3,x0,a1
	li	a2,0
.L182:
	neg	a1,a3
	snez	a3,a2
	sub	a1,a1,a3
	neg	a2,a2
	or	a1,a4,a1
	or	a0,a5,a2
	ret
.L184:
	li	a0,0
.L175:
	ret
.L190:
	ret
	.size	decode_sleb128, .-decode_sleb128
	.align	2
	.globl	decode_zigzag
	.type	decode_zigzag, @function
decode_zigzag:
	andi	a5,a0,1
	neg	a5,a5
	srli	a0,a0,1
	xor	a0,a5,a0
	ret
	.size	decode_zigzag, .-decode_zigzag
	.align	2
	.globl	decode_zigzag_uleb128
	.type	decode_zigzag_uleb128, @function
decode_zigzag_uleb128:
	beq	a1,zero,.L199
	slli	a5,a1,3
	sub	a1,a5,a1
	li	a7,0
	li	a6,0
	li	a3,0
	li	t4,31
	j	.L198
.L201:
	sll	a4,a5,a4
	li	a5,0
	or	a5,a7,a5
	or	a4,a6,a4
	sext.b	a2,a2
	addi	a3,a3,7
	mv	a7,a5
	mv	a6,a4
	bge	a2,zero,.L197
.L202:
	addi	a0,a0,1
	beq	a3,a1,.L197
.L198:
	lbu	a2,0(a0)
	addi	a4,a3,-32
	sub	t1,t4,a3
	andi	a5,a2,127
	srli	t3,a5,1
	bge	a4,zero,.L201
	sll	a5,a5,a3
	srl	a4,t3,t1
	or	a5,a7,a5
	or	a4,a6,a4
	sext.b	a2,a2
	addi	a3,a3,7
	mv	a7,a5
	mv	a6,a4
	blt	a2,zero,.L202
.L197:
	andi	a1,a5,1
	slli	a3,a4,31
	srli	a5,a5,1
	add	a5,a3,a5
	srli	a4,a4,1
	neg	a0,a1
	xor	a1,a0,a4
	xor	a0,a0,a5
	ret
.L199:
	li	a0,0
	ret
	.size	decode_zigzag_uleb128, .-decode_zigzag_uleb128
	.align	2
	.globl	decode_rle
	.type	decode_rle, @function
decode_rle:
	li	a5,1
	bleu	a1,a5,.L209
	andi	a1,a1,-2
	mv	a6,a0
	add	a7,a0,a1
	li	a0,0
.L205:
	bleu	a3,a0,.L215
	lbu	a4,0(a6)
	beq	a4,zero,.L206
	lbu	a1,1(a6)
	add	a4,a4,a0
.L207:
	addi	a0,a0,1
	add	a5,a2,a0
	sb	a1,-1(a5)
	beq	a0,a4,.L206
	bne	a3,a0,.L207
.L206:
	addi	a6,a6,2
	bne	a6,a7,.L205
	ret
.L215:
	ret
.L209:
	li	a0,0
	ret
	.size	decode_rle, .-decode_rle
	.align	2
	.globl	decode_delta
	.type	decode_delta, @function
decode_delta:
	beq	a2,zero,.L216
	lw	a5,0(a0)
	li	a4,1
	sw	a5,0(a1)
	beq	a2,a4,.L216
	sh2add	a2,a2,a0
	addi	a1,a1,4
	addi	a0,a0,4
.L218:
	lw	a4,0(a0)
	addi	a0,a0,4
	addi	a1,a1,4
	add	a5,a5,a4
	sw	a5,-4(a1)
	bne	a0,a2,.L218
.L216:
	ret
	.size	decode_delta, .-decode_delta
	.align	2
	.globl	decode_bitpacked
	.type	decode_bitpacked, @function
decode_bitpacked:
	beq	a4,zero,.L223
	sh2add	t6,a4,a3
	beq	a2,zero,.L225
	li	a6,0
	li	t1,0
	li	t5,7
	li	t4,8
.L229:
	li	a4,0
	li	a5,0
.L231:
	add	a7,a0,t1
	sub	t3,t5,a6
	slli	a5,a5,1
	bgeu	t1,a1,.L226
	lbu	a7,0(a7)
	addi	a6,a6,1
	bext	a7,a7,t3
	or	a5,a5,a7
	bne	a6,t4,.L227
	addi	t1,t1,1
	li	a6,0
.L227:
	addi	a4,a4,1
	bne	a2,a4,.L231
.L232:
	sw	a5,0(a3)
	addi	a3,a3,4
	bne	t6,a3,.L229
	ret
.L223:
	ret
.L225:
	sw	zero,0(a3)
	addi	a5,a3,4
	beq	a5,t6,.L223
	sw	zero,4(a3)
	addi	a3,a3,8
	bne	t6,a3,.L225
	ret
.L226:
	addi	a4,a4,1
	beq	a2,a4,.L232
.L228:
	addi	a4,a4,1
	slli	a5,a5,1
	bgtu	a2,a4,.L228
	sw	a5,0(a3)
	addi	a3,a3,4
	bne	t6,a3,.L229
	ret
	.size	decode_bitpacked, .-decode_bitpacked
	.align	2
	.globl	decode_bitpacked_fast
	.type	decode_bitpacked_fast, @function
decode_bitpacked_fast:
	beq	a4,zero,.L277
	addi	sp,sp,-16
	sw	s0,12(sp)
	li	s0,-2147483648
	sh2add	t6,a4,a3
	addi	s0,s0,-1
	li	a6,0
	li	a5,0
	li	a4,0
	li	t1,0
	li	t4,56
	li	t2,31
	li	t0,-1
.L271:
	bgeu	a6,a2,.L247
	bgtu	a6,t4,.L247
.L267:
	bleu	a1,t1,.L247
	add	a7,a0,t1
	lbu	a7,0(a7)
	srli	t5,a5,24
	slli	a4,a4,8
	slli	a5,a5,8
	addi	t3,a6,8
	or	a5,a7,a5
	add	a4,t5,a4
	addi	a7,t1,1
	bgtu	t3,t4,.L260
	bleu	a1,a7,.L260
	add	a7,a0,a7
	lbu	t5,0(a7)
	slli	a4,a4,8
	srli	a7,a5,24
	addi	t3,a6,16
	slli	a5,a5,8
	add	a4,a7,a4
	or	a5,t5,a5
	addi	a7,t1,2
	bgtu	t3,t4,.L260
	bleu	a1,a7,.L260
	add	a7,a0,a7
	lbu	t5,0(a7)
	slli	a4,a4,8
	srli	a7,a5,24
	addi	t3,a6,24
	slli	a5,a5,8
	add	a4,a7,a4
	or	a5,t5,a5
	addi	a7,t1,3
	bgtu	t3,t4,.L260
	bleu	a1,a7,.L260
	add	a7,a0,a7
	lbu	t5,0(a7)
	slli	a4,a4,8
	srli	a7,a5,24
	addi	t3,a6,32
	slli	a5,a5,8
	add	a4,a7,a4
	or	a5,t5,a5
	addi	a7,t1,4
	bgtu	t3,t4,.L260
	bleu	a1,a7,.L260
	add	a7,a0,a7
	lbu	t3,0(a7)
	slli	a7,a4,8
	srli	a4,a5,24
	add	a7,a4,a7
	slli	a5,a5,8
	addi	t5,a6,40
	or	a5,t3,a5
	mv	a4,a7
	addi	t3,t1,5
	bgtu	t5,t4,.L258
	bleu	a1,t3,.L258
	add	t3,a0,t3
	lbu	t5,0(t3)
	slli	a7,a7,8
	srli	a4,a5,24
	addi	t3,a6,48
	slli	a5,a5,8
	add	a4,a4,a7
	or	a5,t5,a5
	addi	a7,t1,6
	bgtu	t3,t4,.L260
	bleu	a1,a7,.L260
	add	a7,a0,a7
	lbu	t3,0(a7)
	slli	a4,a4,8
	srli	a7,a5,24
	addi	a6,a6,56
	slli	a5,a5,8
	add	a4,a7,a4
	or	a5,t3,a5
	addi	a7,t1,7
	bne	a6,t4,.L263
	bleu	a1,a7,.L263
	add	a7,a0,a7
	lbu	a7,0(a7)
	srli	a6,a5,24
	slli	a4,a4,8
	slli	a5,a5,8
	add	a4,a6,a4
	addi	t1,t1,8
	or	a5,a7,a5
	li	a6,64
.L247:
	sub	a6,a6,a2
	addi	a7,a6,-32
	srl	t3,a4,a7
	bge	a7,zero,.L265
	sub	t3,t2,a6
	slli	t5,a4,1
	sll	t5,t5,t3
	srl	t3,a5,a6
	add	t3,t5,t3
.L265:
	mv	t5,t3
	beq	a6,zero,.L281
	blt	a7,zero,.L269
	sll	a7,t0,a7
	li	t5,0
.L270:
	sw	t3,0(a3)
	addi	a3,a3,4
	andn	a5,a5,t5
	andn	a4,a4,a7
	bne	t6,a3,.L271
.L244:
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
.L281:
	sw	t5,0(a3)
	addi	a3,a3,4
	beq	a3,t6,.L244
.L282:
	li	a5,0
	li	a4,0
	bne	a2,zero,.L267
	li	t5,0
	sw	t5,0(a3)
	addi	a3,a3,4
	bne	a3,t6,.L282
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
.L269:
	sub	t5,t2,a6
	srl	t5,s0,t5
	sll	a7,t0,a6
	add	a7,t5,a7
	sll	t5,t0,a6
	j	.L270
.L260:
	mv	a6,t3
	mv	t1,a7
	j	.L247
.L258:
	mv	a6,t5
	mv	t1,t3
	j	.L247
.L263:
	mv	t1,a7
	j	.L247
.L277:
	ret
	.size	decode_bitpacked_fast, .-decode_bitpacked_fast
	.align	2
	.globl	decode_fibonacci
	.type	decode_fibonacci, @function
decode_fibonacci:
	mv	t5,a0
	li	a2,0
	li	a7,0
	li	a3,0
	li	a0,0
	li	t1,2
	li	a6,1
	li	t3,7
	j	.L288
.L291:
	lbu	a5,0(a5)
	bext	a5,a5,a4
	beq	a2,t3,.L285
	neg	a4,a5
	and	a3,a3,a5
	addi	a2,a2,1
	and	a4,a6,a4
	add	t4,a6,t1
	bne	a3,zero,.L283
.L292:
	mv	a6,t1
	add	a0,a0,a4
	mv	a3,a5
	mv	t1,t4
.L288:
	add	a5,t5,a7
	sub	a4,t3,a2
	bgtu	a1,a7,.L291
.L284:
	j	.L284
.L285:
	neg	a4,a5
	and	a3,a3,a5
	addi	a7,a7,1
	li	a2,0
	and	a4,a6,a4
	add	t4,a6,t1
	beq	a3,zero,.L292
.L283:
	ret
	.size	decode_fibonacci, .-decode_fibonacci
	.align	2
	.globl	decode_exp_golomb
	.type	decode_exp_golomb, @function
decode_exp_golomb:
	li	a5,0
	li	a4,0
	li	a6,7
	li	a2,0
	add	a3,a0,a4
	sub	a7,a6,a5
	bleu	a1,a4,.L295
.L311:
	lbu	a3,0(a3)
	bext	a3,a3,a7
	beq	a5,a6,.L296
	addi	a5,a5,1
	bne	a3,zero,.L310
.L298:
	addi	a2,a2,1
	add	a3,a0,a4
	sub	a7,a6,a5
	bgtu	a1,a4,.L311
.L295:
	j	.L295
.L296:
	addi	a4,a4,1
	li	a5,0
	beq	a3,zero,.L298
.L310:
	beq	a2,zero,.L304
	li	a6,0
	li	a3,0
	li	t4,7
	li	t3,8
.L303:
	sub	t1,t4,a5
	add	a7,a0,a4
	addi	a5,a5,1
	slli	a3,a3,1
	bleu	a1,a4,.L300
	lbu	a7,0(a7)
	bext	a7,a7,t1
	or	a3,a3,a7
	bne	a5,t3,.L301
	addi	a4,a4,1
	li	a5,0
.L301:
	addi	a6,a6,1
	bne	a2,a6,.L303
.L299:
	bset	a0,x0,a2
	addi	a0,a0,-1
	add	a0,a0,a3
	ret
.L304:
	bset	a0,x0,a2
	li	a3,0
	addi	a0,a0,-1
	add	a0,a0,a3
	ret
.L300:
	addi	a6,a6,1
	beq	a2,a6,.L299
.L302:
	addi	a6,a6,1
	slli	a3,a3,1
	bgtu	a2,a6,.L302
	bset	a0,x0,a2
	addi	a0,a0,-1
	add	a0,a0,a3
	ret
	.size	decode_exp_golomb, .-decode_exp_golomb
	.align	2
	.globl	decode_huffman_tree
	.type	decode_huffman_tree, @function
decode_huffman_tree:
	mv	t4,a0
	li	a3,0
	li	a6,0
	li	a5,0
	li	t3,7
	li	t5,8
	j	.L313
.L316:
	bleu	a1,a6,.L314
	lbu	a4,0(t1)
	addi	a3,a3,1
	bext	a4,a4,a7
	bne	a3,t5,.L314
	addi	a6,a6,1
	li	a3,0
.L314:
	sh2add	a4,a4,a5
	lw	a5,0(a4)
	blt	a5,zero,.L318
.L313:
	sh1add	a5,a5,a5
	sh2add	a5,a5,a2
	lw	a0,8(a5)
	add	t1,t4,a6
	sub	a7,t3,a3
	li	a4,0
	blt	a0,zero,.L316
	ret
.L318:
	li	a0,-1
	ret
	.size	decode_huffman_tree, .-decode_huffman_tree
	.align	2
	.globl	decode_huffman_table
	.type	decode_huffman_table, @function
decode_huffman_table:
	beq	a3,zero,.L321
	beq	a1,zero,.L329
	li	a6,1
	lbu	a5,0(a0)
	li	a4,0
	beq	a1,a6,.L330
	lbu	a7,1(a0)
	srli	a4,a5,24
	li	a6,2
	slli	a5,a5,8
	or	a5,a7,a5
	beq	a1,a6,.L331
	lbu	a4,2(a0)
	slli	a5,a5,8
	li	a6,3
	or	a5,a5,a4
	li	a4,0
	beq	a1,a6,.L332
	lbu	a7,3(a0)
	srli	a4,a5,24
	li	a6,4
	slli	a5,a5,8
	or	a5,a5,a7
	beq	a1,a6,.L333
	lbu	a7,4(a0)
	srli	t1,a5,24
	slli	a4,a4,8
	slli	a5,a5,8
	li	a6,5
	add	a4,t1,a4
	or	a5,a5,a7
	beq	a1,a6,.L334
	lbu	a7,5(a0)
	srli	t1,a5,24
	slli	a4,a4,8
	slli	a5,a5,8
	li	a6,6
	add	a4,t1,a4
	or	a5,a5,a7
	beq	a1,a6,.L335
	lbu	a7,6(a0)
	slli	a6,a4,8
	srli	a4,a5,24
	slli	a5,a5,8
	add	a6,a4,a6
	or	a5,a5,a7
	li	a7,7
	mv	a4,a6
	beq	a1,a7,.L337
	lbu	a1,7(a0)
	li	a4,64
	sub	a3,a4,a3
	srli	a0,a5,24
	slli	a6,a6,8
	slli	a5,a5,8
	addi	a4,a3,-32
	add	a6,a0,a6
	or	a5,a5,a1
	blt	a4,zero,.L322
	srl	a6,a6,a4
	sh2add	a2,a6,a2
.L321:
	lbu	a5,2(a2)
	beq	a5,zero,.L336
	lhu	a0,0(a2)
	ret
.L336:
	li	a0,-1
	ret
.L322:
	li	a1,31
	slli	a4,a6,1
	sub	a1,a1,a3
	srl	a6,a5,a3
	sll	a5,a4,a1
	add	a6,a5,a6
	sh2add	a2,a6,a2
	j	.L321
.L329:
	li	a5,0
	li	a4,0
.L324:
	sub	a1,a1,a3
	addi	a3,a1,-32
	blt	a3,zero,.L326
	srl	a4,a4,a3
	sh2add	a2,a4,a2
	j	.L321
.L326:
	li	a0,31
	slli	a3,a4,1
	sub	a0,a0,a1
	srl	a4,a5,a1
	sll	a5,a3,a0
	add	a4,a5,a4
	sh2add	a2,a4,a2
	j	.L321
.L330:
	li	a1,8
	j	.L324
.L331:
	li	a1,16
	j	.L324
.L332:
	li	a1,24
	j	.L324
.L333:
	li	a1,32
	j	.L324
.L334:
	li	a1,40
	j	.L324
.L335:
	li	a1,48
	j	.L324
.L337:
	li	a1,56
	j	.L324
	.size	decode_huffman_table, .-decode_huffman_table
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC1:
	.string	"Unary: %u\n"
	.align	2
.LC2:
	.string	"Elias gamma: %u\n"
	.align	2
.LC3:
	.string	"ULEB128: %llu\n"
	.align	2
.LC4:
	.string	"Zigzag 1: %d\n"
	.align	2
.LC5:
	.string	"Zigzag 2: %d\n"
	.align	2
.LC6:
	.string	"Zigzag 3: %d\n"
	.align	2
.LC7:
	.string	"RLE: "
	.align	2
.LC8:
	.string	"Delta:"
	.align	2
.LC9:
	.string	" %d"
	.align	2
.LC10:
	.string	"Exp-Golomb: %u\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	sw	s1,68(sp)
	sw	s2,64(sp)
	li	a5,0
	li	a4,3
	li	a1,0
	beq	a5,a4,.L339
.L379:
	addi	a5,a5,1
	addi	a1,a1,1
	bne	a5,a4,.L379
.L339:
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	li	a5,0
	li	a4,7
	li	a3,0
	li	a2,0
	li	a1,26
	beq	a5,a4,.L342
.L380:
	addi	a5,a5,1
	sub	a0,a4,a5
	bne	a3,zero,.L343
	bext	a3,a1,a0
	addi	a2,a2,1
	li	a1,26
	bne	a5,a4,.L380
.L342:
	j	.L342
.L343:
	beq	a2,zero,.L364
	li	a7,7
	sub	a3,a7,a5
	li	a6,26
	li	a1,2
	bext	a3,a6,a3
	li	a0,8
	addi	a5,a5,1
	li	a4,0
	or	a1,a3,a1
	beq	a5,a0,.L345
.L381:
	addi	a4,a4,1
	beq	a4,a2,.L344
	sub	a3,a7,a5
	slli	a1,a1,1
	bext	a3,a6,a3
	addi	a5,a5,1
	or	a1,a3,a1
	bne	a5,a0,.L381
.L345:
	addi	a5,a4,1
	beq	a2,a5,.L344
	addi	a4,a4,2
	slli	a1,a1,1
	beq	a4,a2,.L344
.L349:
	addi	a4,a4,1
	slli	a1,a1,1
	bltu	a4,a2,.L349
.L344:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	lui	a0,%hi(.LC3)
	li	a2,622592
	addi	a2,a2,1893
	li	a3,0
	addi	a0,a0,%lo(.LC3)
	call	printf
	lui	a0,%hi(.LC4)
	li	a1,-1
	addi	a0,a0,%lo(.LC4)
	call	printf
	lui	a0,%hi(.LC5)
	li	a1,1
	addi	a0,a0,%lo(.LC5)
	call	printf
	lui	a0,%hi(.LC6)
	li	a1,-2
	addi	a0,a0,%lo(.LC6)
	call	printf
	li	a4,1107509248
	li	a5,16384
	addi	a4,a4,260
	addi	a5,a5,770
	sw	a4,4(sp)
	sh	a5,8(sp)
	addi	a0,sp,4
	addi	a6,sp,8
	addi	s1,sp,32
	li	s0,0
	li	a1,32
.L357:
	lbu	a3,0(a0)
	beq	a3,zero,.L350
.L356:
	lbu	a2,1(a0)
	add	a3,a3,s0
.L352:
	addi	s0,s0,1
	add	a4,s1,s0
	sb	a2,-1(a4)
	beq	s0,a3,.L351
	bne	s0,a1,.L352
	bne	a0,a6,.L355
.L354:
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	printf
	beq	s0,zero,.L359
.L358:
	add	s0,s0,s1
	mv	s2,s1
.L360:
	lbu	a0,0(s2)
	addi	s2,s2,1
	call	putchar
	bne	s2,s0,.L360
.L359:
	li	a0,10
	call	putchar
	lui	a0,%hi(.LC8)
	li	a1,10
	li	a2,12
	li	a3,15
	li	a4,14
	li	a5,19
	addi	a0,a0,%lo(.LC8)
	lui	s2,%hi(.LC9)
	sw	a1,12(sp)
	sw	a2,16(sp)
	sw	a3,20(sp)
	sw	a4,24(sp)
	sw	a5,28(sp)
	addi	s0,sp,12
	call	printf
	addi	s2,s2,%lo(.LC9)
.L361:
	lw	a1,0(s0)
	mv	a0,s2
	addi	s0,s0,4
	call	printf
	bne	s0,s1,.L361
	li	a0,10
	call	putchar
	li	a5,40
	mv	a0,sp
	li	a1,1
	sb	a5,0(sp)
	call	decode_exp_golomb
	mv	a1,a0
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	printf
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	lw	s2,64(sp)
	li	a0,0
	addi	sp,sp,80
	jr	ra
.L351:
	beq	a0,a6,.L354
	addi	a0,a0,2
	beq	s0,a1,.L355
.L362:
	lbu	a3,0(a0)
	bne	a3,zero,.L356
	beq	a0,a6,.L354
	addi	a0,a0,2
	j	.L357
.L355:
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	printf
	li	s0,32
	j	.L358
.L364:
	li	a1,1
	j	.L344
.L350:
	beq	a0,a6,.L354
	addi	a0,a0,2
	j	.L362
	.size	main, .-main
	.globl	__mulsi3
	.globl	__ashldi3
	.ident	"GCC: (g6afcc4f6d) 16.1.0"
	.section	.note.GNU-stack,"",@progbits
