# ==============================
# Root Makefile (OS-CA1)
# ==============================

CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -Icommon -pthread

COMMON_DIR := common
SERVER_DIR := server
AIRLINE_DIR := client/airline
CUSTOMER_DIR := client/customer

BIN_DIR := bin
SERVER_BIN := $(BIN_DIR)/server
AIRLINE_BIN := $(BIN_DIR)/airline
CUSTOMER_BIN := $(BIN_DIR)/customer

# ==============================

all: prepare common server airline customer

prepare:
	@mkdir -p $(BIN_DIR)

# --- Common ---
COMMON_SRC := $(COMMON_DIR)/socket_utils.cpp $(COMMON_DIR)/broadcast.cpp
COMMON_OBJ := $(COMMON_SRC:.cpp=.o)

common: $(COMMON_OBJ)

# --- Server ---
SERVER_SRC := $(wildcard $(SERVER_DIR)/src/*.cpp)
SERVER_OBJ := $(SERVER_SRC:.cpp=.o)
server: $(COMMON_OBJ) $(SERVER_OBJ)
	$(CXX) $(CXXFLAGS) -o $(SERVER_BIN) $(SERVER_OBJ) $(COMMON_OBJ)

# --- Airline Client ---
AIRLINE_SRC := $(wildcard $(AIRLINE_DIR)/src/*.cpp)
AIRLINE_OBJ := $(AIRLINE_SRC:.cpp=.o)
airline: $(COMMON_OBJ) $(AIRLINE_OBJ)
	$(CXX) $(CXXFLAGS) -o $(AIRLINE_BIN) $(AIRLINE_OBJ) $(COMMON_OBJ)

# --- Customer Client ---
CUSTOMER_SRC := $(wildcard $(CUSTOMER_DIR)/src/*.cpp)
CUSTOMER_OBJ := $(CUSTOMER_SRC:.cpp=.o)
customer: $(COMMON_OBJ) $(CUSTOMER_OBJ)
	$(CXX) $(CXXFLAGS) -o $(CUSTOMER_BIN) $(CUSTOMER_OBJ) $(COMMON_OBJ)

# --- Clean targets ---
clean:
	rm -rf $(COMMON_OBJ) $(SERVER_OBJ) $(AIRLINE_OBJ) $(CUSTOMER_OBJ) $(BIN_DIR)

clean-server:
	rm -rf $(SERVER_OBJ) $(SERVER_BIN)

clean-clients:
	rm -rf $(AIRLINE_OBJ) $(CUSTOMER_OBJ) $(AIRLINE_BIN) $(CUSTOMER_BIN)

# Optional run targets
run-server:
	./$(SERVER_BIN)

run-airline:
	./$(AIRLINE_BIN)

run-customer:
	./$(CUSTOMER_BIN)

.PHONY: all prepare clean server airline customer
