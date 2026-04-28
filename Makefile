CC ?= cc
CFLAGS ?= -std=c99 -Wall -Wextra -Wpedantic -O2
PREFIX ?= /usr/local

.PHONY: all clean test install

all: lim example

lim: lim.c lim.h
	$(CC) $(CFLAGS) lim.c -o lim

example: example.c lim.c lim.h
	$(CC) $(CFLAGS) -DLIM_NO_MAIN example.c lim.c -o example

test: all
	./lim -r examples/rules.lim --summary < examples/sample.tlm; test $$? -eq 1
	./example; test $$? -eq 1

install: lim
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 lim $(DESTDIR)$(PREFIX)/bin/lim

clean:
	rm -f lim example *.o
