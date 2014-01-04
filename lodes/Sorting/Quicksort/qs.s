	.file	"qs.c"
	.intel_syntax noprefix
	.text
	.globl	swap
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
	.globl	quicksort
	.type	quicksort, @function
quicksort:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-32], edx
	mov	eax, DWORD PTR [rbp-28]
	cmp	eax, DWORD PTR [rbp-32]
	jge	.L8
.L3:
	mov	eax, DWORD PTR [rbp-28]
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-28]
	mov	DWORD PTR [rbp-8], eax
	jmp	.L5
.L7:
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
	jge	.L6
	mov	edx, DWORD PTR [rbp-4]
	add	DWORD PTR [rbp-4], 1
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	swap
.L6:
	add	DWORD PTR [rbp-8], 1
.L5:
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-32]
	jl	.L7
	mov	edx, DWORD PTR [rbp-32]
	mov	ecx, DWORD PTR [rbp-4]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	swap
	mov	eax, DWORD PTR [rbp-4]
	lea	edx, [rax-1]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	quicksort
	mov	eax, DWORD PTR [rbp-4]
	lea	ecx, [rax+1]
	mov	edx, DWORD PTR [rbp-32]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	quicksort
	jmp	.L2
.L8:
	nop
.L2:
	leave
	ret
	.size	quicksort, .-quicksort
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
