CXX = g++ 
CXXFLAGS = -g -std=c++17 -O3 -Wall
frameSources = chessState.cpp transpositionTable.cpp
frameObjects = chessState.o transpositionTable.o
mainSource = main.cpp
bindingSource = binding.cpp 
demoBuild = main.o frameWork.o

demo : $(demoBuild)
	$(CXX) $(CXXFLAGS) -o $@ $^ 

frameWork.o : $(frameSources)
	$(CXX) -r $(CXXFLAGS) $^ -o $@

main.o : $(mainSource)
	$(CXX) $(CXXFLAGS) -c $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@



.PHONY: debug clean
debug: demo
	gdb ./demo

run: demo
	./demo
clean:
	rm demo *.o

