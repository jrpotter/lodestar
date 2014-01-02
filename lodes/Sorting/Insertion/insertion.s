	.file	"insertion.c"
	.intel_syntax noprefix
	.text
	.globl	insertion
	.type	insertion, @function
insertion:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-4], 1
	jmp	.L2
.L6:
	mov	eax, DWORD PTR [rbp-4]
	sub	eax, 1
	mov	DWORD PTR [rbp-8], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	add	rax, 1
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jle	.L4
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	add	rax, 1
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-12], eax
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	add	rax, 1
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-12]
	mov	DWORD PTR [rdx], eax
.L4:
	sub	DWORD PTR [rbp-8], 1
.L3:
	cmp	DWORD PTR [rbp-8], 0
	jns	.L5
	add	DWORD PTR [rbp-4], 1
.L2:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-28]
	jl	.L6
	pop	rbp
	ret
	.size	insertion, .-insertion
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
