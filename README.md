## HW 2

Write a lexer and parser (using Flex and Bison) that is capable of
producing an AST of your language.

### Compilation

With Bison and Flex installed, call `make` produce an executable file
which can then be called with `./main` if file permissions are set
accordingly.

### TODO

* Convert Bison and Flex to be thread-safe
* Correctly handle unwanted characters while lexing the input
* Add support for location tracking so that useful grammar error messages can be produced
