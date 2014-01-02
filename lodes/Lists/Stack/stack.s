	.file	"stack.c"
	.intel_syntax noprefix
	.text
	.globl	push
	.type	push, @function
push:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR [rbp-36], edi
	mov	QWORD PTR [rbp-48], rsi
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+4]
	mov	DWORD PTR [rbp-8], eax
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-12], eax
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-8]
	jne	.L2
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	sal	rax, 3
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-24], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L3
.L4:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax+8]
	mov	ecx, DWORD PTR [rbp-4]
	movsx	rcx, ecx
	sal	rcx, 2
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-4], 1
.L3:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-8]
	jl	.L4
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax+8]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+4]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax+4], edx
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax+8], rdx
.L2:
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax+8]
	mov	edx, DWORD PTR [rbp-12]
	movsx	rdx, edx
	sal	rdx, 2
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-36]
	mov	DWORD PTR [rdx], eax
	leave
	ret
	.size	push, .-push
	.globl	pop
	.type	pop, @function
pop:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	lea	ecx, [rax-1]
	mov	rax, QWORD PTR [rbp-8]
	mov	DWORD PTR [rax], ecx
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	pop	rbp
	ret
	.size	pop, .-pop
	.globl	peek
	.type	peek, @function
peek:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-8], rdi
	mov	rax, QWORD PTR [rbp-8]
	mov	rdx, QWORD PTR [rax+8]
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax]
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	pop	rbp
	ret
	.size	peek, .-peek
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
