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
	mov	eax, DWORD PTR [rbp-60]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc
	mov	QWORD PTR [rbp-32], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-4], 1
.L2:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L3
	mov	DWORD PTR [rbp-8], -1
	mov	DWORD PTR [rbp-12], 0
	jmp	.L4
.L6:
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cmp	eax, DWORD PTR [rbp-8]
	jle	.L5
	mov	eax, DWORD PTR [rbp-12]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rbp-8], eax
.L5:
	add	DWORD PTR [rbp-12], 1
.L4:
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L6
	mov	eax, DWORD PTR [rbp-8]
	add	eax, 1
	cdqe
	mov	esi, 4
	mov	rdi, rax
	call	calloc
	mov	QWORD PTR [rbp-40], rax
	mov	DWORD PTR [rbp-16], 0
	jmp	.L7
.L8:
	mov	eax, DWORD PTR [rbp-16]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-16]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-56]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-40]
	add	rdx, rcx
	mov	edx, DWORD PTR [rdx]
	add	edx, 1
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-16], 1
.L7:
	mov	eax, DWORD PTR [rbp-16]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L8
	mov	DWORD PTR [rbp-20], 0
	jmp	.L9
.L10:
	mov	eax, DWORD PTR [rbp-20]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-20]
	movsx	rdx, edx
	lea	rcx, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-40]
	add	rdx, rcx
	mov	ecx, DWORD PTR [rdx]
	mov	edx, DWORD PTR [rbp-20]
	movsx	rdx, edx
	sub	rdx, 1
	lea	rsi, [0+rdx*4]
	mov	rdx, QWORD PTR [rbp-40]
	add	rdx, rsi
	mov	edx, DWORD PTR [rdx]
	add	edx, ecx
	mov	DWORD PTR [rax], edx
	add	DWORD PTR [rbp-20], 1
.L9:
	mov	eax, DWORD PTR [rbp-8]
	add	eax, 1
	cmp	eax, DWORD PTR [rbp-20]
	jg	.L10
	mov	DWORD PTR [rbp-24], 0
	jmp	.L11
.L12:
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-40]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	sub	edx, 1
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR [rax]
	cdqe
	lea	rdx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-56]
	add	rdx, rax
	mov	eax, DWORD PTR [rbp-24]
	cdqe
	lea	rcx, [0+rax*4]
	mov	rax, QWORD PTR [rbp-32]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR [rbp-24], 1
.L11:
	mov	eax, DWORD PTR [rbp-24]
	cmp	eax, DWORD PTR [rbp-60]
	jl	.L12
	mov	rax, QWORD PTR [rbp-32]
	mov	rdi, rax
	call	free
	mov	rax, QWORD PTR [rbp-40]
	mov	rdi, rax
	call	free
	leave
	ret
	.size	counting_sort, .-counting_sort
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR [rbp-48], 5
	mov	DWORD PTR [rbp-44], 3
	mov	DWORD PTR [rbp-40], 4
	mov	DWORD PTR [rbp-36], 4
	mov	DWORD PTR [rbp-32], 5
	mov	DWORD PTR [rbp-28], 2
	mov	DWORD PTR [rbp-24], 9
	mov	DWORD PTR [rbp-20], 8
	mov	DWORD PTR [rbp-16], 5
	mov	DWORD PTR [rbp-12], 6
	lea	rax, [rbp-48]
	mov	esi, 10
	mov	rdi, rax
	call	counting_sort
	mov	DWORD PTR [rbp-4], 0
	jmp	.L14
.L15:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	mov	eax, DWORD PTR [rbp-48+rax*4]
	mov	esi, eax
	mov	edi, OFFSET FLAT:.LC0
	mov	eax, 0
	call	printf
	add	DWORD PTR [rbp-4], 1
.L14:
	cmp	DWORD PTR [rbp-4], 9
	jle	.L15
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
