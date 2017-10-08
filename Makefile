PROJ = lisp

test: main test.txt
	@cat test.txt && ./main < test.txt

main: lex.yy.c
	@gcc -o main lex.yy.c

lex.yy.c: $(PROJ).l
	@flex -o lex.yy.c $(PROJ).l

clean:
	@rm -f main lex.yy.c
