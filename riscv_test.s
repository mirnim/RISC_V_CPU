	.attribute	4, 16
	.attribute	5, "rv32i2p1"
	.file	"riscv_test.c"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	li	a0, 1234
	sw	a0, 256(zero)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	j	.LBB0_1
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"clang version 24.0.0git (https://github.com/llvm/llvm-project.git 60f965b1f62c0c77bcdb2997ea9bb6603aa0d002)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
