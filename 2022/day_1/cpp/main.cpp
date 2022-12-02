#include "Elf.hpp"
// #include "Expedition.hpp"s

using namespace std;

int main(int argc, char* argv[])
{
    char const* const fileName = argv[1];
    FILE* file = fopen(fileName, "r");
    char line[256];
    // Expedition expedition;
    // Elf elf;
    vector<int> test;

    while (fgets(line, sizeof(line), file)) {
        
        if (line[0] == '\n')
        {
            // expedition.addElf(new_elf);
            // new_elf = Elf();
        }
        // new_elf.addCalorie(atol(line));
    }

    fclose(file);
    // std::cout << "The Elf carrying the most Calories holds " << expedition << std::endl;
    return 0;
}
