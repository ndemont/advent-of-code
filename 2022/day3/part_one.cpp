#include <iostream>
#include <string>

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

	while (fgets(line, sizeof(line), file))
	{
		std::string rucksack(line);
		std::string first_compartment = rucksack.substr(0, rucksack.length() / 2);
		std::string second_compartment = rucksack.substr(rucksack.length() / 2, rucksack.length());

		int i = 0;
		while (i < first_compartment.length())
		{
			char item = first_compartment[i];
			if (second_compartment.find(item) < second_compartment.length())
			{
				priorities += getPriority(item);
				break;
			}
			i++;
		}
	}

	fclose(file);
	std::cout << "The sum of the priorities is " << priorities << std::endl;

	return 0;
}