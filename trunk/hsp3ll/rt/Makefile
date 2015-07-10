ALL: rt.ll

rt.ll: rt.bc
	llvm-dis rt.bc

rt.bc: rt.cpp
	clang++ -O -emit-llvm -c rt.cpp -o rt.bc
