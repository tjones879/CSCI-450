# HW-1

Due: Aug. 30 2017

Task: Decode a txt file that contains unicode text into the hex
representation of codepoints.

### Compile

```
gcc -o main main.c
./main in.txt
```

### Examples

```
Example input:
$¢€𐍈
```

```
Example output:
U+24
U+a2
U+20ac
U+10348
```
