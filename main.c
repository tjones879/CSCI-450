#include <stdio.h>

int get_utf_len(unsigned char *ch)
{
    if ((*ch & 0xF0) == 0xF0) {
        *ch &= ~0xF8;
        return 3;
    } else if ((*ch & 0xE0) == 0xE0) {
        *ch &= ~0xF0;
        return 2;
    } else if ((*ch & 0xC0) == 0xC0) {
        *ch &= ~0xE0;
        return 1;
    } else {
        *ch &= ~0x80;
        return 0;
    }
}

int main(int argc, char **argv)
{
    FILE *file;
    char *file_name;
    int i, bytes = 0;
    unsigned int utf = 0;
    unsigned char ch = 0;
    
    if (argv[1])
        file_name = argv[1];
    else
        return 0;

    file = fopen(file_name, "r");

    if (file) {
        while(!feof(file)) {
            ch = fgetc(file);
            if (ch == '\n')
                return 0;

            bytes = get_utf_len(&ch);
            utf = ch;
            for (i = 0; i < bytes; i++) {
                utf <<= 6;
                ch = fgetc(file) & ~0xC0;
                utf |= ch;
            }
            printf("U+%x\n", utf);
        }
        fclose(file);
    }
    return 0;
}

/*
Example input:
$¢€𐍈
Example output:
U+24
U+a2
U+20ac
U+10348
*/
