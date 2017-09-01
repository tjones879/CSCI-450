#include <stdio.h>
#include <stdint.h>

/**
 * Attempt to decode the framing of the leading UTF8 byte
 *
 * @param  ch Pointer to first byte of UTF-8 character, modified to contain correct MSB
 * @return    Number of bytes for the current codepoint, -1 if invalid
 */
uint32_t get_utf_len(unsigned char *ch)
{
    /* We only want to match with the exact headers */
    /* Valid UTF8 must always have a zero bit following
       the framing bits ex. 111>0< XXXX */
    if ((*ch & 0xF8) == 0xF0) {
        *ch &= ~0xF8;
        return 3;
    } else if ((*ch & 0xF0) == 0xE0) {
        *ch &= ~0xF0;
        return 2;
    } else if ((*ch & 0xE0) == 0xC0) {
        *ch &= ~0xE0;
        return 1;
    } else if ((*ch & 0x80) != 0x80) {
        *ch &= ~0x80;
        return 0;
    } else {
        return -1;
    }
}

/**
 * Print all valid decoded UTF8 codepoints within a file
 */
void decode_utf(FILE *file)
{
    uint32_t utf = 0;
    unsigned char ch = 0;
    int i, bytes = 0;
    while(!feof(file)) {
        ch = fgetc(file);
        if (ch == '\n')
            continue;

        bytes = get_utf_len(&ch);
        utf = ch;
        for (i = 0; i < bytes; i++) {
            utf <<= 6;
            ch = fgetc(file) & ~0xC0;
            utf |= ch;
        }
	if (bytes >= 0)
            printf("U+%x\n", utf);
    }
}

int main(int argc, char **argv)
{
    FILE *file;
    char *file_name;
    
    if (argv[1])
        file_name = argv[1];
    else
        return 0;

    file = fopen(file_name, "r");

    if (file) {
        decode_utf(file);
        fclose(file);
    }

    return 0;
}
