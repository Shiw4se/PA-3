CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra
SOURCES = main.cpp FuncA.cpp
OBJECTS = $(SOURCES:.cpp=.o)
TARGET = bin/my_program

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJECTS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)

