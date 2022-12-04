#include <iostream>
#include <string>
#include <vector>

bool isRangeInRange(std::vector<int> r1, std::vector<int> r2)
{
	if (r1[0] <= r2[0])
		if (r1[1] >= r2[1])
			return true;
	return false;
}

std::vector<int> getRange(std::string elf)
{
	std::vector<int> range;

	range.push_back(stoi(elf.substr(0, elf.find("-"))));
	range.push_back(stoi(elf.substr(elf.find("-") + 1, elf.length())));

	return range;
}

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	int sum = 0;

	while (fgets(line, sizeof(line), file))
	{
		std::string pair(line);
		std::string elf_one = pair.substr(0, pair.find(","));
		std::string elf_two = pair.substr(pair.find(",") + 1, pair.length());

		std::vector<int> section_one = getRange(elf_one);
		std::vector<int> section_two = getRange(elf_two);

		if (isRangeInRange(section_one, section_two) || isRangeInRange(section_two, section_one))
			sum++;
	}

	fclose(file);
	std::cout << "Assignment pairs in which one range fully contain the other: " << sum << std::endl;

	return 0;
}