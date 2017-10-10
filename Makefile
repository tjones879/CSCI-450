PROJ = lisp

test: main
	./main

main: lex.yy.cpp tab.cpp ast.cpp
	@g++ -std=c++17 -o main lex.yy.cpp tab.cpp ast.cpp

lex.yy.cpp: $(PROJ).l
	@flex -o lex.yy.cpp $(PROJ).l

tab.cpp: $(PROJ).y ast.h
	@bison -d -o tab.cpp $(PROJ).y

clean:
	@rm -f main lex.yy.cpp tab.cpp tab.hpp
