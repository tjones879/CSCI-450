%option noyywrap

%{
#include <stdio.h>
#include <math.h>
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

{SIGN}?{DIGIT}+ {
        printf("An integer: %s (%d)\n", yytext, atoi(yytext));
    }

{SIGN}?{DIGIT}+"."{DIGIT}*((e|E){SIGN}?{DIGIT}+)? {
        printf("A float: %s (%g)\n", yytext, atof(yytext));
    }

(nil) {
        printf("nil: %s\n", yytext);
    }

(false|true) {
        printf("Boolean: %s\n", yytext);
    }

(def|fn|defn|if|while|when|do|lambda|quote|"'"|{SYMBOL}) {
        printf("A reserved word: %s\n", yytext);
    }

({ALPHA}|"_")({SIGN}|{ALPHA}|{DIGIT}|{SYMBOL}|"_")* {
        printf("An identifier: %s\n", yytext);
    }

\"(\\.|[^"\\])*\" {
        printf("A string literal: %s\n", yytext);
    }

[ \t\r\n] ;

. printf("UNRECOGNIZED: %s\n", yytext);
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yylex();
    return 0;
}
