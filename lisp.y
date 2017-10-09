%{
#include <stdio.h>
#include <string.h>
#include <FlexLexer.h>
#include "lisp.h"

#define DEBUG_PARSER 1

yyFlexLexer lex;
void yyerror(const char *str);
int yywrap();
int yylex() { return lex.yylex(); }
%}

%token INTEGER FLOAT NIL BOOL RESERVED IDENT STRING L_PAREN R_PAREN L_BRACE R_BRACE

%%

file:
    atoms
    {
        #if DEBUG_PARSER
        std::cout << std::endl << "file <- atoms " << std::endl;
        #endif
    };

atoms:
    {
        #if DEBUG_PARSER
        std::cout << "atoms <- EMPTY " << std::endl;
        #endif
    }
    |
    atoms atom
    {
        #if DEBUG_PARSER
        std::cout << "atoms <- atoms atom " << std::endl;
        #endif
    };


atom:
    literal
    {
        #if DEBUG_PARSER
        std::cout << "atom <- literal " << std::endl;
        #endif
    }
    | list
    {
        #if DEBUG_PARSER
        std::cout << "atom <- list " << std::endl;
        #endif
    }
    | vector
    {
        #if DEBUG_PARSER
        std::cout << "atom <- vector " << std::endl;
        #endif
    };

literal:
    INTEGER
    {
        #if DEBUG_PARSER
        std::cout << "literal <- INTEGER " << std::endl;
        #endif
    }
    | FLOAT
    {
        #if DEBUG_PARSER
        std::cout << "literal <- FLOAT " << std::endl;
        #endif
    }
    | BOOL
    {
        #if DEBUG_PARSER
        std::cout << "literal <- BOOL " << std::endl;
        #endif
    }
    | NIL
    {
        #if DEBUG_PARSER
        std::cout << "literal <- NIL " << std::endl;
        #endif
    }
    | STRING
    {
        #if DEBUG_PARSER
        std::cout << "literal <- STRING " << std::endl;
        #endif
    }
    | RESERVED
    {
        #if DEBUG_PARSER
        std::cout << "literal <- RESERVED " << std::endl;
        #endif
    }
    | IDENT
    {
        #if DEBUG_PARSER
        std::cout << "literal <- IDENT " << std::endl;
        #endif
    };

list:
    L_PAREN atoms R_PAREN
    {
        #if DEBUG_PARSER
        std::cout << "list <- atoms " << std::endl;
        #endif
    };

vector:
    L_BRACE atoms R_BRACE
    {
        #if DEBUG_PARSER
        std::cout << "vector <- atoms " << std::endl;
        #endif
    };
%%

int yywrap()
{
    return 1;
}

void yyerror(const char *str)
{
    fprintf(stderr, "error %s\n", str);
}

int main(int argc, char **argv)
{
    yyparse();
    return 0;
}
