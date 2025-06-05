CXX = g++ 
CXXFLAGS = -g -std=c++17 -O3 -Wall
GENFLAGS = -std=c++17 -O3
frameSources = tables.cpp chessState.cpp transpositionTable.cpp 
frameObjects = chessState.o transpositionTable.o tables.o
mainSource = main.cpp
bindingSource = binding.cpp 
demoBuild = main.o frameWork.o
attackBoardSources = generateTables.cpp magicNumbers.hpp attackMasks.hpp bitOffset.hpp
zobristTableSources = zobristHash.cpp zobristTable.hpp
tablesSource = tables.cpp
generate = generateZobrist generateAttacks

ChessLibrary.a : $(frameObjects)
	ar rcs $@ $^
	make clean

demo : $(demoBuild)
	$(CXX) $(CXXFLAGS) -o $@ $^ 

frameWork.o : $(frameSources)
	$(CXX) -r $(CXXFLAGS) $^ -o $@

main.o : $(mainSource)
	$(CXX) $(CXXFLAGS) -c $< -o $@

tables.o : $(generate)
	$(CXX) $(CXXFLAGS) -c $(tablesSource) -o $@ 

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: debug run clean generateZobrist generateAttacks
debug: demo
	gdb ./demo

run: demo
	./demo

clean:
	rm demo *.o simGame.txt
	
generateZobrist : zobristHash.cpp
	$(CXX) $(GENFLAGS) $< -o $@
	./$@
	rm ./$@

generateAttacks : generateTables.cpp
	$(CXX) $(GENFLAGS) $< -o $@
	./$@ 
	rm ./$@

