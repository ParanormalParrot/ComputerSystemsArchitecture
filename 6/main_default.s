	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0	# первый аргумент функции a 
	movsd	QWORD PTR -16[rbp], xmm1	# второй аргумент функции b
	movsd	QWORD PTR -24[rbp], xmm2	# третий аргумент функции x
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	addsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	f, .-f
	.globl	integrate
	.type	integrate, @function
integrate:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	movsd	QWORD PTR -40[rbp], xmm0	# аргумент функции a
	movsd	QWORD PTR -48[rbp], xmm1	# аргумент функции b   
	mov	DWORD PTR -52[rbp], edi	# аргумент функции lower
	mov	DWORD PTR -56[rbp], esi	 # аргумент функции upper
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0	 # переменная step
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0	# res = 0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -52[rbp]
	movsd	QWORD PTR -16[rbp], xmm0	# i = lower
	jmp	.L4
.L5:
	movsd	xmm0, QWORD PTR -16[rbp]
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -24[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1	# Передача третьего параметра в f
	movapd	xmm1, xmm0	# Передача второго параметра в f
	movq	xmm0, rax	# Передача первого параметра в f
	call	f	# вызов функции f
	movsd	QWORD PTR -64[rbp], xmm0
	movsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1	# Передача третьего параметра в f
	movapd	xmm1, xmm0	# Передача второго параметра в f
	movq	xmm0, rax	# Передача первого параметра в f
	call	f	 # вызов функции f
	addsd	xmm0, QWORD PTR -64[rbp]
	mulsd	xmm0, QWORD PTR -24[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1	
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	addsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
.L4:
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -56[rbp]
	comisd	xmm0, QWORD PTR -16[rbp]
	ja	.L5
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	integrate, .-integrate
	.section	.rodata
.LC3:
	.string	"Insert a(double):"
.LC4:
	.string	"%lf"
.LC5:
	.string	"Insert b(double):"
.LC6:
	.string	"Inser the lower bound(int):"
.LC7:
	.string	"%d"
.LC8:
	.string	"Insert the upper bound(int):"
.LC9:
	.string	"%f"
	.text
	.globl	main
	.type	main, @function
main:   # точка взода в программму
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	pxor	xmm0, xmm0
	movsd	QWORD PTR -16[rbp], xmm0    # a = 0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -24[rbp], xmm0    # b = 0
	mov	DWORD PTR -28[rbp], 0   # lower = 0
	mov	DWORD PTR -32[rbp], -2147483648 # upper = INT_MIN
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT  #  printf("Insert a(double):");
	lea	rax, -16[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%lf", &a);
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT  # printf("Insert b(double):");
	lea	rax, -24[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%lf", &a);
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT  # printf("Inser the lower bound(int):");
	lea	rax, -28[rbp]
	mov	rsi, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%d", &lower);
	jmp	.L8
.L9:
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT  # printf("Insert the upper bound(int):");
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT  # scanf("%d", &upper);
.L8:    #  while (upper <= lower)
	mov	edx, DWORD PTR -32[rbp]
	mov	eax, DWORD PTR -28[rbp]
	cmp	edx, eax
	jle	.L9
	mov	ecx, DWORD PTR -32[rbp]
	mov	edx, DWORD PTR -28[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	esi, ecx	# Передача параметра upper в integrate
	mov	edi, edx	# Передача параметра lower в integrate
	movapd	xmm1, xmm0	# Передача параметра b в integrate 
	movq	xmm0, rax	#  Передача параметра a в integrate
	call	integrate   # вызов функции integrate
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	-1698910392
	.long	1048238066
	.align 8
.LC2:
	.long	0
	.long	1073741824
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4: