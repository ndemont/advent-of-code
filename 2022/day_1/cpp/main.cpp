#include "Elf.hpp"
#include "Expedition.hpp"

using namespace std;

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	Expedition expedition;
	Elf elf;

	while (fgets(line, sizeof(line), file))
	{

		if (line[0] == '\n')
		{
			expedition.addElf(elf);
			elf = Elf();
		}
		elf.addCalorie(atol(line));
	}
	expedition.addElf(elf);

	fclose(file);

	int count = 0;
	int calories = 0;
	map<int, Elf> elfs = expedition.getElfs();
	map<int, Elf>::iterator it = elfs.begin();
	map<int, Elf>::iterator ite = elfs.end();

	if (ite != it)
	{
		ite--;
		while (ite != it && count < 3)
		{
			calories += ite->first;
			ite--;
			count++;
		}
	}

	std::cout << "The top three Elves carrying the most Calories have " << calories << " calories." << std::endl;
	return 0;
}
