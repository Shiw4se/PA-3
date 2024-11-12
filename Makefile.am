AUTOMAKE_OPTIONS = foreign
bin_PROGRAMS = my_program
my_program_SOURCES = main.cpp FuncA.cpp FuncA.h
AM_CXXFLAGS = -std=c++17 -Wall -Wextra
my_program_LDADD = -lm
dist_man_MANS=FuncA.1
dist_pkgdata_DATA=data.txt
.PHONY: deb
deb:
	make DESTDIR=$(CURDIR)/deb install

