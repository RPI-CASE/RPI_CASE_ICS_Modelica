# Makefile generated by OpenModelica

# Dynamic loading uses -O0 by default
SIM_OR_DYNLOAD_OPT_LEVEL=-O0
CC=gcc
CXX=g++
LINK=g++ -shared -Xlinker --export-all-symbols
EXEEXT=.exe
DLLEXT=.dll
DEBUG_FLAGS=
CFLAGS= -I"C:/OpenModelica1.9.1//include/omc/c"  $(DEBUG_FLAGS) ${SIM_OR_DYNLOAD_OPT_LEVEL} -falign-functions -msse2 -mfpmath=sse ${MODELICAUSERCFLAGS} 
LDFLAGS= -L"C:/OpenModelica1.9.1//lib/omc" -Wl,-rpath,'C:/OpenModelica1.9.1//lib/omc'  -lregex -lexpat -lgc -lpthread -fopenmp -loleaut32  -lOpenModelicaRuntimeC -lgc -lexpat -lregex -static-libgcc -luuid -loleaut32 -lole32 -lws2_32 -lsundials_kinsol -lsundials_nvecserial -lipopt -lcoinmumps -lpthread -lm -lgfortranbegin -lgfortran -lmingw32 -lgcc_eh -lmoldname -lmingwex -lmsvcrt -luser32 -lkernel32 -ladvapi32 -lshell32 -llapack-mingw -lcminpack -ltmglib-mingw -lblas-mingw -lf2c
PERL=perl
MAINFILE=Buildings_getHeaderElementTMY3_1.c

.PHONY: Buildings_getHeaderElementTMY3_1
Buildings_getHeaderElementTMY3_1: $(MAINFILE) Buildings_getHeaderElementTMY3_1.h Buildings_getHeaderElementTMY3_1_records.c
	 $(CC) $(CFLAGS) -c -o Buildings_getHeaderElementTMY3_1.o $(MAINFILE)
	 $(CC) $(CFLAGS) -c -o Buildings_getHeaderElementTMY3_1_records.o Buildings_getHeaderElementTMY3_1_records.c
	 $(LINK) -o Buildings_getHeaderElementTMY3_1$(DLLEXT) Buildings_getHeaderElementTMY3_1.o Buildings_getHeaderElementTMY3_1_records.o -lModelicaExternalC $(CFLAGS) $(LDFLAGS) -lm