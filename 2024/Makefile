# Default day variable (can be overridden with `make day=N`)
day ?= 1
dir = day$(day)
file = $(dir)/Main.kt
output = $(dir)/Main.jar

# Compile the Kotlin file
compile:
	@echo "Compiling $(file)..."
	kotlinc "$(file)" -include-runtime -d "$(output)"
	@echo "Compiled $(file) to $(output)"

# Run the compiled JAR file
run: compile
	@echo "Running $(output)..."
	java -jar "$(output)"

# Clean all compiled JAR files
clean:
	@echo "Cleaning up compiled files..."
	rm -f day*/Main.jar
	@echo "Cleaned."

# Default target
all: run
