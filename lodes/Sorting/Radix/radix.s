	.file	"radix.c"
	.intel_syntax noprefix
	.text
	.globl	radix
	.type	radix, @function
radix:
	push	rbp
	mov	rbp, rsp
	push	r12
	push	rbx
	sub	rsp, 96
	mov	QWORD PTR [rbp-88], rdi
	mov	DWORD PTR [rbp-92], esi
	mov	DWORD PTR [rbp-96], edx
	mov	DWORD PTR [rbp-20], 0
	jmp	.L2
.L14:
	mov	eax, DWORD PTR [rbp-92]
	cdqe
	sal	rax, 3
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-56], rax
	mov	DWORD PTR [rbp-24], 0
	jmp	.L3
.L4:
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	lea	r12, [rdx+rax]
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-88]
	add	rax, rdx
	mov	ebx, DWORD PTR [rax]
	cvtsi2sd	xmm0, DWORD PTR [rbp-20]
	movabs	rax, 4621819117588971520
	movapd	xmm1, xmm0
	mov	QWORD PTR [rbp-104], rax
	movsd	xmm0, QWORD PTR [rbp-104]
	call	pow
	cvttsd2si	edx, xmm0
	mov	DWORD PTR [rbp-108], edx
	mov	eax, ebx
	mov	edx, eax
	sar	edx, 31
	idiv	DWORD PTR [rbp-108]
	mov	ecx, eax
	mov	edx, 1717986919
	mov	eax, ecx
	imul	edx
	sar	edx, 2
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	edx, ecx
	sub	edx, eax
	mov	DWORD PTR [r12+4], edx
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-88]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-24], 1
.L3:
	mov	eax, DWORD PTR [rbp-24]
	cmp	eax, DWORD PTR [rbp-92]
	jl	.L4
	mov	DWORD PTR [rbp-28], -1
	mov	DWORD PTR [rbp-32], 0
	jmp	.L5
.L7:
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax+4]
	cmp	eax, DWORD PTR [rbp-28]
	jle	.L6
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax+4]
	mov	DWORD PTR [rbp-28], eax
.L6:
	add	DWORD PTR [rbp-32], 1
.L5:
	mov	eax, DWORD PTR [rbp-32]
	cmp	eax, DWORD PTR [rbp-92]
	jl	.L7
	mov	eax, DWORD PTR [rbp-28]
	add	eax, 1
	cdqe
	mov	esi, 4
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-64], rax
	mov	DWORD PTR [rbp-36], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR [rbp-36]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax+4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-64]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-36]
	movsx	rdx, edx
	lea	rcx, [0+rdx*8]
	mov	rdx, QWORD PTR [rbp-56]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx+4]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-64]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx]
	add	edx, 1
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-36], 1
.L8:
	mov	eax, DWORD PTR [rbp-36]
	cmp	eax, DWORD PTR [rbp-92]
	jl	.L9
	mov	DWORD PTR [rbp-40], 0
	mov	DWORD PTR [rbp-44], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR [rbp-40]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-64]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-68], eax
	mov	eax, DWORD PTR [rbp-40]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-64]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-44]
	mov	DWORD PTR [rdx], eax
	mov	eax, DWORD PTR [rbp-68]
	add	DWORD PTR [rbp-44], eax
	add	DWORD PTR [rbp-40], 1
.L10:
	mov	eax, DWORD PTR [rbp-28]
	add	eax, 1
	cmp	eax, DWORD PTR [rbp-40]
	jg	.L11
	mov	DWORD PTR [rbp-48], 0
	jmp	.L12
.L13:
	mov	eax, DWORD PTR [rbp-48]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax+4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-64]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	movsx	rcx, edx
	lea	rsi, [0+rcx*4]
	mov	rcx, QWORD PTR [rbp-88]
	add	rsi, rcx
	mov	ecx, DWORD PTR [rbp-48]
	movsx	rcx, ecx
	lea	rdi, [0+rcx*8]
	mov	rcx, QWORD PTR [rbp-56]
	add	rcx, rdi
	mov	ecx, DWORD PTR [rcx]
	mov	DWORD PTR [rsi], ecx
	add	edx, 1
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-48], 1
.L12:
	mov	eax, DWORD PTR [rbp-48]
	cmp	eax, DWORD PTR [rbp-92]
	jl	.L13
	mov	rax, QWORD PTR [rbp-56]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-64]
	mov	rdi, rax
	call	free
	add	DWORD PTR [rbp-20], 1
.L2:
	mov	eax, DWORD PTR [rbp-20]
	cmp	eax, DWORD PTR [rbp-96]
	jl	.L14
	add	rsp, 96
	pop	rbx
	pop	r12
	pop	rbp
	ret
	.size	radix, .-radix
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
