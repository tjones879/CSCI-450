%option noyywrap c++

%{
#include <stdio.h>
#include <math.h>

#include "lisp.h"
#include "tab.hpp"

int yylex(void);
void yyerror(char *);
%}

SIGN "-"|"+"
ALPHA [a-zA-Z]
DIGIT [0-9]
SYMBOL "-"|"+"|"/"|"*"|"<"|">"|"="|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"\\"

%%
(;.*) {
        printf("A comment: %s\n", yytext);
    }

"(" {
        printf("%s\n", yytext);
        return L_PAREN;
    }

")" {
        printf("%s\n", yytext);
        return R_PAREN;
    }

"[" {
        printf("%s\n", yytext);
        return L_BRACE;
    }

"]" {
        printf("%s\n", yytext);
        return R_BRACE;
    }

{SIGN}?{DIGIT}+ {
        printf("lexed '%s' as INTEGER(token=%d, value=%d)\n", yytext, INTEGER, atoi(yytext));
        return INTEGER;
    }

{SIGN}?{DIGIT}+"."{DIGIT}*((e|E){SIGN}?{DIGIT}+)? {
        printf("lexed '%s' as FLOAT(token=%d, value=%g)\n", yytext, FLOAT, atof(yytext));
        return FLOAT;
    }

(nil) {
        printf("lexed '%s' as nil(token=%d)\n", yytext, NIL);
        return NIL;
    }

(false|true) {
        printf("lexed '%s' as BOOL(token=%d)\n", yytext, BOOL);
        return BOOL;
    }

(def|fn|defn|if|while|when|do|lambda|quote|"'"|{SYMBOL}) {
        printf("lexed '%s' as RESERVED(token=%d)\n", yytext, RESERVED);
        return RESERVED;
    }

({ALPHA}|"_")({SIGN}|{ALPHA}|{DIGIT}|{SYMBOL}|"_")* {
        printf("lexed '%s' as IDENT(token=%d)\n", yytext, IDENT);
        return IDENT;
    }

\"(\\.|[^"\\])*\" {
        printf("lexed '%s' as STRING(token=%d)\n", yytext, STRING);
        return STRING;
    }

[ \t\r\n] ;

. printf("UNRECOGNIZED: %s\n", yytext);
%%
