CFLAGS=-Wall -pedantic -std=c11 -I.

all:		test1 test2 test3 test4

integratemod.o:	integratemod.c integrate.h
		gcc $(CFLAGS) -c integratemod.c

test1.o:	test1.c integrate.h
		gcc $(CFLAGS) -c test1.c

test2.o:	test2.c integrate.h
		gcc $(CFLAGS) -c test2.c

test3.o:	test3.c integrate.h
		gcc $(CFLAGS) -c test3.c

test4.o:	test4.c integrate.h
		gcc $(CFLAGS) -c test4.c

test1:		test1.o integratemod.o
		gcc $(CFLAGS) test1.o integratemod.o -o test1

test2:		test2.o integratemod.o
		gcc $(CFLAGS) test2.o integratemod.o -o test2

test3:		test3.o integratemod.o
		gcc $(CFLAGS) test3.o integratemod.o -o test3

test4:		test4.o integratemod.o
		gcc $(CFLAGS) test4.o integratemod.o -o test4

clean:
		rm -f *.o test1
