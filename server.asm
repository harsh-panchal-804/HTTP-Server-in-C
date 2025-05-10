	.file	"server.c"
	.text
	.type	strings_equal, @function
strings_equal:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	%rax, %rdx
	je	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	sete	%al
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	strings_equal, .-strings_equal
	.globl	string_from_cstr
	.type	string_from_cstr, @function
string_from_cstr:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	string_from_cstr, .-string_from_cstr
	.section	.rodata
.LC0:
	.string	"calloc"
.LC1:
	.string	"realloc"
	.text
	.type	split_string, @function
split_string:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movl	%edx, %eax
	movb	%al, -100(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, -56(%rbp)
	movq	$0, -24(%rbp)
	movq	$8, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	$16, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	testq	%rax, %rax
	jne	.L7
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L7:
	movq	-96(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	$0, -64(%rbp)
	jmp	.L8
.L12:
	movq	-96(%rbp), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, -100(%rbp)
	jne	.L9
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rax
	cmpq	%rax, %rdx
	jb	.L10
	movq	-16(%rbp), %rax
	addq	%rax, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L11
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$1, %edi
	call	exit@PLT
.L11:
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
.L10:
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	salq	$4, %rax
	addq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-96(%rbp), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	subq	-72(%rbp), %rax
	movq	%rax, %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	salq	$4, %rax
	addq	%rcx, %rax
	movq	%rdx, 8(%rax)
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	movq	-64(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	-96(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
.L9:
	addq	$1, -64(%rbp)
.L8:
	movq	-64(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jb	.L12
	movq	-96(%rbp), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	cmpq	%rax, -72(%rbp)
	ja	.L13
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rax
	cmpq	%rax, %rdx
	jb	.L14
	movq	-16(%rbp), %rax
	addq	%rax, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.L15
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$1, %edi
	call	exit@PLT
.L15:
	movq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
.L14:
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	salq	$4, %rax
	addq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-96(%rbp), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	subq	-72(%rbp), %rax
	movq	%rax, %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	salq	$4, %rax
	addq	%rcx, %rax
	movq	%rdx, 8(%rax)
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
.L13:
	movq	-88(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	movq	-16(%rbp), %rax
	movq	%rax, 16(%rcx)
	movq	-88(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	split_string, .-split_string
	.type	free_splits, @function
free_splits:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L19
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L19
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 16(%rax)
.L19:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	free_splits, .-free_splits
	.globl	fs_get_metadata
	.type	fs_get_metadata, @function
fs_get_metadata:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$4096, %rsp
	orq	$0, (%rsp)
	subq	$200, %rsp
	.cfi_offset 3, -24
	movq	%rdi, %rax
	movq	%rsi, %rcx
	movq	%rcx, %rdx
	movq	%rax, -4304(%rbp)
	movq	%rdx, -4296(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movb	$0, -4288(%rbp)
	movq	-4296(%rbp), %rax
	cmpq	$4096, %rax
	jbe	.L21
	movq	-4288(%rbp), %rax
	movq	-4280(%rbp), %rdx
	jmp	.L24
.L21:
	movq	-4296(%rbp), %rdx
	movq	-4304(%rbp), %rcx
	leaq	-4128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	-4296(%rbp), %rax
	movb	$0, -4128(%rbp,%rax)
	leaq	-4272(%rbp), %rdx
	leaq	-4128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat@PLT
	testl	%eax, %eax
	jns	.L23
	movq	-4288(%rbp), %rax
	movq	-4280(%rbp), %rdx
	jmp	.L24
.L23:
	movq	-4224(%rbp), %rax
	movq	%rax, -4280(%rbp)
	movb	$1, -4288(%rbp)
	movq	-4288(%rbp), %rax
	movq	-4280(%rbp), %rdx
.L24:
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L25
	call	__stack_chk_fail@PLT
.L25:
	movl	%ecx, %eax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	fs_get_metadata, .-fs_get_metadata
	.globl	WEB_ROOT
	.section	.rodata
.LC2:
	.string	"./www/"
	.section	.data.rel.ro.local,"aw"
	.align 16
	.type	WEB_ROOT, @object
	.size	WEB_ROOT, 16
WEB_ROOT:
	.quad	.LC2
	.quad	7
	.globl	PORT
	.section	.rodata
	.align 2
	.type	PORT, @object
	.size	PORT, 2
PORT:
	.value	6970
	.text
	.type	string_from_view, @function
string_from_view:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, %rax
	movq	%rsi, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rbx
	movq	%rcx, %rax
	movq	%rbx, %rdx
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	string_from_view, .-string_from_view
	.type	view_from_string, @function
view_from_string:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, %rax
	movq	%rsi, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rbx
	movq	%rcx, %rax
	movq	%rbx, %rdx
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	view_from_string, .-view_from_string
	.section	.rodata
.LC3:
	.string	"OK"
.LC4:
	.string	"Bad Request"
.LC5:
	.string	"Internal Servor Error"
.LC6:
	.string	"Not Found"
.LC7:
	.string	"Unknown"
	.text
	.globl	http_status_to_string
	.type	http_status_to_string, @function
http_status_to_string:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	cmpl	$500, -4(%rbp)
	je	.L31
	cmpl	$500, -4(%rbp)
	ja	.L32
	cmpl	$404, -4(%rbp)
	je	.L33
	cmpl	$404, -4(%rbp)
	ja	.L32
	cmpl	$200, -4(%rbp)
	je	.L34
	cmpl	$400, -4(%rbp)
	je	.L35
	jmp	.L32
.L34:
	leaq	.LC3(%rip), %rax
	jmp	.L36
.L35:
	leaq	.LC4(%rip), %rax
	jmp	.L36
.L31:
	leaq	.LC5(%rip), %rax
	jmp	.L36
.L33:
	leaq	.LC6(%rip), %rax
	jmp	.L36
.L32:
	leaq	.LC7(%rip), %rax
.L36:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	http_status_to_string, .-http_status_to_string
	.globl	http_req_line_init
	.type	http_req_line_init, @function
http_req_line_init:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -88(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	-80(%rbp), %rax
	movl	$48, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-88(%rbp), %rax
	movq	-80(%rbp), %rcx
	movq	-72(%rbp), %rbx
	movq	%rcx, (%rax)
	movq	%rbx, 8(%rax)
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rbx
	movq	%rcx, 16(%rax)
	movq	%rbx, 24(%rax)
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rbx
	movq	%rcx, 32(%rax)
	movq	%rbx, 40(%rax)
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L39
	call	__stack_chk_fail@PLT
.L39:
	movq	-88(%rbp), %rax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	http_req_line_init, .-http_req_line_init
	.section	.rodata
.LC8:
	.string	"application/octet-stream"
.LC9:
	.string	".html"
.LC10:
	.string	"text/html"
.LC11:
	.string	".css"
.LC12:
	.string	"text/css"
.LC13:
	.string	".js"
.LC14:
	.string	"application/javascript"
.LC15:
	.string	".png"
.LC16:
	.string	"image/png"
.LC17:
	.string	".svg"
.LC18:
	.string	"image/svg+xml"
.LC19:
	.string	".jpg"
.LC20:
	.string	".jpeg"
.LC21:
	.string	"image/jpeg"
	.text
	.globl	get_mime_type
	.type	get_mime_type, @function
get_mime_type:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$46, %esi
	movq	%rax, %rdi
	call	strrchr@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L41
	leaq	.LC8(%rip), %rax
	jmp	.L42
.L41:
	movq	-8(%rbp), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L43
	leaq	.LC10(%rip), %rax
	jmp	.L42
.L43:
	movq	-8(%rbp), %rax
	leaq	.LC11(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L44
	leaq	.LC12(%rip), %rax
	jmp	.L42
.L44:
	movq	-8(%rbp), %rax
	leaq	.LC13(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L45
	leaq	.LC14(%rip), %rax
	jmp	.L42
.L45:
	movq	-8(%rbp), %rax
	leaq	.LC15(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L46
	leaq	.LC16(%rip), %rax
	jmp	.L42
.L46:
	movq	-8(%rbp), %rax
	leaq	.LC17(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L47
	leaq	.LC18(%rip), %rax
	jmp	.L42
.L47:
	movq	-8(%rbp), %rax
	leaq	.LC19(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L48
	movq	-8(%rbp), %rax
	leaq	.LC20(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L49
.L48:
	leaq	.LC21(%rip), %rax
	jmp	.L42
.L49:
	leaq	.LC8(%rip), %rax
.L42:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	get_mime_type, .-get_mime_type
	.section	.rodata
.LC22:
	.string	"HTTP/1.0 %d %s\r\n"
	.align 8
.LC23:
	.string	"Access-Control-Allow-Origin: *\r\n"
.LC24:
	.string	"Content-Type: %s\r\n"
.LC25:
	.string	"Content-Length: %zu\r\n"
.LC26:
	.string	"\r\n"
	.text
	.globl	http_response_generate
	.type	http_response_generate, @function
http_response_generate:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -72(%rbp)
	movl	$0, -20(%rbp)
	movq	$0, -8(%rbp)
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movl	-52(%rbp), %eax
	movl	%eax, %edi
	call	http_status_to_string
	movq	%rax, %rcx
	movl	-52(%rbp), %edx
	movq	-40(%rbp), %rax
	leaq	.LC22(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-8(%rbp), %rdx
	cltq
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	leaq	.LC23(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-8(%rbp), %rdx
	cltq
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-72(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC24(%rip), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-8(%rbp), %rdx
	cltq
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-64(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC25(%rip), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-8(%rbp), %rdx
	cltq
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	leaq	.LC26(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-8(%rbp), %rdx
	cltq
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	http_response_generate, .-http_response_generate
	.section	.rodata
.LC27:
	.string	"send()"
.LC28:
	.string	"send() returned 0"
	.text
	.globl	http_send_response
	.type	http_send_response, @function
http_send_response:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, %rax
	movq	%rdx, %rsi
	movq	%rsi, %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, %rax
	movq	%r8, %rcx
	movq	%rcx, %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rsi
	movl	-20(%rbp), %eax
	movl	$32768, %ecx
	movl	%eax, %edi
	call	send@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jns	.L53
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$0, %eax
	jmp	.L54
.L53:
	cmpq	$0, -8(%rbp)
	jne	.L55
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
.L55:
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movl	-20(%rbp), %eax
	movl	$0, %ecx
	movl	%eax, %edi
	call	send@PLT
	movq	%rax, -8(%rbp)
	movl	$1, %eax
.L54:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	http_send_response, .-http_send_response
	.globl	err_404
	.section	.rodata
.LC29:
	.string	"<p>Error 404 </p>"
	.section	.data.rel.local,"aw"
	.align 16
	.type	err_404, @object
	.size	err_404, 16
err_404:
	.quad	.LC29
	.quad	18
	.section	.rodata
.LC30:
	.string	"sendfile()"
.LC31:
	.string	"socket closed 0 bytes send"
	.text
	.globl	http_serve_file
	.type	http_serve_file, @function
http_serve_file:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$4096, %rsp
	orq	$0, (%rsp)
	subq	$296, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movl	%edi, -4388(%rbp)
	movq	%rdx, %rcx
	movq	%rsi, %rax
	movq	%rdi, %rdx
	movq	%rcx, %rdx
	movq	%rax, -4416(%rbp)
	movq	%rdx, -4408(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	movq	$0, -4360(%rbp)
	movq	$0, -4352(%rbp)
	movb	$1, -4381(%rbp)
	movq	$0, -4376(%rbp)
	movl	$-1, -4380(%rbp)
	movl	$7, %edx
	leaq	.LC2(%rip), %rcx
	leaq	-4144(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	-4408(%rbp), %rdx
	movq	-4416(%rbp), %rax
	movl	$7, %ecx
	leaq	-1(%rcx), %rsi
	leaq	-4144(%rbp), %rcx
	addq	%rsi, %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	memcpy@PLT
	movl	$7, %edx
	movq	-4408(%rbp), %rax
	addq	%rdx, %rax
	subq	$1, %rax
	movb	$0, -4144(%rbp,%rax)
	leaq	-4144(%rbp), %rax
	movq	%rax, %rdi
	call	get_mime_type
	movq	%rax, -4344(%rbp)
	leaq	-4144(%rbp), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	%rdx, %rax
	movq	%rcx, %rdi
	movq	%rax, %rsi
	call	fs_get_metadata
	movl	%eax, %ecx
	movq	%rdx, %rax
	movl	%ecx, -4288(%rbp)
	movq	%rax, -4280(%rbp)
	movzbl	-4288(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L57
	movq	err_404(%rip), %rdx
	movq	8+err_404(%rip), %rax
	movq	%rdx, %rdi
	movq	%rax, %rsi
	call	string_from_view
	movq	%rax, %r12
	movq	%rdx, %r13
	movq	8+err_404(%rip), %rdx
	leaq	-4272(%rbp), %rax
	leaq	.LC10(%rip), %r8
	movq	%rdx, %rcx
	movl	$404, %edx
	movl	$128, %esi
	movq	%rax, %rdi
	call	http_response_generate
	movq	%r12, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	movq	%r13, %rbx
	movq	%rsi, %rdi
	movq	%rbx, %r8
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	movl	-4388(%rbp), %eax
	movq	%rdi, %rcx
	movl	%eax, %edi
	call	http_send_response
	movl	$0, %eax
	jmp	.L68
.L57:
	movq	-4280(%rbp), %rdx
	movq	-4344(%rbp), %rcx
	leaq	-4272(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movl	$200, %edx
	movl	$128, %esi
	movq	%rax, %rdi
	call	http_response_generate
	movq	%rax, -4320(%rbp)
	movq	%rdx, -4312(%rbp)
	movq	-4320(%rbp), %rdx
	movq	-4312(%rbp), %rax
	movq	%rdx, %rdi
	movq	%rax, %rsi
	call	view_from_string
	movq	%rax, -4304(%rbp)
	movq	%rdx, -4296(%rbp)
	movq	-4296(%rbp), %rdx
	movq	-4304(%rbp), %rsi
	movl	-4388(%rbp), %eax
	movl	$32768, %ecx
	movl	%eax, %edi
	call	send@PLT
	movq	%rax, -4336(%rbp)
	cmpq	$0, -4336(%rbp)
	jns	.L59
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movb	$0, -4381(%rbp)
	jmp	.L60
.L59:
	cmpq	$0, -4336(%rbp)
	jne	.L61
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC28(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
.L61:
	leaq	-4144(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -4380(%rbp)
	cmpl	$0, -4380(%rbp)
	jns	.L62
	movb	$0, -4381(%rbp)
	movq	err_404(%rip), %rdx
	movq	8+err_404(%rip), %rax
	movq	%rdx, %rdi
	movq	%rax, %rsi
	call	string_from_view
	movq	%rax, %r12
	movq	%rdx, %r13
	movq	8+err_404(%rip), %rdx
	leaq	-4272(%rbp), %rax
	leaq	.LC10(%rip), %r8
	movq	%rdx, %rcx
	movl	$404, %edx
	movl	$128, %esi
	movq	%rax, %rdi
	call	http_response_generate
	movq	%r12, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	movq	%r13, %rbx
	movq	%rsi, %rdi
	movq	%rbx, %r8
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	movl	-4388(%rbp), %eax
	movq	%rdi, %rcx
	movl	%eax, %edi
	call	http_send_response
	jmp	.L60
.L62:
	movq	-4280(%rbp), %rax
	movq	%rax, -4368(%rbp)
	jmp	.L63
.L66:
	movq	-4368(%rbp), %rcx
	leaq	-4376(%rbp), %rdx
	movl	-4380(%rbp), %esi
	movl	-4388(%rbp), %eax
	movl	%eax, %edi
	call	sendfile@PLT
	movq	%rax, -4328(%rbp)
	cmpq	$0, -4328(%rbp)
	jns	.L64
	leaq	.LC30(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movb	$0, -4381(%rbp)
	jmp	.L60
.L64:
	cmpq	$0, -4328(%rbp)
	jne	.L65
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC31(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	jmp	.L60
.L65:
	movq	-4328(%rbp), %rax
	subq	%rax, -4368(%rbp)
.L63:
	cmpq	$0, -4368(%rbp)
	jne	.L66
	nop
.L60:
	cmpl	$0, -4380(%rbp)
	jle	.L67
	movl	-4380(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
.L67:
	movzbl	-4381(%rbp), %eax
.L68:
	movq	-40(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L69
	call	__stack_chk_fail@PLT
.L69:
	addq	$4392, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	http_serve_file, .-http_serve_file
	.section	.rodata
	.align 8
.LC32:
	.string	"<span style=\"\n    color: red;\n    font-weight: bold;\n\">Hello Harsh Panchal</span>"
	.align 8
.LC33:
	.string	"<span style=\"\n    color: blue;\n    font-weight: bold;\n\">Bye Harsh Panchal</span>"
.LC34:
	.string	"read(client_socket)"
.LC35:
	.string	"Connection closed gracefully"
.LC36:
	.string	"Requests:\n%s"
.LC37:
	.string	"Malformed request (no CRLF)\n"
	.align 8
.LC38:
	.string	"Invalid request line (got %zu parts)\n"
.LC39:
	.string	"/hello"
.LC40:
	.string	"/bye"
.LC41:
	.string	"/index"
.LC42:
	.string	"/"
.LC43:
	.string	"index.html"
.LC44:
	.string	"-------------------"
	.text
	.globl	handle_client
	.type	handle_client, @function
handle_client:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	leaq	-16384(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$264, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -16648(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	-16648(%rbp), %rax
	movl	%eax, -16628(%rbp)
	movq	$0, -16616(%rbp)
	leaq	.LC32(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16592(%rbp)
	movq	%rdx, -16584(%rbp)
	leaq	.LC33(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16576(%rbp)
	movq	%rdx, -16568(%rbp)
	leaq	-16416(%rbp), %rax
	movl	$8192, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	leaq	-16416(%rbp), %rcx
	movl	-16628(%rbp), %eax
	movl	$8191, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -16616(%rbp)
	cmpq	$0, -16616(%rbp)
	jns	.L71
	leaq	.LC34(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	$-1, %rax
	jmp	.L85
.L71:
	cmpq	$0, -16616(%rbp)
	jne	.L73
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L74
.L73:
	leaq	-16416(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC36(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-16416(%rbp), %rdx
	movq	-16616(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	leaq	-16416(%rbp), %rax
	leaq	.LC26(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	movq	%rax, -16608(%rbp)
	cmpq	$0, -16608(%rbp)
	jne	.L75
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$28, %edx
	movl	$1, %esi
	leaq	.LC37(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	-16628(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movq	$-1, %rax
	jmp	.L85
.L75:
	leaq	-16416(%rbp), %rdx
	movq	-16608(%rbp), %rax
	subq	%rdx, %rax
	movq	%rax, -16624(%rbp)
	cmpq	$8191, -16624(%rbp)
	jbe	.L76
	movq	$8191, -16624(%rbp)
.L76:
	movq	-16624(%rbp), %rdx
	leaq	-16416(%rbp), %rcx
	leaq	-8224(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	-8224(%rbp), %rdx
	movq	-16624(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	leaq	-16496(%rbp), %rax
	leaq	-8224(%rbp), %rcx
	movl	$32, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	split_string
	movq	-16488(%rbp), %rax
	cmpq	$3, %rax
	je	.L77
	movq	-16488(%rbp), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC38(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	leaq	-16496(%rbp), %rax
	movq	%rax, %rdi
	call	free_splits
	movl	-16628(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movq	$-1, %rax
	jmp	.L85
.L77:
	leaq	-16464(%rbp), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	http_req_line_init
	movq	-16496(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -16464(%rbp)
	movq	-16496(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -16456(%rbp)
	movq	-16496(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, -16448(%rbp)
	movq	-16496(%rbp), %rax
	addq	$16, %rax
	movq	8(%rax), %rax
	movq	%rax, -16440(%rbp)
	movq	-16496(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	movq	%rax, -16432(%rbp)
	movq	-16496(%rbp), %rax
	addq	$32, %rax
	movq	8(%rax), %rax
	movq	%rax, -16424(%rbp)
	leaq	-16496(%rbp), %rax
	movq	%rax, %rdi
	call	free_splits
	leaq	.LC39(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16560(%rbp)
	movq	%rdx, -16552(%rbp)
	leaq	.LC40(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16544(%rbp)
	movq	%rdx, -16536(%rbp)
	leaq	.LC41(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16528(%rbp)
	movq	%rdx, -16520(%rbp)
	leaq	.LC42(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, -16512(%rbp)
	movq	%rdx, -16504(%rbp)
	movq	-16448(%rbp), %rax
	movq	%rax, %rdi
	call	get_mime_type
	movq	%rax, -16600(%rbp)
	leaq	-16560(%rbp), %rax
	leaq	-16464(%rbp), %rdx
	addq	$16, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strings_equal
	testb	%al, %al
	je	.L78
	movq	-16584(%rbp), %rdx
	leaq	-16416(%rbp), %rax
	leaq	.LC10(%rip), %r8
	movq	%rdx, %rcx
	movl	$200, %edx
	movl	$8192, %esi
	movq	%rax, %rdi
	call	http_response_generate
	movq	-16592(%rbp), %rcx
	movq	-16584(%rbp), %r8
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	-16628(%rbp), %eax
	movl	%eax, %edi
	call	http_send_response
	jmp	.L79
.L78:
	leaq	-16544(%rbp), %rax
	leaq	-16464(%rbp), %rdx
	addq	$16, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strings_equal
	testb	%al, %al
	je	.L80
	movq	-16568(%rbp), %rdx
	leaq	-16416(%rbp), %rax
	leaq	.LC10(%rip), %r8
	movq	%rdx, %rcx
	movl	$200, %edx
	movl	$8192, %esi
	movq	%rax, %rdi
	call	http_response_generate
	movq	-16576(%rbp), %rcx
	movq	-16568(%rbp), %r8
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	-16628(%rbp), %eax
	movl	%eax, %edi
	call	http_send_response
	jmp	.L79
.L80:
	leaq	-16528(%rbp), %rax
	leaq	-16464(%rbp), %rdx
	addq	$16, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strings_equal
	testb	%al, %al
	jne	.L81
	leaq	-16512(%rbp), %rax
	leaq	-16464(%rbp), %rdx
	addq	$16, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strings_equal
	testb	%al, %al
	je	.L82
.L81:
	leaq	.LC43(%rip), %rax
	movq	%rax, %rdi
	call	string_from_cstr
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movl	-16628(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	http_serve_file
	xorl	$1, %eax
	testb	%al, %al
	je	.L79
	movq	$-1, %rax
	jmp	.L85
.L82:
	movq	-16448(%rbp), %rcx
	movq	-16440(%rbp), %rdx
	movl	-16628(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	http_serve_file
	xorl	$1, %eax
	testb	%al, %al
	je	.L79
	movq	$-1, %rax
	jmp	.L85
.L79:
	movl	-16628(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	nop
.L74:
	leaq	.LC44(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
.L85:
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L86
	call	__stack_chk_fail@PLT
.L86:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	handle_client, .-handle_client
	.section	.rodata
.LC45:
	.string	"./www"
.LC46:
	.string	"socket"
.LC47:
	.string	"Socket created"
.LC48:
	.string	"0.0.0.0"
.LC49:
	.string	"bind()"
.LC50:
	.string	"bind succeeded"
.LC51:
	.string	"listen()"
.LC52:
	.string	"listen succeeded"
.LC53:
	.string	"Waiting for connections..."
.LC54:
	.string	"Got connection from %s:%d\n"
.LC55:
	.string	"pthread_create()"
.LC56:
	.string	"realloc()"
.LC57:
	.string	"accept()"
	.text
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$168, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$1, %esi
	movl	$13, %edi
	call	signal@PLT
	movl	$0, -164(%rbp)
	movl	$0, -160(%rbp)
	movl	$0, -168(%rbp)
	movl	$0, -156(%rbp)
	movl	$1, -176(%rbp)
	leaq	.LC45(%rip), %rax
	movq	%rax, -112(%rbp)
	movq	WEB_ROOT(%rip), %rdx
	movq	8+WEB_ROOT(%rip), %rax
	movq	%rdx, %rdi
	movq	%rax, %rsi
	call	string_from_view
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	%rdx, %rax
	movq	%rcx, %rdi
	movq	%rax, %rsi
	call	fs_get_metadata
	movl	%eax, %ecx
	movq	%rdx, %rax
	movl	%ecx, -96(%rbp)
	movq	%rax, -88(%rbp)
	movzbl	-96(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L88
	movq	-112(%rbp), %rax
	movl	$493, %esi
	movq	%rax, %rdi
	call	mkdir@PLT
.L88:
	movl	$16, -172(%rbp)
	leaq	-80(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, -160(%rbp)
	cmpl	$-1, -160(%rbp)
	jne	.L89
	leaq	.LC46(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$0, %eax
	jmp	.L103
.L89:
	leaq	.LC47(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	-176(%rbp), %rdx
	movl	-160(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt@PLT
	movl	$6970, %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	htons@PLT
	movw	%ax, -78(%rbp)
	movw	$2, -80(%rbp)
	leaq	-80(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdx
	leaq	.LC48(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	inet_pton@PLT
	leaq	-80(%rbp), %rcx
	movl	-160(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	movl	%eax, -164(%rbp)
	cmpl	$0, -164(%rbp)
	jns	.L91
	leaq	.LC49(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, -168(%rbp)
	jmp	.L92
.L91:
	leaq	.LC50(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	-160(%rbp), %eax
	movl	$4096, %esi
	movl	%eax, %edi
	call	listen@PLT
	movl	%eax, -164(%rbp)
	cmpl	$0, -164(%rbp)
	jns	.L93
	leaq	.LC51(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, -168(%rbp)
	jmp	.L92
.L93:
	leaq	.LC52(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	$0, -136(%rbp)
	movq	$10, -128(%rbp)
	movq	-128(%rbp), %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -144(%rbp)
.L100:
	leaq	.LC53(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	-172(%rbp), %rdx
	leaq	-64(%rbp), %rcx
	movl	-160(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -156(%rbp)
	leaq	-48(%rbp), %rax
	leaq	-64(%rbp), %rdx
	leaq	4(%rdx), %rsi
	movl	$16, %ecx
	movq	%rax, %rdx
	movl	$2, %edi
	call	inet_ntop@PLT
	movzwl	-62(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs@PLT
	movzwl	%ax, %edx
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC54(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-156(%rbp), %eax
	cltq
	movq	%rax, %rdx
	leaq	-152(%rbp), %rax
	movq	%rdx, %rcx
	leaq	handle_client(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movl	%eax, -164(%rbp)
	cmpl	$0, -164(%rbp)
	jns	.L94
	leaq	.LC55(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L99
.L94:
	movq	-136(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -136(%rbp)
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rax, %rdx
	movq	-152(%rbp), %rax
	movq	%rax, (%rdx)
	movq	-136(%rbp), %rax
	addq	$1, %rax
	cmpq	%rax, -128(%rbp)
	jnb	.L96
	salq	-128(%rbp)
	movq	-128(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc@PLT
	movq	%rax, -104(%rbp)
	cmpq	$0, -104(%rbp)
	jne	.L97
	leaq	.LC56(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L92
.L97:
	movq	-104(%rbp), %rax
	movq	%rax, -144(%rbp)
.L96:
	cmpl	$0, -156(%rbp)
	jns	.L100
	leaq	.LC57(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	nop
.L99:
	jmp	.L100
.L92:
	movq	$0, -120(%rbp)
	jmp	.L101
.L102:
	movq	-120(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	$15, %esi
	movq	%rax, %rdi
	call	pthread_kill@PLT
	addq	$1, -120(%rbp)
.L101:
	movq	-120(%rbp), %rax
	cmpq	-136(%rbp), %rax
	jb	.L102
	movl	-160(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	-168(%rbp), %eax
.L103:
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L104
	call	__stack_chk_fail@PLT
.L104:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
