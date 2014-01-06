	.file	"select.c"
	.intel_syntax noprefix
	.text
	.type	swap, @function
swap:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-32], edx
	mov	eax, DWORD PTR [rbp-28]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-28]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-4]
	mov	DWORD PTR [rdx], eax
	pop	rbp
	ret
	.size	swap, .-swap
	.type	find, @function
find:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-32], edx
	mov	DWORD PTR [rbp-36], ecx
	mov	eax, DWORD PTR [rbp-28]
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-28]
	mov	DWORD PTR [rbp-8], eax
	jmp	.L3
.L5:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jge	.L4
	mov	edx, DWORD PTR [rbp-4]
	add	DWORD PTR [rbp-4], 1
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	swap
.L4:
	add	DWORD PTR [rbp-8], 1
.L3:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-32]
	jl	.L5
	mov	edx, DWORD PTR [rbp-32]
	mov	ecx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	swap
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-36]
	jne	.L6
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	jmp	.L7
.L6:
	mov	eax, DWORD PTR [rbp-36]
	cmp	eax, DWORD PTR [rbp-4]
	jge	.L8
	mov	eax, DWORD PTR [rbp-4]
	lea	edi, [rax-1]
	mov	edx, DWORD PTR [rbp-36]
	mov	esi, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	ecx, edx
	mov	edx, edi
	mov	rdi, rax
	call	find
	jmp	.L7
.L8:
	mov	eax, DWORD PTR [rbp-4]
	lea	esi, [rax+1]
	mov	ecx, DWORD PTR [rbp-36]
	mov	edx, DWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	find
.L7:
	leave
	ret
	.size	find, .-find
	.globl	select
	.type	select, @function
select:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR [rbp-40], rdi
	mov	DWORD PTR [rbp-44], esi
	mov	DWORD PTR [rbp-48], edx
	mov	eax, DWORD PTR [rbp-44]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-16], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-16]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-4], 1
.L10:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-44]
	jl	.L11
	mov	eax, DWORD PTR [rbp-48]
	lea	ecx, [rax-1]
	mov	eax, DWORD PTR [rbp-44]
	lea	edx, [rax-1]
	mov	rax, QWORD PTR [rbp-16]
	mov	esi, 0
	mov	rdi, rax
	call	find
	mov	DWORD PTR [rbp-20], eax
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	mov	eax, DWORD PTR [rbp-20]
	leave
	ret
	.size	select, .-select
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
