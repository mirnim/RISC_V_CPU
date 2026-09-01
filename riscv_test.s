	.file	"riscv_test.c"
	.option nopic
	.attribute arch, "rv32i2p1_b1p0_zba1p0_zbb1p0_zbs1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.type	decode_fibonacci, @function
decode_fibonacci:
	lui	a3,%hi(.LANCHOR0)
	addi	a3,a3,%lo(.LANCHOR0)
	lw	t1,4(a0)
	lw	a1,8(a0)
	mv	a2,a0
	addi	t5,a3,92
	li	a7,0
	li	a0,0
	li	t4,7
	li	t3,8
	li	t6,1
.L8:
	bleu	t1,a1,.L1
	lw	a4,0(a2)
	lw	a5,12(a2)
	add	a4,a4,a1
	lbu	a4,0(a4)
	sub	a6,t4,a5
	addi	a5,a5,1
	bext	a4,a4,a6
	beq	a5,t3,.L3
	sw	a5,12(a2)
.L4:
	beq	a4,zero,.L9
	beq	a7,t6,.L1
	lw	a5,0(a3)
	mv	a7,a4
	add	a0,a0,a5
.L5:
	addi	a3,a3,4
	bne	a3,t5,.L8
.L1:
	ret
.L9:
	li	a7,0
	j	.L5
.L3:
	addi	a1,a1,1
	sw	a1,8(a2)
	sw	zero,12(a2)
	j	.L4
	.size	decode_fibonacci, .-decode_fibonacci
	.align	2
	.type	decode_utf8, @function
decode_utf8:
	lw	a4,0(a1)
	addi	a3,a4,1
	sw	a3,0(a1)
	add	a5,a0,a4
	lbu	a5,0(a5)
	sext.b	a2,a5
	bge	a2,zero,.L12
	andi	a2,a5,224
	li	a6,192
	beq	a2,a6,.L20
	andi	a2,a5,240
	li	a6,224
	beq	a2,a6,.L21
	andi	a2,a5,248
	li	a6,240
	bne	a2,a6,.L19
	andi	a6,a5,7
	li	a7,3
.L17:
	addi	a5,a4,2
	sw	a5,0(a1)
	add	a3,a0,a3
	lbu	a3,0(a3)
	addi	a2,a4,3
	add	a5,a0,a5
	sw	a2,0(a1)
	lbu	a5,0(a5)
	slli	a6,a6,6
	andi	a3,a3,63
	or	a3,a3,a6
	slli	a3,a3,6
	andi	a5,a5,63
	li	a6,3
	or	a5,a5,a3
	bne	a7,a6,.L12
	addi	a4,a4,4
	sw	a4,0(a1)
	add	a2,a0,a2
	lbu	a4,0(a2)
	slli	a5,a5,6
	andi	a4,a4,63
	or	a5,a4,a5
.L12:
	mv	a0,a5
	ret
.L20:
	addi	a4,a4,2
	sw	a4,0(a1)
	add	a3,a0,a3
	lbu	a4,0(a3)
	andi	a5,a5,31
	slli	a5,a5,6
	andi	a4,a4,63
	or	a5,a4,a5
	j	.L12
.L19:
	li	a5,65536
	addi	a5,a5,-3
	j	.L12
.L21:
	andi	a6,a5,15
	li	a7,2
	j	.L17
	.size	decode_utf8, .-decode_utf8
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC1:
	.string	"  [PASS] %-28s = %lld\n"
	.align	2
.LC2:
	.string	"  [FAIL] %-28s = %lld (expected %lld)\n"
	.text
	.align	2
	.type	check_i64, @function
check_i64:
	mv	a7,a3
	mv	a6,a1
	mv	a3,a2
	beq	a1,a7,.L26
.L23:
	mv	a1,a0
	lui	a0,%hi(.LC2)
	addi	sp,sp,-16
	mv	a5,a4
	mv	a2,a6
	mv	a4,a7
	addi	a0,a0,%lo(.LC2)
	sw	ra,12(sp)
	call	printf
	lui	a4,%hi(g_failures)
	lw	a5,%lo(g_failures)(a4)
	lw	ra,12(sp)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(a4)
	addi	sp,sp,16
	jr	ra
.L26:
	bne	a2,a4,.L23
	lui	a5,%hi(.LC1)
	mv	a2,a1
	mv	a1,a0
	addi	a0,a5,%lo(.LC1)
	tail	printf
	.size	check_i64, .-check_i64
	.section	.rodata.str1.4
	.align	2
.LC3:
	.string	"  [PASS] %-28s = %llu\n"
	.align	2
.LC4:
	.string	"  [FAIL] %-28s = %llu (expected %llu)\n"
	.text
	.align	2
	.type	check_u64, @function
check_u64:
	mv	a7,a3
	mv	a6,a1
	mv	a3,a2
	beq	a1,a7,.L31
.L28:
	mv	a1,a0
	lui	a0,%hi(.LC4)
	addi	sp,sp,-16
	mv	a5,a4
	mv	a2,a6
	mv	a4,a7
	addi	a0,a0,%lo(.LC4)
	sw	ra,12(sp)
	call	printf
	lui	a4,%hi(g_failures)
	lw	a5,%lo(g_failures)(a4)
	lw	ra,12(sp)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(a4)
	addi	sp,sp,16
	jr	ra
.L31:
	bne	a2,a4,.L28
	lui	a5,%hi(.LC3)
	mv	a2,a1
	mv	a1,a0
	addi	a0,a5,%lo(.LC3)
	tail	printf
	.size	check_u64, .-check_u64
	.align	2
	.type	decode_rice.constprop.0, @function
decode_rice.constprop.0:
	lw	a2,8(a0)
	lw	t3,4(a0)
	bgeu	a2,t3,.L48
	lw	t1,0(a0)
	lw	a5,12(a0)
	li	a1,0
	li	a7,7
	li	a6,8
.L34:
	add	a4,t1,a2
	lbu	a4,0(a4)
	sub	a3,a7,a5
	addi	a5,a5,1
	bext	a4,a4,a3
	beq	a5,a6,.L35
	sw	a5,12(a0)
	beq	a4,zero,.L54
.L37:
	addi	a1,a1,1
	bgtu	t3,a2,.L34
.L50:
	li	a5,0
	j	.L33
.L35:
	addi	a2,a2,1
	sw	a2,8(a0)
	sw	zero,12(a0)
	li	a5,0
	bne	a4,zero,.L37
.L54:
	bleu	t3,a2,.L50
	lw	a3,12(a0)
	add	a5,t1,a2
	lbu	a5,0(a5)
	li	a6,7
	sub	a6,a6,a3
	li	a7,8
	addi	a3,a3,1
	bext	a5,a5,a6
	beq	a3,a7,.L55
	sw	a3,12(a0)
.L39:
	bleu	t3,a2,.L56
	lw	a3,12(a0)
	add	a6,t1,a2
	lbu	a6,0(a6)
	li	a7,7
	sub	a7,a7,a3
	li	t4,8
	addi	a3,a3,1
	bext	a6,a6,a7
	beq	a3,t4,.L57
	sw	a3,12(a0)
.L41:
	slli	a5,a5,1
	or	a5,a5,a6
	bleu	t3,a2,.L44
	lw	a3,12(a0)
	add	t1,t1,a2
	lbu	a4,0(t1)
	li	a6,7
	sub	a6,a6,a3
	li	a7,8
	addi	a3,a3,1
	bext	a4,a4,a6
	beq	a3,a7,.L42
	sw	a3,12(a0)
.L44:
	slli	a5,a5,1
	or	a5,a4,a5
.L33:
	slli	a1,a1,3
	or	a0,a1,a5
	ret
.L42:
	addi	a2,a2,1
	sw	a2,8(a0)
	sw	zero,12(a0)
	j	.L44
.L57:
	addi	a2,a2,1
	sw	a2,8(a0)
	sw	zero,12(a0)
	j	.L41
.L55:
	addi	a2,a2,1
	sw	a2,8(a0)
	sw	zero,12(a0)
	j	.L39
.L56:
	slli	a5,a5,2
	j	.L33
.L48:
	li	a1,0
	li	a5,0
	j	.L33
	.size	decode_rice.constprop.0, .-decode_rice.constprop.0
	.align	2
	.type	encode_unary, @function
encode_unary:
	lw	a5,8(a0)
	beq	a1,zero,.L59
	li	a2,0
	li	a7,7
	li	a6,8
.L62:
	lw	a3,4(a0)
	lw	a4,0(a0)
	sub	a5,a7,a5
	add	a4,a4,a3
	lbu	a3,0(a4)
	bset	a5,a3,a5
	sb	a5,0(a4)
	lw	a5,8(a0)
	addi	a5,a5,1
	beq	a5,a6,.L60
	sw	a5,8(a0)
	addi	a2,a2,1
	bne	a1,a2,.L62
.L59:
	addi	a5,a5,1
	li	a4,8
	beq	a5,a4,.L63
	sw	a5,8(a0)
	ret
.L60:
	lw	a5,4(a0)
	lw	a4,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a4,a5
	sb	zero,0(a5)
	addi	a2,a2,1
	lw	a5,8(a0)
	bne	a1,a2,.L62
	j	.L59
.L63:
	lw	a5,4(a0)
	lw	a4,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a4,a4,a5
	sb	zero,0(a4)
	ret
	.size	encode_unary, .-encode_unary
	.align	2
	.type	decode_elias_gamma, @function
decode_elias_gamma:
	lw	a3,8(a0)
	lw	a6,4(a0)
	bgeu	a3,a6,.L69
	lw	a7,0(a0)
	li	a2,0
	li	t3,7
	li	t1,8
.L70:
	lw	a5,12(a0)
	add	a4,a7,a3
	lbu	a4,0(a4)
	sub	a1,t3,a5
	addi	a5,a5,1
	bext	a4,a4,a1
	beq	a5,t1,.L72
	sw	a5,12(a0)
.L73:
	bne	a4,zero,.L71
	addi	a2,a2,1
	bgtu	a6,a3,.L70
.L71:
	bne	a2,zero,.L75
.L69:
	li	a0,1
	ret
.L72:
	addi	a3,a3,1
	sw	a3,8(a0)
	sw	zero,12(a0)
	j	.L73
.L75:
	ble	a2,zero,.L77
	bleu	a6,a3,.L78
	li	t1,0
	li	a4,0
	li	t5,7
	li	t4,8
	j	.L83
.L90:
	sw	a5,12(a0)
	slli	a4,a4,1
	addi	a5,t1,1
	or	a4,a1,a4
	beq	a2,a5,.L82
.L85:
	bleu	a6,a3,.L89
	mv	t1,a5
.L83:
	lw	a5,12(a0)
	add	a1,a7,a3
	lbu	a1,0(a1)
	sub	t3,t5,a5
	addi	a5,a5,1
	bext	a1,a1,t3
	bne	a5,t4,.L90
	addi	a3,a3,1
	slli	a4,a4,1
	sw	a3,8(a0)
	sw	zero,12(a0)
	addi	a5,t1,1
	or	a4,a1,a4
	bne	a2,a5,.L85
.L82:
	bset	a0,a4,a2
	ret
.L78:
	li	t1,1
	li	a4,0
	bne	a2,t1,.L84
.L77:
	li	a4,0
	j	.L82
.L89:
	addi	t1,t1,2
	slli	a4,a4,1
	beq	a2,t1,.L82
.L84:
	addi	t1,t1,1
	slli	a4,a4,1
	bgt	a2,t1,.L84
	j	.L82
	.size	decode_elias_gamma, .-decode_elias_gamma
	.align	2
	.type	decode_elias_delta, @function
decode_elias_delta:
	addi	sp,sp,-16
	sw	s0,8(sp)
	sw	ra,12(sp)
	mv	s0,a0
	call	decode_elias_gamma
	li	a5,1
	beq	a0,a5,.L91
	addi	a0,a0,-1
	ble	a0,zero,.L93
	lw	a7,4(s0)
	lw	a2,8(s0)
	bleu	a7,a2,.L94
	lw	t4,0(s0)
	li	a1,0
	li	a4,0
	li	t3,7
	li	t1,8
	j	.L99
.L108:
	sw	a5,12(s0)
	slli	a4,a4,1
	addi	a5,a1,1
	or	a4,a3,a4
	beq	a0,a5,.L98
.L101:
	bleu	a7,a2,.L107
	mv	a1,a5
.L99:
	lw	a5,12(s0)
	add	a3,t4,a2
	lbu	a3,0(a3)
	sub	a6,t3,a5
	addi	a5,a5,1
	bext	a3,a3,a6
	bne	a5,t1,.L108
	addi	a2,a2,1
	slli	a4,a4,1
	sw	a2,8(s0)
	sw	zero,12(s0)
	addi	a5,a1,1
	or	a4,a3,a4
	bne	a0,a5,.L101
.L98:
	bset	a0,a4,a0
.L91:
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.L93:
	li	a4,0
	bset	a0,a4,a0
	j	.L91
.L94:
	li	a4,0
	beq	a0,a5,.L93
.L100:
	addi	a5,a5,1
	slli	a4,a4,1
	bgt	a0,a5,.L100
	bset	a0,a4,a0
	j	.L91
.L107:
	addi	a5,a1,2
	slli	a4,a4,1
	bne	a0,a5,.L100
	bset	a0,a4,a0
	j	.L91
	.size	decode_elias_delta, .-decode_elias_delta
	.align	2
	.type	encode_elias_gamma, @function
encode_elias_gamma:
	li	a3,1
	bleu	a1,a3,.L110
	mv	a5,a1
	li	a4,0
.L111:
	srli	a5,a5,1
	mv	a2,a4
	addi	a4,a4,1
	bne	a5,a3,.L111
	lw	a5,8(a0)
	li	a7,8
	li	a3,0
	addi	a5,a5,1
	beq	a5,a7,.L112
.L129:
	sw	a5,8(a0)
	beq	a2,a3,.L113
.L128:
	addi	a5,a5,1
	addi	a3,a3,1
	bne	a5,a7,.L129
.L112:
	lw	a5,4(a0)
	lw	a6,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a6,a5
	sb	zero,0(a5)
	lw	a5,8(a0)
	bne	a2,a3,.L128
.L113:
	li	t1,7
	li	a7,8
	li	a6,-1
	j	.L122
.L116:
	addi	a5,a5,1
	beq	a5,a7,.L119
.L130:
	sw	a5,8(a0)
	addi	a4,a4,-1
	beq	a4,a6,.L109
.L131:
	lw	a5,8(a0)
.L122:
	addi	a3,a4,-32
	bge	a3,zero,.L116
	bext	a3,a1,a4
	sub	a2,t1,a5
	beq	a3,zero,.L116
	lw	a3,4(a0)
	lw	a5,0(a0)
	add	a5,a5,a3
	lbu	a3,0(a5)
	bset	a3,a3,a2
	sb	a3,0(a5)
	lw	a5,8(a0)
	addi	a5,a5,1
	bne	a5,a7,.L130
.L119:
	lw	a5,4(a0)
	lw	a3,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a3,a5
	sb	zero,0(a5)
	addi	a4,a4,-1
	bne	a4,a6,.L131
.L109:
	ret
.L110:
	lw	a5,8(a0)
	li	a4,0
	j	.L113
	.size	encode_elias_gamma, .-encode_elias_gamma
	.align	2
	.type	encode_exp_golomb, @function
encode_exp_golomb:
	addi	a1,a1,1
	li	a3,1
	beq	a1,a3,.L133
	mv	a5,a1
	li	a4,0
.L134:
	srli	a5,a5,1
	mv	a2,a4
	addi	a4,a4,1
	bne	a5,a3,.L134
	lw	a5,8(a0)
	li	a7,8
	li	a3,0
	addi	a5,a5,1
	beq	a5,a7,.L135
.L152:
	sw	a5,8(a0)
	beq	a2,a3,.L136
.L151:
	addi	a5,a5,1
	addi	a3,a3,1
	bne	a5,a7,.L152
.L135:
	lw	a5,4(a0)
	lw	a6,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a6,a5
	sb	zero,0(a5)
	lw	a5,8(a0)
	bne	a2,a3,.L151
.L136:
	li	t1,7
	li	a7,8
	li	a6,-1
	j	.L145
.L139:
	addi	a5,a5,1
	beq	a5,a7,.L142
.L153:
	sw	a5,8(a0)
	addi	a4,a4,-1
	beq	a4,a6,.L132
.L154:
	lw	a5,8(a0)
.L145:
	addi	a3,a4,-32
	bge	a3,zero,.L139
	bext	a3,a1,a4
	sub	a2,t1,a5
	beq	a3,zero,.L139
	lw	a3,4(a0)
	lw	a5,0(a0)
	add	a5,a5,a3
	lbu	a3,0(a5)
	bset	a3,a3,a2
	sb	a3,0(a5)
	lw	a5,8(a0)
	addi	a5,a5,1
	bne	a5,a7,.L153
.L142:
	lw	a5,4(a0)
	lw	a3,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a3,a5
	sb	zero,0(a5)
	addi	a4,a4,-1
	bne	a4,a6,.L154
.L132:
	ret
.L133:
	lw	a5,8(a0)
	li	a4,0
	j	.L136
	.size	encode_exp_golomb, .-encode_exp_golomb
	.align	2
	.type	decode_exp_golomb, @function
decode_exp_golomb:
	lw	a3,8(a0)
	lw	a6,4(a0)
	bgeu	a3,a6,.L171
	lw	a7,0(a0)
	li	a2,0
	li	t3,7
	li	t1,8
.L157:
	lw	a5,12(a0)
	add	a4,a7,a3
	lbu	a4,0(a4)
	sub	a1,t3,a5
	addi	a5,a5,1
	bext	a4,a4,a1
	beq	a5,t1,.L159
	sw	a5,12(a0)
.L160:
	bne	a4,zero,.L158
	addi	a2,a2,1
	bgtu	a6,a3,.L157
.L158:
	li	a5,0
	bne	a2,zero,.L179
.L156:
	bset	a2,x0,a2
	addi	a5,a5,-1
	add	a0,a2,a5
	ret
.L159:
	addi	a3,a3,1
	sw	a3,8(a0)
	sw	zero,12(a0)
	j	.L160
.L179:
	ble	a2,zero,.L178
	bleu	a6,a3,.L163
	li	t1,0
	li	t5,7
	li	t4,8
	j	.L168
.L181:
	sw	a4,12(a0)
.L165:
	slli	a5,a5,1
	addi	a4,t1,1
	or	a5,a1,a5
	beq	a2,a4,.L156
	bleu	a6,a3,.L180
	mv	t1,a4
.L168:
	lw	a4,12(a0)
	add	a1,a7,a3
	lbu	a1,0(a1)
	sub	t3,t5,a4
	addi	a4,a4,1
	bext	a1,a1,t3
	bne	a4,t4,.L181
	addi	a3,a3,1
	sw	a3,8(a0)
	sw	zero,12(a0)
	j	.L165
.L171:
	li	a2,0
.L178:
	li	a5,0
	j	.L156
.L163:
	li	t1,1
	li	a5,0
	beq	a2,t1,.L178
.L169:
	addi	t1,t1,1
	slli	a5,a5,1
	bgt	a2,t1,.L169
	j	.L156
.L180:
	addi	t1,t1,2
	slli	a5,a5,1
	bne	a2,t1,.L169
	j	.L156
	.size	decode_exp_golomb, .-decode_exp_golomb
	.align	2
	.type	encode_elias_delta, @function
encode_elias_delta:
	addi	sp,sp,-32
	sw	s0,24(sp)
	sw	s1,20(sp)
	mv	s0,a1
	clz	s1,a1
	li	a1,32
	sub	a1,a1,s1
	sw	ra,28(sp)
	sw	a0,12(sp)
	call	encode_elias_gamma
	li	a5,1
	beq	s0,a5,.L182
	li	a5,30
	lw	a0,12(sp)
	sub	a5,a5,s1
	li	a7,7
	li	a6,8
	li	a1,-1
	j	.L189
.L184:
	lw	a4,8(a0)
	addi	a4,a4,1
	beq	a4,a6,.L187
.L196:
	sw	a4,8(a0)
	addi	a5,a5,-1
	beq	a5,a1,.L182
.L189:
	addi	a4,a5,-32
	bge	a4,zero,.L184
	bext	a4,s0,a5
	beq	a4,zero,.L184
	lw	a3,4(a0)
	lw	a4,0(a0)
	lw	a2,8(a0)
	add	a4,a4,a3
	lbu	a3,0(a4)
	sub	a2,a7,a2
	bset	a3,a3,a2
	sb	a3,0(a4)
	lw	a4,8(a0)
	addi	a4,a4,1
	bne	a4,a6,.L196
.L187:
	lw	a4,4(a0)
	lw	a3,0(a0)
	sw	zero,8(a0)
	addi	a4,a4,1
	sw	a4,4(a0)
	add	a4,a3,a4
	sb	zero,0(a4)
	addi	a5,a5,-1
	bne	a5,a1,.L189
.L182:
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	encode_elias_delta, .-encode_elias_delta
	.align	2
	.type	encode_fibonacci, @function
encode_fibonacci:
	lui	a7,%hi(.LANCHOR0)
	addi	sp,sp,-96
	addi	a7,a7,%lo(.LANCHOR0)
	addi	a5,a7,88
	addi	t1,sp,4
	addi	a4,sp,92
	li	a2,22
	li	a6,-1
	li	t3,1
.L201:
	lw	a3,0(a5)
	bgtu	a3,a1,.L198
.L213:
	sw	t3,0(a4)
	max	a6,a6,a2
	beq	a7,a5,.L199
	addi	a5,a5,-4
	sub	a1,a1,a3
	lw	a3,0(a5)
	addi	a2,a2,-1
	addi	a4,a4,-4
	bleu	a3,a1,.L213
.L198:
	sw	zero,0(a4)
	beq	a7,a5,.L199
	addi	a2,a2,-1
	addi	a5,a5,-4
	addi	a4,a4,-4
	j	.L201
.L199:
	lw	a5,8(a0)
	max	a6,a6,zero
	addi	a4,t1,4
	sh2add	a6,a6,a4
	li	a7,7
	li	a1,8
.L206:
	lw	a3,0(t1)
	sub	a2,a7,a5
	mv	t1,a4
	beq	a3,zero,.L202
	lw	a3,4(a0)
	lw	a5,0(a0)
	add	a5,a5,a3
	lbu	a3,0(a5)
	bset	a3,a3,a2
	sb	a3,0(a5)
	lw	a5,8(a0)
.L202:
	addi	a5,a5,1
	beq	a5,a1,.L203
	sw	a5,8(a0)
	beq	a6,a4,.L205
.L204:
	addi	a4,a4,4
	j	.L206
.L203:
	lw	a5,4(a0)
	lw	a3,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a5,a3,a5
	sb	zero,0(a5)
	lw	a5,8(a0)
	mv	t1,a4
	bne	a6,a4,.L204
.L205:
	lw	a4,0(a0)
	lw	a2,4(a0)
	li	a3,7
	sub	a3,a3,a5
	add	a5,a4,a2
	lbu	a4,0(a5)
	li	a2,8
	bset	a4,a4,a3
	sb	a4,0(a5)
	lw	a5,8(a0)
	addi	a5,a5,1
	beq	a5,a2,.L207
	sw	a5,8(a0)
.L197:
	addi	sp,sp,96
	jr	ra
.L207:
	lw	a5,4(a0)
	lw	a4,0(a0)
	sw	zero,8(a0)
	addi	a5,a5,1
	sw	a5,4(a0)
	add	a4,a4,a5
	sb	zero,0(a4)
	j	.L197
	.size	encode_fibonacci, .-encode_fibonacci
	.section	.rodata.str1.4
	.align	2
.LC5:
	.string	"SGVsbG8sIFdvcmxkIQ=="
	.align	2
.LC6:
	.string	"ABCDEA"
	.align	2
.LC7:
	.string	"ALL TESTS PASSED"
	.align	2
.LC8:
	.string	"TESTS FAILED"
	.align	2
.LC9:
	.string	"=== 1. Unary ==="
	.align	2
.LC10:
	.string	"unary(5)"
	.align	2
.LC11:
	.string	"=== 2. Elias gamma ==="
	.align	2
.LC12:
	.string	"gamma(1)"
	.align	2
.LC13:
	.string	"gamma(5)"
	.align	2
.LC14:
	.string	"gamma(17)"
	.align	2
.LC15:
	.string	"=== 3. Elias delta ==="
	.align	2
.LC16:
	.string	"delta(1)"
	.align	2
.LC17:
	.string	"delta(5)"
	.align	2
.LC18:
	.string	"delta(1000)"
	.align	2
.LC19:
	.string	"=== 4. Golomb-Rice (k=3) ==="
	.align	2
.LC20:
	.string	"rice(0,k=3)"
	.align	2
.LC21:
	.string	"rice(7,k=3)"
	.align	2
.LC22:
	.string	"rice(100,k=3)"
	.align	2
.LC23:
	.string	"=== 5. Exponential-Golomb ==="
	.align	2
.LC24:
	.string	"exp_golomb(0)"
	.align	2
.LC25:
	.string	"exp_golomb(6)"
	.align	2
.LC26:
	.string	"exp_golomb(41)"
	.align	2
.LC27:
	.string	"=== 6. Fibonacci coding ==="
	.align	2
.LC28:
	.string	"fibonacci(1)"
	.align	2
.LC29:
	.string	"fibonacci(4)"
	.align	2
.LC30:
	.string	"fibonacci(65)"
	.align	2
.LC31:
	.string	"=== 7. LEB128 unsigned varint ==="
	.align	2
.LC32:
	.string	"leb128_unsigned(300)"
	.align	2
.LC33:
	.string	"leb128_unsigned(624485)"
	.align	2
.LC34:
	.string	"=== 8. LEB128 signed (zigzag) varint ==="
	.align	2
.LC35:
	.string	"leb128_signed(-2)"
	.align	2
.LC36:
	.string	"leb128_signed(300)"
	.align	2
.LC37:
	.string	"=== 9. SQLite-style varint ==="
	.align	2
.LC38:
	.string	"sqlite_varint(128)"
	.align	2
.LC39:
	.string	"sqlite_varint(127)"
	.align	2
.LC40:
	.string	"=== 10. MIDI VLQ ==="
	.align	2
.LC41:
	.string	"midi_vlq(200)"
	.align	2
.LC42:
	.string	"midi_vlq(64)"
	.align	2
.LC43:
	.string	"=== 11. UTF-8 ==="
	.align	2
.LC44:
	.string	"utf8('A')"
	.align	2
.LC45:
	.string	"utf8(euro sign)"
	.align	2
.LC46:
	.string	"utf8(U+1F600)"
	.align	2
.LC47:
	.string	"=== 12. UTF-16 (surrogate pairs) ==="
	.align	2
.LC48:
	.string	"utf16('A')"
	.align	2
.LC49:
	.string	"utf16(U+1F600)"
	.align	2
.LC50:
	.string	"=== 13. Base64 ==="
	.align	2
.LC51:
	.string	"Hello, World!"
	.align	2
.LC52:
	.string	"PASS"
	.align	2
.LC53:
	.string	"  [%s] base64 decode -> \"%s\"\n"
	.align	2
.LC54:
	.string	"FAIL"
	.align	2
.LC55:
	.string	"=== 14. ASN.1 BER length ==="
	.align	2
.LC56:
	.string	"ber_length(short=5)"
	.align	2
.LC57:
	.string	"ber_length(long=300)"
	.align	2
.LC58:
	.string	"=== 15. RLE (PackBits, byte-oriented) ==="
	.align	2
.LC59:
	.string	"ABXXXX"
	.align	2
.LC60:
	.string	"  [%s] packbits -> \"%.*s\"\n"
	.align	2
.LC61:
	.string	"=== 16. RLE (bit-oriented, alternating runs) ==="
	.align	2
.LC62:
	.string	"=== 17. Move-to-front decode ==="
	.align	2
.LC63:
	.string	"banana"
	.align	2
.LC64:
	.string	"  [%s] mtf round-trip -> \"%.*s\"\n"
	.align	2
.LC65:
	.string	"=== 18. Canonical Huffman (memory-efficient vs table-driven) ==="
	.align	2
.LC66:
	.string	"  [FAIL] no code for symbol '%c'\n"
	.align	2
.LC67:
	.string	"  [%s] bit-serial decode  -> \"%s\"\n"
	.align	2
.LC68:
	.string	"  [%s] table-driven decode -> \"%s\"\n"
	.align	2
.LC69:
	.string	"=== 19. LZ77 token decode ==="
	.align	2
.LC70:
	.string	"abcabcabc"
	.align	2
.LC71:
	.string	"  [%s] lz77 decode -> \"%.*s\"\n"
	.align	2
.LC72:
	.string	"=== 20. Delta-encoded varint stream ==="
	.align	2
.LC73:
	.string	"=== 21. Fixed-width bit-packing decode ==="
	.align	2
.LC74:
	.string	"\n%s: %d failure(s)\n"
	.align	2
.LC75:
	.string	"  [%s] bitpacked(w=5) -> {%u,%u,%u,%u,%u}\n"
	.align	2
.LC76:
	.string	"  [%s] delta stream -> {%lld,%lld,%lld,%lld}\n"
	.align	2
.LC77:
	.string	"  [%s] bitwise RLE -> {%d,%d,%d,%d,%d,%d}\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-2032
	lui	a0,%hi(.LC9)
	sw	ra,2028(sp)
	sw	s0,2024(sp)
	sw	s1,2020(sp)
	sw	s2,2016(sp)
	sw	s3,2012(sp)
	sw	s4,2008(sp)
	sw	s5,2004(sp)
	sw	s6,2000(sp)
	sw	s7,1996(sp)
	sw	s8,1992(sp)
	sw	s9,1988(sp)
	sw	s10,1984(sp)
	sw	s11,1980(sp)
	addi	a0,a0,%lo(.LC9)
	addi	sp,sp,-160
	call	puts
	li	a5,-8
	sb	a5,128(sp)
	li	a5,0
	li	a3,7
	addi	a4,a5,1
	li	a2,8
	li	a1,0
	li	a0,248
	sub	a5,a3,a5
	beq	a4,a2,.L216
.L511:
	bext	a6,a0,a5
	beq	a6,zero,.L216
	mv	a5,a4
	addi	a4,a5,1
	addi	a1,a1,1
	sub	a5,a3,a5
	bne	a4,a2,.L511
.L216:
	lui	a0,%hi(.LC10)
	li	a2,0
	li	a3,5
	li	a4,0
	addi	a0,a0,%lo(.LC10)
	call	check_u64
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	puts
	li	a5,4096
	addi	a5,a5,-2032
	add	s2,sp,a5
	addi	s8,sp,128
	addi	a0,s2,-2048
	li	a1,1
	sb	zero,128(sp)
	sw	zero,20(sp)
	sw	zero,24(sp)
	sw	s8,16(sp)
	call	encode_elias_gamma
	addi	a0,s2,-2048
	li	a1,5
	call	encode_elias_gamma
	li	a1,17
	addi	a0,s2,-2048
	call	encode_elias_gamma
	lw	a5,24(sp)
	lw	a4,20(sp)
	li	a3,4096
	addi	a3,a3,-2020
	add	s1,sp,a3
	sgt	a5,a5,zero
	add	a5,a5,a4
	addi	a0,s1,-2048
	sw	a5,32(sp)
	sw	s8,28(sp)
	sw	zero,36(sp)
	sw	zero,40(sp)
	call	decode_elias_gamma
	mv	a1,a0
	lui	a0,%hi(.LC12)
	li	a3,1
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC12)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_elias_gamma
	mv	a1,a0
	lui	a0,%hi(.LC13)
	li	a3,5
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC13)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_elias_gamma
	mv	a1,a0
	lui	a0,%hi(.LC14)
	li	a3,17
	li	a2,0
	li	a4,0
	addi	a0,a0,%lo(.LC14)
	call	check_u64
	lui	a0,%hi(.LC15)
	addi	a0,a0,%lo(.LC15)
	call	puts
	addi	a0,s2,-2048
	li	a1,1
	sb	zero,128(sp)
	sw	s8,16(sp)
	sw	zero,20(sp)
	sw	zero,24(sp)
	call	encode_elias_delta
	addi	a0,s2,-2048
	li	a1,5
	call	encode_elias_delta
	li	a1,1000
	addi	a0,s2,-2048
	call	encode_elias_delta
	lw	a5,24(sp)
	lw	a4,20(sp)
	addi	a0,s1,-2048
	sgt	a5,a5,zero
	add	a5,a5,a4
	sw	a5,32(sp)
	sw	zero,36(sp)
	sw	zero,40(sp)
	call	decode_elias_delta
	mv	a1,a0
	lui	a0,%hi(.LC16)
	li	a3,1
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC16)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_elias_delta
	mv	a1,a0
	lui	a0,%hi(.LC17)
	li	a3,5
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC17)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_elias_delta
	mv	a1,a0
	lui	a0,%hi(.LC18)
	li	a3,1000
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC18)
	call	check_u64
	lui	a0,%hi(.LC19)
	addi	a0,a0,%lo(.LC19)
	call	puts
	li	a1,0
	addi	a0,s2,-2048
	sb	zero,128(sp)
	sw	s8,16(sp)
	sw	zero,20(sp)
	sw	zero,24(sp)
	call	encode_unary
	lw	a5,24(sp)
	li	a2,8
	lw	a3,16(sp)
	addi	a1,a5,1
	lw	a4,20(sp)
	beq	a1,a2,.L512
	addi	a1,a5,2
	beq	a1,a2,.L513
	addi	a5,a5,3
	bne	a5,a2,.L219
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,0
.L219:
	li	a1,0
	addi	a0,s2,-2048
	sw	a4,20(sp)
	sw	a5,24(sp)
	call	encode_unary
	lw	a2,16(sp)
	lw	a3,20(sp)
	lw	a4,24(sp)
	li	a6,7
	add	a0,a2,a3
	lbu	a5,0(a0)
	sub	a7,a6,a4
	addi	a1,a4,1
	bset	a5,a5,a7
	sb	a5,0(a0)
	li	a7,8
	beq	a1,a7,.L514
	sub	a1,a6,a1
	bset	a5,a5,a1
	sb	a5,0(a0)
	addi	a1,a4,2
	bne	a1,a7,.L223
	addi	a3,a3,1
	add	a2,a2,a3
	li	a5,-128
	sb	a5,0(a2)
	li	a4,1
.L222:
	li	a1,12
	addi	a0,s2,-2048
	sw	a3,20(sp)
	sw	a4,24(sp)
	call	encode_unary
	lw	a3,16(sp)
	lw	a4,20(sp)
	lw	a5,24(sp)
	li	a1,7
	add	a0,a3,a4
	lbu	a2,0(a0)
	sub	a1,a1,a5
	addi	a6,a5,1
	bset	a2,a2,a1
	sb	a2,0(a0)
	li	a2,8
	beq	a6,a2,.L515
	addi	a1,a5,2
	beq	a1,a2,.L516
	addi	a5,a5,3
	bne	a5,a2,.L225
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,0
.L225:
	sgt	a5,a5,zero
	add	a5,a5,a4
	addi	a0,s1,-2048
	sw	a5,32(sp)
	sw	zero,36(sp)
	sw	zero,40(sp)
	call	decode_rice.constprop.0
	mv	a1,a0
	lui	a0,%hi(.LC20)
	li	a3,0
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC20)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_rice.constprop.0
	mv	a1,a0
	lui	a0,%hi(.LC21)
	li	a3,7
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC21)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_rice.constprop.0
	mv	a1,a0
	lui	a0,%hi(.LC22)
	li	a3,100
	li	a2,0
	li	a4,0
	addi	a0,a0,%lo(.LC22)
	call	check_u64
	lui	a0,%hi(.LC23)
	addi	a0,a0,%lo(.LC23)
	call	puts
	addi	a0,s2,-2048
	li	a1,0
	sb	zero,128(sp)
	sw	s8,16(sp)
	sw	zero,20(sp)
	sw	zero,24(sp)
	call	encode_exp_golomb
	addi	a0,s2,-2048
	li	a1,6
	call	encode_exp_golomb
	li	a1,41
	addi	a0,s2,-2048
	call	encode_exp_golomb
	lw	a5,24(sp)
	lw	a4,20(sp)
	addi	a0,s1,-2048
	sgt	a5,a5,zero
	add	a5,a5,a4
	sw	a5,32(sp)
	sw	zero,36(sp)
	sw	zero,40(sp)
	call	decode_exp_golomb
	mv	a1,a0
	lui	a0,%hi(.LC24)
	li	a3,0
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC24)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_exp_golomb
	mv	a1,a0
	lui	a0,%hi(.LC25)
	li	a3,6
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC25)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_exp_golomb
	mv	a1,a0
	lui	a0,%hi(.LC26)
	li	a3,41
	li	a2,0
	li	a4,0
	addi	a0,a0,%lo(.LC26)
	call	check_u64
	lui	a0,%hi(.LC27)
	addi	a0,a0,%lo(.LC27)
	call	puts
	addi	a0,s2,-2048
	li	a1,1
	sb	zero,128(sp)
	sw	s8,16(sp)
	sw	zero,20(sp)
	sw	zero,24(sp)
	call	encode_fibonacci
	addi	a0,s2,-2048
	li	a1,4
	call	encode_fibonacci
	li	a1,65
	addi	a0,s2,-2048
	call	encode_fibonacci
	lw	a5,24(sp)
	lw	a4,20(sp)
	addi	a0,s1,-2048
	sgt	a5,a5,zero
	add	a5,a5,a4
	sw	a5,32(sp)
	sw	zero,36(sp)
	sw	zero,40(sp)
	call	decode_fibonacci
	mv	a1,a0
	lui	a0,%hi(.LC28)
	li	a3,1
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC28)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_fibonacci
	mv	a1,a0
	lui	a0,%hi(.LC29)
	li	a3,4
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC29)
	call	check_u64
	addi	a0,s1,-2048
	call	decode_fibonacci
	mv	a1,a0
	lui	a0,%hi(.LC30)
	li	a3,65
	addi	a0,a0,%lo(.LC30)
	li	a4,0
	li	a2,0
	call	check_u64
	lui	a0,%hi(.LC31)
	addi	a0,a0,%lo(.LC31)
	call	puts
	li	a5,-1897594880
	addi	a5,a5,684
	sw	a5,1104(sp)
	addi	s0,sp,1104
	li	a5,38
	sb	a5,1108(sp)
	li	a3,0
	mv	a5,s0
	li	a6,0
	li	a0,0
	li	t3,31
	j	.L229
.L518:
	sll	a2,a1,a2
	li	a1,0
	or	a1,a6,a1
	or	a2,a0,a2
	sext.b	a4,a4
	addi	a3,a3,7
	addi	a5,a5,1
	mv	a6,a1
	mv	a0,a2
	bge	a4,zero,.L517
.L229:
	lbu	a4,0(a5)
	addi	a2,a3,-32
	sub	a7,t3,a3
	andi	a1,a4,127
	srli	t1,a1,1
	bge	a2,zero,.L518
	sll	a1,a1,a3
	srl	a2,t1,a7
	or	a1,a6,a1
	or	a2,a0,a2
	sext.b	a4,a4
	addi	a3,a3,7
	addi	a5,a5,1
	mv	a6,a1
	mv	a0,a2
	blt	a4,zero,.L229
.L517:
	li	a6,0
	li	s2,0
	li	s1,0
	li	t3,31
	j	.L232
.L520:
	sll	a0,a3,a0
	sext.b	a4,a4
	li	a3,0
	or	s2,s2,a3
	or	s1,s1,a0
	addi	a6,a6,7
	addi	a5,a5,1
	bge	a4,zero,.L519
.L232:
	lbu	a4,0(a5)
	addi	a0,a6,-32
	sub	a7,t3,a6
	andi	a3,a4,127
	srli	t1,a3,1
	bge	a0,zero,.L520
	sll	a3,a3,a6
	srl	a0,t1,a7
	sext.b	a4,a4
	or	s2,s2,a3
	or	s1,s1,a0
	addi	a6,a6,7
	addi	a5,a5,1
	blt	a4,zero,.L232
.L519:
	lui	a0,%hi(.LC32)
	addi	a0,a0,%lo(.LC32)
	li	a3,300
	li	a4,0
	call	check_u64
	lui	a0,%hi(.LC33)
	li	a3,622592
	mv	a1,s2
	mv	a2,s1
	addi	a0,a0,%lo(.LC33)
	addi	a3,a3,1893
	li	a4,0
	call	check_u64
	lui	a0,%hi(.LC34)
	addi	a0,a0,%lo(.LC34)
	call	puts
	li	a5,-8192
	addi	a5,a5,-2045
	sh	a5,1104(sp)
	li	a5,4
	sb	a5,1106(sp)
	addi	a1,sp,1105
	li	a5,0
	li	a0,0
	li	a7,0
	j	.L235
.L522:
	sll	a2,a3,a2
	sext.b	a4,a4
	li	a3,0
	or	a0,a0,a3
	or	a7,a7,a2
	addi	a5,a5,7
	addi	a1,a1,1
	bge	a4,zero,.L521
.L235:
	lbu	a4,0(a1)
	li	a3,31
	sub	a6,a3,a5
	addi	a2,a5,-32
	andi	a3,a4,127
	srli	t1,a3,1
	bge	a2,zero,.L522
	sll	a3,a3,a5
	srl	a2,t1,a6
	sext.b	a4,a4
	or	a0,a0,a3
	or	a7,a7,a2
	addi	a5,a5,7
	addi	a1,a1,1
	blt	a4,zero,.L235
.L521:
	slli	a4,a7,31
	srli	a5,a0,1
	add	a5,a4,a5
	andi	a2,a0,1
	li	a3,-2
	li	a4,-1
	lui	a0,%hi(.LC35)
	srli	a7,a7,1
	neg	s2,a2
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC35)
	xor	s1,s2,a7
	xor	s2,s2,a5
	call	check_i64
	lui	a0,%hi(.LC36)
	mv	a1,s2
	mv	a2,s1
	li	a3,300
	li	a4,0
	addi	a0,a0,%lo(.LC36)
	call	check_i64
	lui	a0,%hi(.LC37)
	addi	a0,a0,%lo(.LC37)
	call	puts
	li	a3,128
	li	a4,0
	lui	a0,%hi(.LC38)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC38)
	call	check_u64
	li	a3,127
	li	a4,0
	lui	a0,%hi(.LC39)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC39)
	call	check_u64
	lui	a0,%hi(.LC40)
	addi	a0,a0,%lo(.LC40)
	call	puts
	li	a5,20480
	addi	a5,a5,-1919
	sh	a5,1104(sp)
	li	a5,64
	sb	a5,1106(sp)
	li	a1,0
	mv	a5,s0
.L236:
	lbu	a4,0(a5)
	slli	a1,a1,7
	addi	a5,a5,1
	andi	a3,a4,127
	sext.b	a4,a4
	or	a1,a3,a1
	blt	a4,zero,.L236
	li	s1,0
.L237:
	lbu	a4,0(a5)
	slli	s1,s1,7
	addi	a5,a5,1
	andi	a3,a4,127
	sext.b	a4,a4
	or	s1,a3,s1
	blt	a4,zero,.L237
	lui	a0,%hi(.LC41)
	addi	a0,a0,%lo(.LC41)
	li	a3,200
	li	a4,0
	li	a2,0
	call	check_u64
	lui	a0,%hi(.LC42)
	li	a3,64
	li	a2,0
	mv	a1,s1
	li	a4,0
	addi	a0,a0,%lo(.LC42)
	call	check_u64
	lui	a0,%hi(.LC43)
	addi	a0,a0,%lo(.LC43)
	call	puts
	addi	s1,sp,644
	li	a4,-1400709120
	li	a5,-2137481216
	addi	a5,a5,-16
	addi	a4,a4,577
	mv	a1,s1
	mv	a0,s0
	sw	a5,1108(sp)
	sw	a4,1104(sp)
	sw	zero,644(sp)
	call	decode_utf8
	mv	s4,a0
	mv	a1,s1
	mv	a0,s0
	call	decode_utf8
	mv	s3,a0
	mv	a1,s1
	mv	a0,s0
	call	decode_utf8
	mv	s2,a0
	lui	a0,%hi(.LC44)
	mv	a1,s4
	addi	a0,a0,%lo(.LC44)
	li	a3,65
	li	a4,0
	li	a2,0
	call	check_u64
	lui	a0,%hi(.LC45)
	li	a3,8192
	mv	a1,s3
	addi	a0,a0,%lo(.LC45)
	addi	a3,a3,172
	li	a4,0
	li	a2,0
	call	check_u64
	lui	a0,%hi(.LC46)
	li	a3,126976
	mv	a1,s2
	addi	a3,a3,1536
	li	a4,0
	li	a2,0
	addi	a0,a0,%lo(.LC46)
	call	check_u64
	lui	a0,%hi(.LC47)
	addi	a0,a0,%lo(.LC47)
	call	puts
	li	a3,65
	li	a4,0
	lui	a0,%hi(.LC48)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC48)
	call	check_u64
	li	a3,126976
	addi	a3,a3,1536
	li	a4,0
	lui	a0,%hi(.LC49)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC49)
	call	check_u64
	lui	a0,%hi(.LC50)
	addi	a0,a0,%lo(.LC50)
	call	puts
	lui	a4,%hi(.LC5)
	lui	a0,%hi(.LC5+18)
	addi	a4,a4,%lo(.LC5)
	addi	a0,a0,%lo(.LC5+18)
	li	a1,0
	li	a3,0
	li	a5,83
	li	a6,57
	li	t1,4
	li	t4,90
	li	t6,25
	li	t5,64
	li	a7,47
	li	t3,43
.L238:
	bgtu	a5,a6,.L240
	bgtu	a5,a7,.L241
	beq	a5,t3,.L415
	li	a2,63
	bne	a5,a7,.L246
.L242:
	sh2add	a5,a3,s1
	sw	a2,0(a5)
	addi	a3,a3,1
	bne	a3,t1,.L246
	lw	a2,648(sp)
	lw	a3,652(sp)
	lw	a5,644(sp)
	lw	t0,656(sp)
	srai	s2,a2,4
	srai	t2,a3,2
	slli	a2,a2,4
	slli	a5,a5,2
	or	a5,a5,s2
	or	t2,t2,a2
	add	s2,sp,a1
	slli	a3,a3,6
	sb	a5,1104(s2)
	or	a3,t0,a3
	add	a5,sp,a1
	sb	t2,1105(s2)
	sb	a3,1106(a5)
	addi	a1,a1,3
	li	a3,0
.L246:
	lbu	a5,1(a4)
	addi	a4,a4,1
	beq	a5,zero,.L239
	bne	a4,a0,.L238
.L239:
	li	a5,1
	ble	a3,a5,.L249
	lw	a2,648(sp)
	lw	a5,644(sp)
	srai	a4,a2,4
	slli	a5,a5,2
	or	a5,a5,a4
	addi	a4,sp,81
	addi	a4,a4,2047
	add	a4,a4,a1
	sb	a5,-1024(a4)
	li	a4,3
	addi	a5,a1,1
	beq	a3,a4,.L523
	mv	a1,a5
.L249:
	add	a5,sp,a1
	sb	zero,1104(a5)
	li	a5,13
	beq	a1,a5,.L524
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC53)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC53)
	mv	a2,s0
	call	printf
.L255:
	lui	s9,%hi(g_failures)
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L258:
	lui	a0,%hi(.LC55)
	addi	a0,a0,%lo(.LC55)
	call	puts
	li	a3,5
	li	a4,0
	lui	a0,%hi(.LC56)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC56)
	call	check_u64
	li	a3,300
	li	a4,0
	lui	a0,%hi(.LC57)
	mv	a1,a3
	mv	a2,a4
	addi	a0,a0,%lo(.LC57)
	call	check_u64
	lui	a0,%hi(.LC58)
	addi	a0,a0,%lo(.LC58)
	call	puts
	li	a5,-45989888
	addi	a5,a5,257
	sw	a5,644(sp)
	li	s10,1
	li	a5,88
	sb	a5,648(sp)
	mv	s7,s10
	li	s4,0
	li	s2,0
	li	s6,-128
	li	s5,4
	j	.L262
.L259:
	addi	a4,sp,81
	addi	a4,a4,2047
	sub	s10,s7,a5
	add	a4,a4,s3
	mv	a2,s10
	add	a0,s0,s4
	addi	s2,s2,2
	bne	a5,s6,.L525
	mv	s2,s3
.L260:
	addi	a5,sp,81
	addi	a5,a5,2047
	add	a5,a5,s2
	bgtu	s2,s5,.L261
.L526:
	lbu	s10,-1484(a5)
.L262:
	sext.b	a5,s10
	addi	s3,s2,1
	blt	a5,zero,.L259
	add	a1,s1,s3
	add	a0,s0,s4
	addi	a2,s10,1
	call	memcpy
	add	s3,s3,s10
	addi	a5,sp,81
	addi	s4,s4,1
	addi	s2,s3,1
	addi	a5,a5,2047
	add	s4,s4,s10
	add	a5,a5,s2
	bleu	s2,s5,.L526
.L261:
	li	a5,6
	beq	s4,a5,.L527
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC60)
	mv	a2,s4
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC60)
	mv	a3,s0
	call	printf
.L268:
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L271:
	lui	a0,%hi(.LC61)
	addi	a0,a0,%lo(.LC61)
	call	puts
	li	a5,-48
	sb	a5,128(sp)
	li	t6,0
	li	a3,0
	li	a5,0
	li	a0,0
	li	a7,8
	li	t0,6
	li	t3,7
	li	t1,208
.L272:
	addi	a4,a5,1
	beq	a4,a7,.L273
.L529:
	sub	a5,t3,a5
	bext	a2,t1,a5
	beq	a2,zero,.L528
	mv	a5,a4
	addi	a4,a5,1
	addi	a0,a0,1
	bne	a4,a7,.L529
.L273:
	addi	t4,a0,1
	beq	t4,zero,.L277
	li	a0,1
	li	a4,0
.L275:
	mv	t5,t6
	li	a1,0
.L278:
	addi	a3,a3,1
	addi	a1,a1,1
	addi	a2,a3,-6
	snez	a2,a2
	sltu	a5,a1,t4
	add	a6,s0,a3
	and	a5,a5,a2
	sb	t5,-1(a6)
	bne	a5,zero,.L278
	beq	a3,t0,.L279
	bne	a0,zero,.L277
.L508:
	xori	t6,t6,1
	mv	a5,a4
	j	.L272
.L513:
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,1
	j	.L219
.L240:
	bgtu	a5,t4,.L244
	addi	a2,a5,-65
	bgtu	a5,t5,.L242
	j	.L246
.L525:
	lbu	a1,-1484(a4)
	add	s4,s4,s10
	call	memset
	j	.L260
.L244:
	addi	a2,a5,-97
	andi	a2,a2,0xff
	bgtu	a2,t6,.L246
	addi	a2,a5,-71
	j	.L242
.L415:
	li	a2,62
	j	.L242
.L241:
	addi	a5,a5,4
	andi	a2,a5,0xff
	j	.L242
.L528:
	addi	t4,a0,1
	li	a0,0
	bne	t4,zero,.L275
	j	.L508
.L277:
	lbu	a2,1104(sp)
	lbu	a3,1105(sp)
	lbu	a4,1106(sp)
	lbu	a5,1107(sp)
	lbu	a6,1108(sp)
	lbu	a7,1109(sp)
.L414:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC77)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC77)
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L405:
	lui	a0,%hi(.LC62)
	addi	a0,a0,%lo(.LC62)
	call	puts
	mv	a4,s1
	li	a5,0
	li	a3,256
.L280:
	sb	a5,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	bne	a5,a3,.L280
	lbu	s2,644(sp)
	addi	s5,sp,60
	lui	s7,%hi(.LC63)
	li	s4,1
	mv	s6,s5
	addi	s3,sp,66
	addi	s7,s7,%lo(.LC63)
	sub	s4,s4,s1
.L285:
	mv	a5,s2
	lbu	s2,0(s7)
	beq	s2,a5,.L281
	mv	a5,s1
.L282:
	mv	a2,a5
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,s2,.L282
	add	a2,s4,a2
	sb	a2,0(s6)
	mv	a1,s1
	addi	a0,sp,645
	call	memmove
.L284:
	sb	s2,644(sp)
	addi	s6,s6,1
	addi	s7,s7,1
	bne	s6,s3,.L285
	mv	a4,s0
	li	a5,0
	li	a3,256
.L286:
	sb	a5,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	bne	a5,a3,.L286
	lbu	a2,0(s5)
	addi	s4,sp,384
	mv	a1,s0
	add	a5,sp,a2
	lbu	s2,1104(a5)
	addi	a0,sp,1105
	sb	s2,0(s4)
	beq	a2,zero,.L287
.L530:
	call	memmove
	addi	s5,s5,1
	sb	s2,1104(sp)
	beq	s5,s3,.L288
.L509:
	lbu	a2,0(s5)
	addi	s4,s4,1
	mv	a1,s0
	add	a5,sp,a2
	lbu	s2,1104(a5)
	addi	a0,sp,1105
	sb	s2,0(s4)
	bne	a2,zero,.L530
.L287:
	sb	s2,1104(sp)
	addi	s5,s5,1
	bne	s5,s3,.L509
.L288:
	lw	a4,384(sp)
	li	a5,1634623488
	addi	a5,a5,354
	beq	a4,a5,.L531
.L443:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC64)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC64)
	addi	a3,sp,384
	li	a2,6
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L294:
	lui	a0,%hi(.LC65)
	addi	a0,a0,%lo(.LC65)
	call	puts
	li	a2,260
	li	a1,0
	addi	a0,sp,384
	call	memset
	li	a5,256
	sw	a5,640(sp)
	li	a5,2
	sb	a5,449(sp)
	li	a5,514
	sh	a5,450(sp)
	li	a1,0
	li	a5,771
	mv	a0,s1
	li	a2,68
	sh	a5,452(sp)
	call	memset
	addi	a4,sp,384
	mv	a5,a4
	addi	a1,sp,640
.L296:
	lbu	a3,0(a5)
	addi	a5,a5,1
	sh2add	a2,a3,s1
	beq	a3,zero,.L295
	lw	a3,0(a2)
	addi	a3,a3,1
	sw	a3,0(a2)
.L295:
	bne	a5,a1,.L296
	lw	s5,648(sp)
	lw	a0,652(sp)
	lw	a6,656(sp)
	lw	a7,660(sp)
	add	s4,a0,s5
	lw	t1,664(sp)
	add	a1,a6,s4
	lw	t3,668(sp)
	add	a3,a7,a1
	lw	t4,672(sp)
	add	a5,t1,a3
	lw	t5,676(sp)
	lw	t6,680(sp)
	sw	a3,80(sp)
	add	a3,t3,a5
	lw	t0,684(sp)
	sw	a5,84(sp)
	add	a5,t4,a3
	lw	t2,688(sp)
	sw	a3,88(sp)
	add	a3,t5,a5
	lw	s2,692(sp)
	sw	a5,92(sp)
	add	a5,t6,a3
	lw	s3,696(sp)
	sw	a3,96(sp)
	add	a3,t0,a5
	add	a2,t2,a3
	sw	s4,72(sp)
	lw	s4,700(sp)
	lw	s6,704(sp)
	sw	a3,104(sp)
	add	a3,s2,a2
	sw	a2,108(sp)
	add	a2,s3,a3
	sw	a3,112(sp)
	add	a3,s4,a2
	sw	a5,100(sp)
	sw	a2,116(sp)
	addi	a5,sp,60
	add	a2,s6,a3
	sw	a3,120(sp)
	sw	a2,124(sp)
	sw	a1,76(sp)
	sw	zero,64(sp)
	sw	s5,68(sp)
	addi	a2,a5,64
	mv	a3,s0
.L297:
	lw	a1,8(a5)
	lw	s10,0(a5)
	lw	s7,4(a5)
	sw	a1,8(a3)
	sw	s10,0(a3)
	sw	s7,4(a3)
	lw	a1,12(a5)
	addi	a5,a5,16
	addi	a3,a3,16
	sw	a1,-4(a3)
	bne	a5,a2,.L297
	lw	a2,0(a5)
	li	a1,256
	li	a5,0
	sw	a2,0(a3)
.L299:
	lbu	a3,0(a4)
	addi	a4,a4,1
	sh2add	a2,a3,s0
	beq	a3,zero,.L298
	lw	a3,0(a2)
	addi	s7,a3,1
	add	a3,sp,a3
	sw	s7,0(a2)
	sb	a5,848(a3)
.L298:
	addi	a5,a5,1
	bne	a5,a1,.L299
	slli	s5,s5,1
	add	a2,a0,s5
	slli	a2,a2,1
	add	a1,a6,a2
	slli	a1,a1,1
	add	a0,a7,a1
	slli	a0,a0,1
	add	a6,t1,a0
	slli	a6,a6,1
	add	a7,t3,a6
	slli	a7,a7,1
	add	t1,t4,a7
	slli	t1,t1,1
	add	t3,t5,t1
	slli	t3,t3,1
	add	t4,t6,t3
	slli	t4,t4,1
	add	t5,t0,t4
	slli	t5,t5,1
	add	t6,t2,t5
	slli	t6,t6,1
	add	a5,s2,t6
	slli	a5,a5,1
	add	a4,s3,a5
	slli	a4,a4,1
	add	a3,s4,a4
	slli	a3,a3,1
	add	t0,s6,a3
	slli	t0,t0,1
	sw	a3,772(sp)
	sw	a4,768(sp)
	sw	a5,764(sp)
	sw	t0,776(sp)
	sw	t6,760(sp)
	sw	t5,756(sp)
	sw	t4,752(sp)
	sw	t3,748(sp)
	sw	t1,744(sp)
	sw	a7,740(sp)
	sw	a6,736(sp)
	sw	a0,732(sp)
	sw	a1,728(sp)
	sw	a2,724(sp)
	sw	s5,720(sp)
	sw	zero,716(sp)
	addi	a5,sp,64
	addi	a4,sp,784
	addi	a3,sp,128
.L300:
	lw	a2,8(a5)
	lw	a0,0(a5)
	lw	a1,4(a5)
	sw	a2,8(a4)
	sw	a0,0(a4)
	sw	a1,4(a4)
	lw	a2,12(a5)
	addi	a5,a5,16
	addi	a4,a4,16
	sw	a2,-4(a4)
	bne	a5,a3,.L300
	li	a2,512
	li	a1,0
	addi	a0,sp,1616
	call	memset
	mv	s7,s1
	li	s3,1
.L303:
	lw	s4,4(s7)
	ble	s4,zero,.L301
	lw	a4,72(s7)
	lw	s5,140(s7)
	li	a5,9
	sub	s6,a5,s3
	mv	s11,a4
	add	s4,s4,a4
	sub	s5,s5,a4
	bset	s2,x0,s6
.L302:
	add	a4,s5,s11
	add	a4,s1,a4
	lbu	a1,204(a4)
	sll	s10,s11,s6
	mv	a2,s2
	add	a0,s0,s10
	call	memset
	addi	a0,s10,512
	add	a0,s0,a0
	mv	a2,s2
	mv	a1,s3
	addi	s11,s11,1
	call	memset
	bne	s4,s11,.L302
.L301:
	addi	s3,s3,1
	li	a5,10
	addi	s7,s7,4
	bne	s3,a5,.L303
	lui	s6,%hi(.LC6)
	lui	s10,%hi(.LC6+5)
	lui	s2,%hi(.LC66)
	sb	zero,128(sp)
	addi	s6,s6,%lo(.LC6)
	addi	s10,s10,%lo(.LC6+5)
	addi	s2,s2,%lo(.LC66)
	li	a3,2
	li	s3,0
	li	s4,0
	li	a1,65
	addi	s11,sp,652
	li	s7,7
	li	s5,-1
.L317:
	beq	a3,zero,.L304
	sh2add	a5,a3,s1
	lw	a2,0(a5)
	ble	a2,zero,.L304
	sh2add	a5,a3,s11
	lw	a0,128(a5)
	li	a5,0
	j	.L307
.L305:
	addi	a5,a5,1
	beq	a2,a5,.L304
.L307:
	add	a4,a0,a5
	add	a4,s1,a4
	lbu	a4,204(a4)
	bne	a1,a4,.L305
	sh2add	a4,a3,sp
	lw	a2,712(a4)
	li	a0,8
	addi	a4,a3,-1
	add	a5,a5,a2
.L306:
	addi	a3,a4,-32
	blt	a3,zero,.L532
.L312:
	addi	s3,s3,1
	bne	s3,a0,.L311
	addi	s4,s4,1
	add	a3,sp,s4
	addi	a4,a4,-1
	sb	zero,128(a3)
	addi	a3,a4,-32
	beq	a4,s5,.L533
	bext	s3,a5,a4
	blt	a3,zero,.L534
.L421:
	li	s3,1
.L311:
	addi	a4,a4,-1
	bne	a4,s5,.L306
.L308:
	beq	s6,s10,.L316
.L535:
	lbu	a1,1(s6)
	addi	s6,s6,1
	add	a5,sp,a1
	lbu	a3,384(a5)
	j	.L317
.L534:
	add	a3,s8,s4
	beq	s3,zero,.L421
	lbu	a2,0(a3)
	ori	a2,a2,-128
	sb	a2,0(a3)
	j	.L311
.L532:
	bext	a2,a5,a4
	add	a3,s8,s4
	sub	a1,s7,s3
	beq	a2,zero,.L312
	lbu	a2,0(a3)
	bset	a2,a2,a1
	sb	a2,0(a3)
	j	.L312
.L304:
	mv	a0,s2
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
	bne	s6,s10,.L535
.L316:
	li	a5,4096
	addi	a5,a5,-2004
	add	t0,sp,a5
	sgt	s2,s3,zero
	add	s2,s2,s4
	addi	t5,t0,-2048
	addi	t6,t0,-2042
	li	a3,0
	li	a7,0
	li	t1,7
	li	t3,8
	li	t4,17
.L318:
	addi	a0,s1,4
	li	a6,1
	li	a5,0
.L322:
	addi	a4,sp,81
	addi	a4,a4,2047
	add	a1,a4,a7
	slli	a5,a5,1
	sub	a4,t1,a3
	bleu	s2,a7,.L422
	lbu	a1,-2000(a1)
	addi	a3,a3,1
	bext	a1,a1,a4
	bne	a3,t3,.L320
	addi	a7,a7,1
	li	a3,0
.L320:
	lw	a4,0(a0)
	or	a5,a1,a5
	ble	a4,zero,.L321
	lw	a1,68(a0)
	sub	a2,a5,a1
	slt	a1,a5,a1
	sgt	a4,a4,a2
	seqz	a1,a1
	and	a4,a4,a1
	bne	a4,zero,.L536
.L321:
	addi	a6,a6,1
	addi	a0,a0,4
	bne	a6,t4,.L322
.L422:
	li	a5,255
.L319:
	sb	a5,0(t5)
	addi	t5,t5,1
	bne	t6,t5,.L318
	lw	a3,-2048(t0)
	li	a5,1145257984
	sb	zero,50(sp)
	addi	a5,a5,577
	addi	a2,t0,-2048
	beq	a3,a5,.L537
.L444:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC67)
	addi	a2,t0,-2048
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC67)
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L327:
	addi	a1,sp,60
	addi	a6,sp,66
	li	a4,0
	li	a3,0
	li	a0,7
	li	a2,8
.L345:
	bleu	s2,a3,.L423
	add	a5,sp,a3
	lbu	a7,128(a5)
	sub	a5,a0,a4
	addi	t1,a4,1
	bext	a5,a7,a5
	mv	t3,a5
	beq	t1,a2,.L538
	sub	t1,a0,t1
	bext	t1,a7,t1
	slli	a5,a5,1
	addi	t3,a4,2
	or	a5,t1,a5
	bne	t3,a2,.L539
	addi	t1,a3,1
	bleu	s2,t1,.L331
	add	a7,sp,t1
	lbu	a7,128(a7)
	slli	a5,a5,1
	li	t4,3
	srai	t3,a7,7
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,6
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,5
	or	a5,a5,t3
	li	t5,2
.L332:
	li	t3,7
	sub	t3,t3,t4
	slli	a5,a5,1
	bext	t3,a7,t3
	or	t3,t3,a5
	addi	t5,t5,2
	li	a5,8
	bne	t5,a5,.L334
	addi	t1,t1,1
	bleu	s2,t1,.L339
	add	t1,sp,t1
	lbu	a7,128(t1)
	slli	t3,t3,1
	li	t5,2
	srai	a5,a7,7
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t4,a7,6
.L338:
	or	t4,t4,a5
	sub	a5,a0,t5
.L395:
	bext	a5,a7,a5
.L341:
	slli	a7,t4,1
	or	a5,a5,a7
	addi	a7,sp,81
	addi	a7,a7,2047
	add	a5,a7,a5
	lbu	a7,-512(a5)
	beq	a7,zero,.L425
	lbu	t1,-1024(a5)
	bleu	s2,a3,.L342
	li	a5,0
	j	.L344
.L409:
	bleu	s2,a3,.L342
.L344:
	addi	a4,a4,1
	bne	a4,a2,.L343
	addi	a3,a3,1
	li	a4,0
.L343:
	addi	a5,a5,1
	bne	a7,a5,.L409
.L342:
	sb	t1,0(a1)
	addi	a1,a1,1
	bne	a1,a6,.L345
	lw	a3,60(sp)
	li	a5,1145257984
	sb	zero,66(sp)
	addi	a5,a5,577
	addi	a2,sp,60
	beq	a3,a5,.L540
.L445:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC68)
	addi	a2,sp,60
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC68)
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L349:
	lui	a0,%hi(.LC69)
	addi	a0,a0,%lo(.LC69)
	call	puts
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	a3,96(a5)
	lw	a4,100(a5)
	lw	a2,92(a5)
	sw	a3,1108(sp)
	sw	a4,1112(sp)
	lw	a3,108(a5)
	lw	a4,112(a5)
	sw	a2,1104(sp)
	sw	a3,1120(sp)
	lw	a2,104(a5)
	lw	a3,120(a5)
	sw	a4,1124(sp)
	lw	a4,124(a5)
	sw	a2,1116(sp)
	sw	a3,1132(sp)
	lw	a2,116(a5)
	lw	a3,128(a5)
	sw	a4,1136(sp)
	lw	a4,132(a5)
	lw	a5,136(a5)
	sw	a2,1128(sp)
	sw	a3,1140(sp)
	sw	a4,1144(sp)
	sw	a5,1148(sp)
	mv	a1,s0
	addi	t6,sp,1152
	li	a2,0
	li	t0,11
	li	t2,2
	j	.L357
.L542:
	lbu	a4,4(a1)
	add	a5,sp,a2
	addi	a2,a2,1
	sb	a4,644(a5)
.L351:
	addi	a1,a1,12
	beq	t6,a1,.L541
.L357:
	lw	a5,8(a1)
	beq	a5,zero,.L542
	lhu	t5,2(a1)
	beq	t5,zero,.L351
	lhu	a5,0(a1)
	addi	a4,t5,-1
	sub	t1,a2,a5
	bleu	a4,t0,.L352
	addi	a4,a5,-1
	bleu	a4,t2,.L352
	add	a3,s1,t1
	neg	a5,a3
	andi	a4,a5,3
	beq	a4,zero,.L427
	lbu	a0,0(a3)
	add	a3,sp,a2
	andi	a5,a5,2
	sb	a0,644(a3)
	addi	t4,a2,1
	li	s4,1
	beq	a5,zero,.L353
	addi	a5,sp,81
	addi	a5,a5,2047
	add	a5,a5,t1
	lbu	a3,-1483(a5)
	addi	a0,sp,81
	addi	a0,a0,2047
	add	t4,a0,t4
	sb	a3,-1484(t4)
	li	a3,3
	addi	t4,a2,2
	li	s4,2
	bne	a4,a3,.L353
	lbu	a5,-1482(a5)
	add	t4,a0,t4
	mv	s4,a4
	sb	a5,-1484(t4)
	add	t4,a2,a4
.L353:
	sub	s3,t5,a4
	add	a5,a4,a2
	andi	s2,s3,-4
	add	a5,s1,a5
	add	a4,a4,t1
	add	a3,s1,a4
	add	t3,a5,s2
.L354:
	lw	a4,0(a3)
	addi	a5,a5,4
	addi	a3,a3,4
	srli	a7,a4,8
	srli	a6,a4,16
	srli	a0,a4,24
	sb	a4,-4(a5)
	sb	a7,-3(a5)
	sb	a6,-2(a5)
	sb	a0,-1(a5)
	bne	t3,a5,.L354
	beq	s3,s2,.L355
	addi	a5,sp,81
	addi	a5,a5,2047
	add	a3,s2,s4
	add	a5,a5,t1
	add	a4,a5,a3
	lbu	a0,-1484(a4)
	addi	a6,sp,81
	add	a4,t4,s2
	addi	a6,a6,2047
	add	a4,a6,a4
	sb	a0,-1484(a4)
	addi	a0,a3,1
	ble	t5,a0,.L355
	add	a0,a5,a0
	lbu	a6,-1484(a0)
	addi	a0,a3,2
	sb	a6,-1483(a4)
	ble	t5,a0,.L355
	add	a0,a5,a0
	lbu	a6,-1484(a0)
	addi	a0,a3,3
	sb	a6,-1482(a4)
	ble	t5,a0,.L355
	add	a0,a5,a0
	lbu	a6,-1484(a0)
	addi	a0,a3,4
	sb	a6,-1481(a4)
	ble	t5,a0,.L355
	add	a0,a5,a0
	lbu	a6,-1484(a0)
	addi	a0,a3,5
	sb	a6,-1480(a4)
	ble	t5,a0,.L355
	add	a0,a5,a0
	lbu	a0,-1484(a0)
	addi	a3,a3,6
	sb	a0,-1479(a4)
	ble	t5,a3,.L355
	add	a5,a5,a3
	lbu	a5,-1484(a5)
	sb	a5,-1478(a4)
.L355:
	add	a2,a2,t5
.L553:
	addi	a1,a1,12
	bne	t6,a1,.L357
.L541:
	li	a5,9
	beq	a2,a5,.L543
.L358:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC71)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC71)
	mv	a3,s1
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L362:
	lui	a0,%hi(.LC72)
	addi	a0,a0,%lo(.LC72)
	call	puts
	li	a5,50724864
	addi	a5,a5,456
	sw	a5,644(sp)
	li	t0,1
	li	a5,98
	sb	a5,648(sp)
	mv	t5,s0
	sub	t0,t0,s1
	li	a4,0
	li	t6,0
	li	t4,0
	li	s2,0
	li	t3,31
	li	t2,4
.L366:
	add	a1,s1,a4
	li	a2,0
	li	a0,0
	li	a6,0
	j	.L365
.L545:
	sll	a3,a4,a3
	sext.b	a5,a5
	li	a4,0
	or	a0,a0,a4
	or	a6,a6,a3
	mv	a4,a1
	addi	a2,a2,7
	addi	a1,a1,1
	bge	a5,zero,.L544
.L365:
	lbu	a5,0(a1)
	addi	a3,a2,-32
	sub	a7,t3,a2
	andi	a4,a5,127
	srli	t1,a4,1
	bge	a3,zero,.L545
	sll	a4,a4,a2
	srl	a3,t1,a7
	sext.b	a5,a5
	or	a0,a0,a4
	or	a6,a6,a3
	mv	a4,a1
	addi	a2,a2,7
	addi	a1,a1,1
	blt	a5,zero,.L365
.L544:
	andi	a5,a0,1
	slli	a3,a6,31
	srli	a0,a0,1
	add	a0,a3,a0
	neg	a3,a5
	srli	a6,a6,1
	xor	a3,a3,a0
	neg	a5,a5
	add	a3,t4,a3
	xor	a5,a5,a6
	sltu	a2,a3,t4
	add	a5,s2,a5
	add	s2,a2,a5
	sw	a3,0(t5)
	sw	s2,4(t5)
	add	a4,t0,a4
	mv	t4,a3
	addi	t6,t6,1
	addi	t5,t5,8
	bleu	a4,t2,.L366
	lw	a2,1104(sp)
	lw	a3,1108(sp)
	lw	a4,1112(sp)
	lw	a5,1116(sp)
	lw	a6,1120(sp)
	lw	a7,1124(sp)
	lw	t3,1128(sp)
	lw	t1,1132(sp)
	beq	t6,t2,.L546
.L367:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC76)
	sw	t3,0(sp)
	sw	t1,4(sp)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC76)
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
.L394:
	lui	a0,%hi(.LC73)
	addi	a0,a0,%lo(.LC73)
	call	puts
	li	a5,1359872
	addi	a5,a5,287
	sw	a5,128(sp)
	mv	a2,s0
	li	t5,0
	li	a4,0
	li	a3,0
	li	a6,4
	li	a0,7
	li	a1,8
	li	a7,5
.L406:
	beq	a4,a6,.L510
	addi	a5,sp,81
	addi	a5,a5,2047
	add	t3,a5,a4
.L371:
	lbu	t4,-2000(t3)
	sub	a5,a0,t5
	addi	t1,t5,1
	bext	a5,t4,a5
	beq	t1,a1,.L547
	sub	t1,a0,t1
	bext	t1,t4,t1
	slli	a5,a5,1
	addi	t6,t5,2
	or	a5,t1,a5
	bne	t6,a1,.L548
	addi	a4,a4,1
	beq	a4,a6,.L432
	add	t3,sp,a4
	lbu	t4,128(t3)
	slli	t1,a5,1
	addi	a3,a3,1
	srai	a5,t4,7
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	t1,t4,6
	or	a5,a5,t1
	bexti	t4,t4,5
	slli	a5,a5,1
	or	t4,t4,a5
	sw	t4,0(a2)
	li	t5,3
	beq	a3,a7,.L378
.L408:
	addi	a2,a2,4
	j	.L406
.L538:
	addi	t1,a3,1
	bleu	s2,t1,.L328
	add	a7,sp,t1
	lbu	a7,128(a7)
	slli	a5,a5,1
	li	t5,3
	srai	t3,a7,7
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,6
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,5
	or	a5,a5,t3
	li	t4,2
.L330:
	li	t3,7
	sub	t3,t3,t5
	bext	t3,a7,t3
	slli	a5,a5,1
	or	a5,t3,a5
	addi	t4,t4,2
	li	t3,8
	bne	t4,t3,.L332
	addi	t1,t1,1
	bleu	s2,t1,.L337
	add	t1,sp,t1
	lbu	a7,128(t1)
	slli	t1,a5,1
	li	t5,3
	srai	a5,a7,7
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	t1,a7,6
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	t4,a7,5
	j	.L338
.L539:
	sub	t3,a0,t3
	bext	t3,a7,t3
	slli	a5,a5,1
	addi	t4,a4,3
	or	t3,t3,a5
	bne	t4,a2,.L549
	addi	t1,a3,1
	bleu	s2,t1,.L333
	add	a5,sp,t1
	lbu	a7,128(a5)
	slli	t3,t3,1
	li	t5,3
	srai	a5,a7,7
	or	t3,t3,a5
	slli	t3,t3,1
	bexti	a5,a7,6
	or	t3,t3,a5
	slli	t3,t3,1
	bexti	a5,a7,5
	or	t3,t3,a5
	li	t4,2
.L334:
	li	a5,7
	sub	a5,a5,t5
	slli	t3,t3,1
	bext	a5,a7,a5
	or	a5,a5,t3
	addi	t4,t4,2
	li	t3,8
	bne	t4,t3,.L336
	addi	t1,t1,1
	bleu	s2,t1,.L340
	add	t1,sp,t1
	lbu	a7,128(t1)
	slli	a5,a5,1
	li	t5,1
	srai	t4,a7,7
	j	.L338
.L547:
	addi	a4,a4,1
	beq	a4,a6,.L431
	addi	t1,sp,81
	addi	t1,t1,2047
	add	t3,t1,a4
	lbu	t4,-2000(t3)
	slli	t1,a5,1
	li	t0,3
	srai	a5,t4,7
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	t1,t4,6
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	t1,t4,5
	or	a5,a5,t1
	li	t6,2
.L373:
	li	t1,7
	addi	t5,t6,2
	sub	t1,t1,t0
	li	t6,8
	bext	t4,t4,t1
	bne	t5,t6,.L550
	slli	a5,a5,1
	or	t4,t4,a5
	sw	t4,0(a2)
	addi	a3,a3,1
	addi	a4,a4,1
	li	t5,0
	bne	a3,a7,.L408
.L378:
	lw	a2,1104(sp)
	li	a1,3
	lw	a3,1108(sp)
	lw	a4,1112(sp)
	lw	a5,1116(sp)
	lw	a6,1120(sp)
	beq	a2,a1,.L551
.L382:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC75)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC75)
	call	printf
	lw	a5,%lo(g_failures)(s9)
	addi	a5,a5,1
	sw	a5,%lo(g_failures)(s9)
	mv	a2,a5
.L385:
	bne	a2,zero,.L433
	lui	a1,%hi(.LC7)
	addi	a1,a1,%lo(.LC7)
.L384:
	lui	a0,%hi(.LC74)
	addi	a0,a0,%lo(.LC74)
	call	printf
	lw	a0,%lo(g_failures)(s9)
	addi	sp,sp,160
	lw	ra,2028(sp)
	lw	s0,2024(sp)
	lw	s1,2020(sp)
	lw	s2,2016(sp)
	lw	s3,2012(sp)
	lw	s4,2008(sp)
	lw	s5,2004(sp)
	lw	s6,2000(sp)
	lw	s7,1996(sp)
	lw	s8,1992(sp)
	lw	s9,1988(sp)
	lw	s10,1984(sp)
	lw	s11,1980(sp)
	snez	a0,a0
	addi	sp,sp,2032
	jr	ra
.L548:
	sub	t1,a0,t6
	bext	t1,t4,t1
	slli	a5,a5,1
	addi	t6,t5,3
	or	t1,t1,a5
	bne	t6,a1,.L552
	addi	t4,a4,1
	beq	t4,a6,.L376
	addi	a5,sp,81
	addi	a5,a5,2047
	add	t3,a5,t4
	lbu	a4,-2000(t3)
	slli	t1,t1,1
	addi	a3,a3,1
	srai	a5,a4,7
	or	a5,a5,t1
	slli	a5,a5,1
	bexti	a4,a4,6
	or	a5,a5,a4
	sw	a5,0(a2)
	beq	a3,a7,.L378
	addi	a2,a2,4
	mv	a4,t4
	li	t5,2
	j	.L371
.L533:
	li	s3,0
	j	.L308
.L536:
	sh2add	a6,a6,sp
	lw	a4,780(a6)
	add	a5,sp,a2
	add	a5,a5,a4
	lbu	a5,848(a5)
	j	.L319
.L281:
	sb	zero,0(s6)
	j	.L284
.L433:
	lui	a1,%hi(.LC8)
	addi	a1,a1,%lo(.LC8)
	j	.L384
.L427:
	mv	t4,a2
	li	s4,0
	j	.L353
.L352:
	add	a6,s1,t5
	sub	a3,a5,a2
	add	a6,a6,t1
	add	a5,s1,t1
.L356:
	lbu	a0,0(a5)
	add	a4,a3,a5
	add	a4,a4,a2
	sb	a0,0(a4)
	addi	a5,a5,1
	bne	a6,a5,.L356
	add	a2,a2,t5
	j	.L553
.L540:
	lhu	a4,4(a2)
	li	a5,16384
	addi	a5,a5,325
	bne	a4,a5,.L445
	lbu	a5,6(a2)
	bne	a5,zero,.L445
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC68)
	addi	a1,a1,%lo(.LC52)
	addi	a0,a0,%lo(.LC68)
	call	printf
	j	.L349
.L527:
	lui	s2,%hi(.LC59)
	addi	s2,s2,%lo(.LC59)
	lw	a5,0(s2)
	lw	a4,1104(sp)
	bne	a4,a5,.L266
	lhu	a4,4(s0)
	lhu	a5,4(s2)
	bne	a4,a5,.L266
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC60)
	addi	a1,a1,%lo(.LC52)
	addi	a0,a0,%lo(.LC60)
	mv	a3,s0
	mv	a2,s4
	call	printf
.L267:
	lw	a4,1104(sp)
	lw	a5,0(s2)
	bne	a4,a5,.L268
	lhu	a5,4(s2)
	lhu	a4,4(s0)
	beq	a4,a5,.L271
	j	.L268
.L537:
	lhu	a4,4(a2)
	li	a5,16384
	addi	a5,a5,325
	bne	a4,a5,.L444
	lbu	a5,6(a2)
	bne	a5,zero,.L444
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC67)
	addi	a1,a1,%lo(.LC52)
	addi	a0,a0,%lo(.LC67)
	call	printf
	j	.L327
.L546:
	li	a1,100
	bne	a2,a1,.L367
	bne	a3,zero,.L367
	li	a1,103
	bne	a4,a1,.L367
	bne	a5,zero,.L367
	li	a1,101
	bne	a6,a1,.L367
	bne	a7,zero,.L367
	li	a1,150
	bne	t3,a1,.L367
	bne	t1,zero,.L367
	li	a4,150
	li	a5,0
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC76)
	sw	a4,0(sp)
	sw	a5,4(sp)
	addi	a1,a1,%lo(.LC52)
	li	a6,101
	li	a7,0
	li	a4,103
	li	a5,0
	li	a2,100
	li	a3,0
	addi	a0,a0,%lo(.LC76)
	call	printf
	j	.L394
.L543:
	lui	a3,%hi(.LC70)
	addi	a3,a3,%lo(.LC70)
	lw	a4,0(a3)
	lw	a5,644(sp)
	bne	a5,a4,.L359
	lw	a5,4(s1)
	lw	a4,4(a3)
	bne	a5,a4,.L359
	lbu	a4,8(a3)
	lbu	a5,8(s1)
	sub	a5,a5,a4
	bne	a5,zero,.L358
.L361:
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC71)
	addi	a1,a1,%lo(.LC52)
	mv	a3,s1
	li	a2,9
	addi	a0,a0,%lo(.LC71)
	call	printf
	j	.L362
.L551:
	li	a1,31
	bne	a3,a1,.L382
	bne	a4,zero,.L382
	li	a1,17
	bne	a5,a1,.L382
	li	a1,8
	bne	a6,a1,.L382
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC75)
	addi	a1,a1,%lo(.LC52)
	addi	a0,a0,%lo(.LC75)
	li	a4,0
	call	printf
	lw	a2,%lo(g_failures)(s9)
	j	.L385
.L531:
	lhu	a4,388(sp)
	li	a5,24576
	addi	a5,a5,366
	bne	a4,a5,.L443
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC64)
	addi	a1,a1,%lo(.LC52)
	addi	a3,sp,384
	li	a2,6
	addi	a0,a0,%lo(.LC64)
	call	printf
	j	.L294
.L516:
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,1
	j	.L225
.L515:
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,2
	j	.L225
.L223:
	sub	a6,a6,a1
	bset	a5,a5,a6
	sb	a5,0(a0)
	addi	a4,a4,3
	bne	a4,a7,.L222
	addi	a3,a3,1
	add	a2,a2,a3
	sb	zero,0(a2)
	li	a4,0
	j	.L222
.L514:
	addi	a3,a3,1
	add	a2,a2,a3
	li	a5,-64
	sb	a5,0(a2)
	li	a4,2
	j	.L222
.L524:
	lui	s2,%hi(.LC51)
	addi	s2,s2,%lo(.LC51)
	lw	a4,0(s2)
	lw	a5,1104(sp)
	bne	a5,a4,.L251
	lw	a5,4(s0)
	lw	a4,4(s2)
	bne	a5,a4,.L251
	lw	a5,8(s0)
	lw	a4,8(s2)
	bne	a5,a4,.L251
	lbu	a5,12(s0)
	lbu	a4,12(s2)
	sub	a5,a5,a4
	beq	a5,zero,.L554
.L253:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC53)
	addi	a1,a1,%lo(.LC54)
	addi	a0,a0,%lo(.LC53)
	mv	a2,s0
	call	printf
.L254:
	lw	a5,1104(sp)
	lw	a4,0(s2)
	bne	a5,a4,.L256
	lw	a5,4(s0)
	lw	a4,4(s2)
	bne	a5,a4,.L256
	lw	a5,8(s0)
	lw	a4,8(s2)
	bne	a5,a4,.L256
	lbu	a4,12(s2)
	lbu	a5,12(s0)
	sub	a5,a5,a4
.L257:
	bne	a5,zero,.L255
	lui	s9,%hi(g_failures)
	j	.L258
.L512:
	addi	a4,a4,1
	add	a3,a3,a4
	sb	zero,0(a3)
	li	a5,2
	j	.L219
.L279:
	lw	a1,1104(sp)
	li	a5,1
	li	a0,16777216
	sh	a5,648(sp)
	sw	a0,644(sp)
	lbu	a2,1104(sp)
	lbu	a3,1105(sp)
	lbu	a4,1106(sp)
	lbu	a5,1107(sp)
	lbu	a6,1108(sp)
	lbu	a7,1109(sp)
	bne	a1,a0,.L414
	lhu	a1,4(s0)
	lhu	a0,4(s1)
	bne	a1,a0,.L414
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC77)
	addi	a1,a1,%lo(.LC52)
	addi	a0,a0,%lo(.LC77)
	call	printf
	j	.L405
.L523:
	lw	a4,652(sp)
	addi	a3,sp,81
	slli	a2,a2,4
	addi	a3,a3,2047
	srai	a4,a4,2
	add	a5,a3,a5
	or	a4,a4,a2
	addi	a1,a1,2
	sb	a4,-1024(a5)
	j	.L249
.L554:
	lui	a1,%hi(.LC52)
	lui	a0,%hi(.LC53)
	addi	a1,a1,%lo(.LC52)
	mv	a2,s0
	addi	a0,a0,%lo(.LC53)
	call	printf
	j	.L254
.L266:
	lui	a1,%hi(.LC54)
	lui	a0,%hi(.LC60)
	addi	a1,a1,%lo(.LC54)
	mv	a3,s0
	li	a2,6
	addi	a0,a0,%lo(.LC60)
	call	printf
	j	.L267
.L425:
	li	t1,255
	j	.L342
.L379:
	slli	a5,a5,1
	sw	a5,0(a2)
	addi	a3,a3,1
	li	a5,5
	beq	a3,a5,.L378
	addi	a2,a2,4
.L510:
	li	a5,0
	slli	a5,a5,1
.L374:
	slli	t1,a5,1
.L376:
	slli	t1,t1,2
	sw	t1,0(a2)
	addi	a3,a3,1
	li	a5,5
	beq	a3,a5,.L378
	li	a1,3
	bleu	a4,a1,.L555
.L381:
	sh2add	a4,a3,s0
	sw	zero,0(a4)
	addi	a3,a3,1
	bne	a3,a5,.L381
	j	.L378
.L423:
	li	t3,0
.L328:
	slli	a5,t3,1
.L331:
	slli	t3,a5,1
.L333:
	slli	a5,t3,1
.L335:
	slli	a5,a5,1
.L337:
	slli	t3,a5,1
.L339:
	slli	a5,t3,1
.L340:
	slli	t4,a5,1
	li	a5,0
	j	.L341
.L256:
	rev8	a5,a5
	rev8	a4,a4
	sltu	a5,a5,a4
	neg	a5,a5
	ori	a5,a5,1
	j	.L257
.L431:
	li	a4,3
	slli	a5,a5,1
	j	.L374
.L550:
	slli	a5,a5,1
	or	a5,a5,t4
	sw	a5,0(a2)
	addi	a3,a3,1
	li	a5,5
	beq	a3,a5,.L378
	addi	a2,a2,4
	j	.L371
.L552:
	sub	a5,a0,t6
	slli	t1,t1,1
	bext	a5,t4,a5
	addi	t0,t5,4
	or	a5,a5,t1
	bne	t0,a1,.L373
	addi	a4,a4,1
	beq	a4,a6,.L379
	addi	t1,sp,81
	addi	t1,t1,2047
	add	t3,t1,a4
	lbu	t1,-2000(t3)
	slli	a5,a5,1
	addi	a3,a3,1
	srai	t1,t1,7
	or	a5,t1,a5
	sw	a5,0(a2)
	beq	a3,a7,.L378
	addi	a2,a2,4
	li	t5,1
	j	.L371
.L549:
	sub	a5,a0,t4
	slli	t3,t3,1
	bext	a5,a7,a5
	addi	t5,a4,4
	or	a5,a5,t3
	mv	t1,a3
	bne	t5,a2,.L330
	addi	t1,a3,1
	bleu	s2,t1,.L335
	add	a7,sp,t1
	lbu	a7,128(a7)
	slli	a5,a5,1
	li	t4,3
	srai	t3,a7,7
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,6
	or	a5,a5,t3
	slli	a5,a5,1
	bexti	t3,a7,5
	or	a5,a5,t3
	li	t5,2
.L336:
	li	t3,7
	sub	t4,t3,t4
	addi	t5,t5,2
	li	t6,8
	slli	a5,a5,1
	bext	t4,a7,t4
	bne	t5,t6,.L338
	addi	t1,t1,1
	or	t4,t4,a5
	bleu	s2,t1,.L424
	add	t1,sp,t1
	lbu	a7,128(t1)
	mv	a5,t3
	j	.L395
.L424:
	li	a5,0
	j	.L341
.L432:
	li	a4,3
	slli	t1,a5,1
	j	.L376
.L251:
	rev8	a5,a5
	rev8	a4,a4
	sltu	a5,a5,a4
	neg	a5,a5
	ori	a5,a5,1
	bne	a5,zero,.L253
	j	.L554
.L359:
	rev8	a5,a5
	rev8	a4,a4
	sltu	a5,a5,a4
	neg	a5,a5
	ori	a5,a5,1
	beq	a5,zero,.L361
	j	.L358
.L555:
	li	a5,0
	addi	a2,a2,4
	li	a4,4
	slli	a5,a5,1
	j	.L374
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	FIB, @object
	.size	FIB, 92
FIB:
	.word	1
	.word	2
	.word	3
	.word	5
	.word	8
	.word	13
	.word	21
	.word	34
	.word	55
	.word	89
	.word	144
	.word	233
	.word	377
	.word	610
	.word	987
	.word	1597
	.word	2584
	.word	4181
	.word	6765
	.word	10946
	.word	17711
	.word	28657
	.word	46368
.LC0:
	.half	0
	.half	0
	.byte	97
	.zero	3
	.word	0
	.half	0
	.half	0
	.byte	98
	.zero	3
	.word	0
	.half	0
	.half	0
	.byte	99
	.zero	3
	.word	0
	.half	3
	.half	6
	.byte	0
	.zero	3
	.word	1
	.section	.sbss,"aw",@nobits
	.align	2
	.type	g_failures, @object
	.size	g_failures, 4
g_failures:
	.zero	4
	.ident	"GCC: (g6afcc4f6d) 16.1.0"
	.section	.note.GNU-stack,"",@progbits
