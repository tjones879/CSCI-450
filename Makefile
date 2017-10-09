PROJ = lisp

test: main
	./main

main: lex.yy.cpp tab.cpp
	@g++ -std=c++11 -o main lex.yy.cpp tab.cpp 

lex.yy.cpp: $(PROJ).l
	@flex -o lex.yy.cpp $(PROJ).l

tab.cpp: $(PROJ).y
	@bison -d -o tab.cpp $(PROJ).y

clean:
	@rm -f main lex.yy.cpp tab.cpp tab.hpp
