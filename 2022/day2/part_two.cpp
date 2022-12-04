#include <iostream>
#include <string>
#include <map>

int getShapeScore(char shape)
{
	switch (shape)
	{
	case 'A':
		return 1;
	case 'B':
		return 2;
	case 'C':
		return 3;
	default:
		return 0;
	}
}

int getOutcomeScore(std::string outcome)
{
	if (outcome == "WIN")
		return 6;
	if (outcome == "DRAW")
		return 3;
	return 0;
}

std::string getOutcome(char shape)
{
	switch (shape)
	{
	case 'X':
		return "LOOSE";
	case 'Y':
		return "DRAW";
	case 'Z':
		return "WIN";
	default:
		return "";
	}
}

char getShapeOutcome(char elf_shape, std::string outcome)
{
	if (outcome == "DRAW")
		return elf_shape;
	if (outcome == "WIN")
	{
		switch (elf_shape)
		{
		case 'A':
			return 'B';
		case 'B':
			return 'C';
		case 'C':
			return 'A';
		}
	}
	if (outcome == "LOOSE")
	{
		switch (elf_shape)
		{
		case 'A':
			return 'C';
		case 'B':
			return 'A';
		case 'C':
			return 'B';
		}
	}
	return '0';
}

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	int score = 0;

	while (fgets(line, sizeof(line), file))
	{
		char elf_shape = line[0];
		std::string outcome = getOutcome(line[2]);
		char my_shape = getShapeOutcome(elf_shape, outcome);

		std::cout << elf_shape << " " << my_shape << std::endl;
		std::cout << "Shape Score: " << getShapeScore(my_shape) << std::endl;
		std::cout << "Outcome Score: " << getOutcomeScore(outcome) << std::endl;
		std::cout << "Round Score: " << getOutcomeScore(outcome) + getShapeScore(my_shape) << std::endl
							<< std::endl;

		score += (getOutcomeScore(outcome) + getShapeScore(my_shape));
	}

	fclose(file);

	std::cout << "Total Score: " << score << std::endl;

	return 0;
}
