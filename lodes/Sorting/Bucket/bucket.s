	.file	"bucket.c"
	.intel_syntax noprefix
	.text
	.type	new, @function
new:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-20]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax+8], 0
	mov	rax, QWORD PTR [rbp-8]
	leave
	ret
	.size	new, .-new
	.type	insert, @function
insert:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L4
	mov	eax, DWORD PTR [rbp-28]
	mov	edi, eax
	call	new
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
	jmp	.L3
.L4:
	mov	QWORD PTR [rbp-8], 0
	jmp	.L6
.L8:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-28]
	jle	.L7
	mov	eax, DWORD PTR [rbp-28]
	mov	edi, eax
	call	new
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rbp-16]
	mov	QWORD PTR [rax+8], rdx
	jmp	.L3
.L7:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-16]
	add	rax, 8
	mov	QWORD PTR [rbp-24], rax
.L6:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	.L8
	mov	eax, DWORD PTR [rbp-28]
	mov	edi, eax
	call	new
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rdx+8], rax
.L3:
	leave
	ret
	.size	insert, .-insert
	.globl	bucket_sort
	.type	bucket_sort, @function
bucket_sort:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR [rbp-56], rdi
	mov	DWORD PTR [rbp-60], esi
	mov	DWORD PTR [rbp-64], edx
	mov	DWORD PTR [rbp-68], ecx
	mov	eax, DWORD PTR [rbp-64]
	cdqe
	mov	esi, 8
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR [rbp-68]
	movapd	xmm2, xmm0
	divsd	xmm2, xmm1
	movapd	xmm1, xmm2
	mov	eax, DWORD PTR [rbp-64]
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	mulsd	xmm0, xmm1
	cvttsd2si	eax, xmm0
	mov	DWORD PTR [rbp-36], eax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-36]
	movsx	rdx, edx
	lea	rcx, [0+rdx*8]
	mov	rdx, QWORD PTR [rbp-32]
	add	rdx, rcx
	mov	esi, eax
	mov	rdi, rdx
	call	insert
	add	DWORD PTR [rbp-4], 1
.L10:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L11
	mov	DWORD PTR [rbp-8], 0
	mov	DWORD PTR [rbp-12], 0
	jmp	.L12
.L15:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*8]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-24], rax
	jmp	.L13
.L14:
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax+8]
	mov	QWORD PTR [rbp-48], rax
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-12], 1
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rbp-24], rax
.L13:
	cmp	QWORD PTR [rbp-24], 0
	jne	.L14
	add	DWORD PTR [rbp-8], 1
.L12:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-64]
	jl	.L15
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	free
	leave
	ret
	.size	bucket_sort, .-bucket_sort
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
