	.file	"counting.c"
	.intel_syntax noprefix
	.text
	.globl	counting_sort
	.type	counting_sort, @function
counting_sort:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR [rbp-56], rdi
	mov	DWORD PTR [rbp-60], esi
	mov	DWORD PTR [rbp-4], -1
	mov	DWORD PTR [rbp-8], 0
	jmp	.L2
.L4:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-4]
	jle	.L3
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-4], eax
.L3:
	add	DWORD PTR [rbp-8], 1
.L2:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L4
	mov	eax, DWORD PTR [rbp-4]
	add	eax, 1
	cdqe
	mov	esi, 4
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-12], 0
	jmp	.L5
.L6:
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-12]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-56]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-32]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx]
	add	edx, 1
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-12], 1
.L5:
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L6
	mov	DWORD PTR [rbp-16], 1
	jmp	.L7
.L8:
	mov	eax, DWORD PTR [rbp-16]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-16]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-32]
	add	rdx, rcx
	mov	ecx, DWORD PTR [rdx]
	mov	edx, DWORD PTR [rbp-16]
	movsx	rdx, edx
	sub	rdx, 1
	lea	rsi, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-32]
	add	rdx, rsi
	mov	edx, DWORD PTR [rdx]
	add	edx, ecx
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-16], 1
.L7:
	mov	eax, DWORD PTR [rbp-4]
	add	eax, 1
	cmp	eax, DWORD PTR [rbp-16]
	jg	.L8
	mov	eax, DWORD PTR [rbp-60]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-40], rax
	mov	DWORD PTR [rbp-20], 0
	jmp	.L9
.L10:
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	sub	edx, 1
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-20], 1
.L9:
	mov	eax, DWORD PTR [rbp-20]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L10
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	leave
	ret
	.size	counting_sort, .-counting_sort
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
