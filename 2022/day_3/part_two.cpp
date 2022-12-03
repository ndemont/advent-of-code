#include <iostream>
#include <string>
#include <vector>

int getPriority(char item)
{
	int priority = 1;
	char start_letter = 'a';
	char stop_letter = 'z';

	if (isupper(item))
	{
		priority = 27;
		start_letter = 'A';
		stop_letter = 'Z';
	}

	while (start_letter <= stop_letter)
	{
		if (item == start_letter)
			break;
		start_letter++;
		priority++;
	}

	return priority;
}

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	int priorities = 0;
	int group_size = 3;

	std::vector<std::string> group;
	while (fgets(line, sizeof(line), file))
	{
		if (group.size() < group_size)
			group.push_back(line);
		if (group.size() == group_size)
		{
			std::string common_items;
			std::string first_elf = group[0];
			std::string second_elf = group[1];
			std::string third_elf = group[2];

			group.clear();

			int i = 0;
			while (i < first_elf.length())
			{
				if (second_elf.find(first_elf[i]) < second_elf.length())
					common_items.push_back(first_elf[i]);
				i++;
			}

			i = 0;
			while (i < third_elf.length())
			{
				if (third_elf.find(common_items[i]) < third_elf.length())
				{
					priorities += getPriority(common_items[i]);
					break;
				}
				i++;
			}
		}
	}

	fclose(file);
	std::cout << "The sum priorities is " << priorities << std::endl;

	return 0;
}