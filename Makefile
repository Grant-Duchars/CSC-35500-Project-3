all: main

main: project3.asm parseInput.asm printRAX.asm printChar.asm
	nasm -felf64 -gstabs project3.asm
	nasm -felf64 -gstabs parseInput.asm
	nasm -felf64 -gstabs printRAX.asm
	nasm -felf64 -gstabs printChar.asm
	ld -o project3 project3.o parseInput.o printRAX.o printChar.o
	rm -f project3.o parseInput.o printRAX.o printChar.o

clean:
	rm -f project3