	.file	"heapsort.c"
	.intel_syntax noprefix
	.text
	.globl	heapify
	.type	heapify, @function
heapify:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-32], edx
	mov	eax, DWORD PTR [rbp-32]
	add	eax, eax
	add	eax, 1
	mov	DWORD PTR [rbp-8], eax
	mov	eax, DWORD PTR [rbp-8]
	add	eax, 1
	mov	DWORD PTR [rbp-12], eax
	mov	eax, DWORD PTR [rbp-32]
	mov	DWORD PTR [rbp-4], eax
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-28]
	jge	.L2
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jle	.L2
	mov	eax, DWORD PTR [rbp-8]
	mov	DWORD PTR [rbp-4], eax
.L2:
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-28]
	jge	.L3
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	jle	.L3
	mov	eax, DWORD PTR [rbp-12]
	mov	DWORD PTR [rbp-4], eax
.L3:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-32]
	je	.L1
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-16], eax
	mov	eax, DWORD PTR [rbp-32]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-16]
	mov	DWORD PTR [rdx], eax
	mov	edx, DWORD PTR [rbp-4]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	heapify
.L1:
	leave
	ret
	.size	heapify, .-heapify
	.globl	heapsort
	.type	heapsort, @function
heapsort:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	eax, DWORD PTR [rbp-28]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	sub	eax, 1
	mov	DWORD PTR [rbp-4], eax
	jmp	.L6
.L7:
	mov	edx, DWORD PTR [rbp-4]
	mov	ecx, DWORD PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	heapify
	sub	DWORD PTR [rbp-4], 1
.L6:
	cmp	DWORD PTR [rbp-4], 0
	jns	.L7
	mov	eax, DWORD PTR [rbp-28]
	mov	DWORD PTR [rbp-8], eax
	jmp	.L8
.L9:
	mov	rax, QWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-12], eax
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-24]
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-24]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-12]
	mov	DWORD PTR [rdx], eax
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	edx, 0
	mov	esi, ecx
	mov	rdi, rax
	call	heapify
.L8:
	cmp	DWORD PTR [rbp-8], 0
	setne	al
	sub	DWORD PTR [rbp-8], 1
	test	al, al
	jne	.L9
	leave
	ret
	.size	heapsort, .-heapsort
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
