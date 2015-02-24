	.file	"ll.c"
	.intel_syntax noprefix
	.text
	.globl	enqueue
	.type	enqueue, @function
enqueue:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR [rbp-36], edi
	mov	QWORD PTR [rbp-48], rsi
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+16]
	mov	DWORD PTR [rbp-8], eax
	lea	edx, [rax+1]
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax+16], edx
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+20]
	mov	DWORD PTR [rbp-12], eax
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-12]
	jne	.L2
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	sal	rax, 3
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-24], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L3
.L4:
	mov	rax, QWORD PTR [rbp-48]
	mov	edx, DWORD PTR [rax+8]
	mov	eax, DWORD PTR [rbp-4]
	add	eax, edx
	mov	edx, eax
	sar	edx, 31
	idiv	DWORD PTR [rbp-12]
	mov	DWORD PTR [rbp-28], edx
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax]
	mov	ecx, DWORD PTR [rbp-28]
	movsx	rcx, ecx
	sal	rcx, 2
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-4], 1
.L3:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-12]
	jl	.L4
	mov	rax, QWORD PTR [rbp-48]
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax+8], 0
	mov	rax, QWORD PTR [rbp-48]
	mov	rdx, QWORD PTR [rbp-24]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-48]
	mov	eax, DWORD PTR [rax+20]
	lea	edx, [rax+rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax+20], edx
	mov	rax, QWORD PTR [rbp-48]
	mov	edx, DWORD PTR [rbp-12]
	mov	DWORD PTR [rax+12], edx
.L2:
	mov	rax, QWORD PTR [rbp-48]
	mov	rsi, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-48]
	mov	ecx, DWORD PTR [rax+12]
	mov	rax, QWORD PTR [rbp-48]
	mov	edi, DWORD PTR [rax+20]
	mov	eax, ecx
	mov	edx, eax
	sar	edx, 31
	idiv	edi
	mov	eax, edx
	cdqe
	sal	rax, 2
	lea	rdx, [rsi+rax]
	mov	eax, DWORD PTR [rbp-36]
	mov	DWORD PTR [rdx], eax
	lea	edx, [rcx+1]
	mov	rax, QWORD PTR [rbp-48]
	mov	DWORD PTR [rax+12], edx
	leave
	ret
	.size	enqueue, .-enqueue
	.globl	dequeue
	.type	dequeue, @function
dequeue:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+16]
	lea	edx, [rax-1]
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax+16], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax+20]
	mov	DWORD PTR [rbp-4], eax
	mov	rax, QWORD PTR [rbp-24]
	mov	ecx, DWORD PTR [rax+8]
	mov	eax, ecx
	mov	edx, eax
	sar	edx, 31
	idiv	DWORD PTR [rbp-4]
	mov	DWORD PTR [rbp-8], edx
	lea	edx, [rcx+1]
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax+8], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR [rbp-8]
	movsx	rdx, edx
	sal	rdx, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	pop	rbp
	ret
	.size	dequeue, .-dequeue
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
