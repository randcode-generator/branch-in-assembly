global main
 
extern printf
 
section .data
	strEqual: 		db 'edx is equal to 10',0xA,0
	strNotEqual: 	db 'edx is not equal to 10',0xA,0
	fmtStr: 		db 'Argument: %i',0xA,0

section .text
	main:
	
	push 10
	call isValueEqualTo10
	add esp, 4
	
	push 11
	call isValueEqualTo10
	add esp, 4
	ret
	
	isValueEqualTo10:
	push ebp					; save ebp into stack
	mov ebp, esp				; copy esp into ebp

	mov		edx, [ebp+8]		; Copy the first argument into edx
	
	; print out the argument
	sub		esp, 4
	mov		[esp], edx			; Copy edx into address of esp
	; Load the format string into the stack
	sub     esp, 4          	; Allocate space on the stack for one 4 byte parameter
	lea     eax, [fmtStr]		; Load string into eax
	mov     [esp], eax      	; Copy eax into the address of esp

	; Call printf
	call    printf          	; Call printf(3):
								; int printf(const char *format, ...);						
	add		esp, 8

	; compare
	mov		edx, [ebp+8]		; Copy the first argument into edx
	cmp		edx, 10				; Is edx equal to 10?
	jne		else				; Go to else label if edx is not equal to 10

	; Load the format string into the stack
	sub     esp, 4          	; Allocate space on the stack for one 4 byte parameter
	lea     eax, [strEqual]		; Load string into eax
	mov     [esp], eax      	; Copy eax into the address of esp

	; Call printf
	call    printf          	; Call printf(3):
								; int printf(const char *format, ...);
	jmp endBranch
	
	else:
	
	; Load the format string into the stack
	sub     esp, 4          	; Allocate space on the stack for one 4 byte parameter
	lea     eax, [strNotEqual]	; Load string into eax
	mov     [esp], eax      	; Copy eax into the address of esp

	; Call printf
	call    printf          ; Call printf(3):
							; int printf(const char *format, ...);
	endBranch:
	add		esp, 4
	pop ebp
	ret
