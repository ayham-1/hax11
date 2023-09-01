PREFIX=/usr/local
LIB32=lib32
LIB64=lib64

all: lib

lib: lib32/hax11.so lib64/hax11.so

lib32:
	mkdir lib32
lib64:
	mkdir lib64

lib32/hax11.so: lib32 common.c lib.c Makefile
	gcc -m32 -Wall -Wextra -g lib.c -o $@ -fPIC -shared -ldl -D_GNU_SOURCE
lib64/hax11.so: lib64 common.c lib.c Makefile
	gcc -m64 -Wall -Wextra -g lib.c -o $@ -fPIC -shared -ldl -D_GNU_SOURCE

server: common.c server.c
	gcc -o server -lpthread server.c

install:
	install -d $(PREFIX)/$(LIB32)/
	install -d $(PREFIX)/$(LIB64)/
	install -d $(PREFIX)/bin/
	install -m 644 lib32/hax11.so $(PREFIX)/$(LIB32)/
	install -m 644 lib64/hax11.so $(PREFIX)/$(LIB64)/
	echo "export LD_PRELOAD=$(PREFIX)/$(LIB32)/hax11.so " > $(PREFIX)/bin/hax11_x32
	echo "export LD_PRELOAD=$(PREFIX)/$(LIB64)/hax11.so " > $(PREFIX)/bin/hax11_x64
	chmod 755 $(PREFIX)/bin/hax11_x32
	chmod 755 $(PREFIX)/bin/hax11_x64

uninstall:
	rm -f $(PREFIX)/$(LIB32)/hax11.so
	rm -f $(PREFIX)/$(LIB64)/hax11.so
	rm -f $(PREFIX)/bin/hax11_x32
	rm -f $(PREFIX)/bin/hax11_x64

.PHONY: all lib install
