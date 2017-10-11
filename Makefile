PROJ = lisp
FLAGS = -std=c++17 -Wall -Wextra

test: main
	./main

main: lex.yy.cpp tab.cpp ast.cpp
	@g++ $(FLAGS) -o main lex.yy.cpp tab.cpp ast.cpp

lex.yy.cpp: $(PROJ).l
	@flex -o lex.yy.cpp $(PROJ).l

tab.cpp: $(PROJ).y ast.h
	@bison -d -o tab.cpp $(PROJ).y

clean:
	@rm -f main lex.yy.cpp tab.cpp tab.hpp
