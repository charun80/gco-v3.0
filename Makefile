CCPP = g++

WARNING_FLAGS = -Wall -Wdate-time  -Wformat -Werror=format-security -Wstrict-aliasing # -Wextra
DEBUGING_FLAGS = -ggdb3 # -DNDEBUG
OPTIMIZATION_FLAGS = -O0 -march=native  # -fstrict-aliasing
CODE_QUALITY_FLAGS = -D_FORTIFY_SOURCE=2 -fstack-protector-strong


TARGET_LIB = libgco.so # target lib


CFLAGS = -fpic $(WARNING_FLAGS) $(DEBUGING_FLAGS) $(OPTIMIZATION_FLAGS) $(CODE_QUALITY_FLAGS)
LDFLAGS = -shared -Wl,-soname,$(TARGET_LIB)




SOURCES_CPP := $(shell ls *.cpp)
SOURCES_INL := $(shell ls *.inl)
HEADERS := $(shell ls *.h)
OBJ := $(SOURCES_CPP:%.cpp=%.o)


all: $(TARGET_LIB) example

.cpp.o:  %.cpp %.h
	$(CCPP) -c -o $@ $(CFLAGS) $+

GCoptimization.o: GCoptimization.cpp $(HEADERS) $(SOURCES_INL) 
	$(CCPP) -c -o GCoptimization.o $(CFLAGS) GCoptimization.cpp

example: example.o LinkedBlockList.o GCoptimization.o
	$(CCPP) $(CFLAGS) -o $@ $^

$(TARGET_LIB): LinkedBlockList.o GCoptimization.o 
	$(CCPP) $(CFLAGS) ${LDFLAGS} -o $@ $^ 


clean:
	rm -f $(OBJ) $(TARGET_LIB) example

