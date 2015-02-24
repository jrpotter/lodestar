	.file	"ll.c"
	.intel_syntax noprefix
	.text
	.globl	insert
	.type	insert, @function
insert:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	edi, 16
	call	malloc
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-8]
	mov	edx, DWORD PTR [rbp-28]
	mov	DWORD PTR [rax+8], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	rdx, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], 0
	mov	rax, QWORD PTR [rbp-8]
	leave
	ret
	.size	insert, .-insert
	.globl	delete
	.type	delete, @function
delete:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	lea	rax, [rbp-24]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L4
.L7:
	mov	rax, QWORD PTR [rbp-16]
	mov	eax, DWORD PTR [rax+8]
	cmp	eax, DWORD PTR [rbp-28]
	jne	.L5
	mov	rax, QWORD PTR [rbp-16]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-8]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR [rbp-16]
	mov	rdi, rax
	call	free
	jmp	.L3
.L5:
	mov	rax, QWORD PTR [rbp-16]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-16]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rbp-16], rax
.L4:
	cmp	QWORD PTR [rbp-16], 0
	jne	.L7
.L3:
	leave
	ret
	.size	delete, .-delete
	.globl	contains
	.type	contains, @function
contains:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L9
.L11:
	mov	rax, QWORD PTR [rbp-8]
	mov	eax, DWORD PTR [rax+8]
	cmp	eax, DWORD PTR [rbp-28]
	jne	.L9
	mov	eax, 1
	jmp	.L10
.L9:
	cmp	QWORD PTR [rbp-8], 0
	jne	.L11
	mov	eax, 0
.L10:
	pop	rbp
	ret
	.size	contains, .-contains
	.ident	"GCC: (Debian 4.7.2-5) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
