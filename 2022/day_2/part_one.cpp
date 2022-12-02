#include <iostream>
#include <string>
#include <map>

int getShapeScore(char shape)
{
	switch (shape)
	{
	case 'X':
		return 1;
	case 'Y':
		return 2;
	case 'Z':
		return 3;
	default:
		return 0;
	}
}

std::string getOutcome(char elf_shape, char my_shape)
{
	switch (elf_shape)
	{
	case 'A':
		switch (my_shape)
		{
		case 'X':
			return "DRAW";
		case 'Y':
			return "WIN";
		case 'Z':
			return "LOOSE";
		}
	case 'B':
		switch (my_shape)
		{
		case 'X':
			return "LOOSE";
		case 'Y':
			return "DRAW";
		case 'Z':
			return "WIN";
		}
	case 'C':
		switch (my_shape)
		{
		case 'X':
			return "WIN";
		case 'Y':
			return "LOOSE";
		case 'Z':
			return "DRAW";
		}
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

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	int score = 0;

	while (fgets(line, sizeof(line), file))
	{
		char elf_shape = line[0];
		char my_shape = line[2];

		std::string outcome = getOutcome(elf_shape, my_shape);

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
