#include <iostream>
#include <vector>
#include <string>
#include <stack>

char parseCrate(std::string str)
{
	int i = 0;
	while (i < str.size())
	{
		if (isalpha(str[i]))
			return str[i];
		i++;
	}
	return 0;
}

std::vector<int> parseProcedure(std::string str)
{
	std::vector<int> procedure;

	int i = 0;
	while (i < str.size())
	{
		if (isnumber(str[i]))
		{
			int j = i;
			while (isnumber(str[j]))
				j++;
			procedure.push_back(atoi(&(str[i])));
			i = j;
		}
		i++;
	}
	return procedure;
}

std::vector<std::stack<char> > setPiles(std::vector<std::vector<char> > crates)
{
	std::vector<std::stack<char> > piles;
	for (int i = 0; i < crates.size(); i++)
	{
		std::stack<char> newPile;
		for (int j = crates.size() - 1; j >= 0; j--)
			if (crates[i][j] != 0)
				newPile.push(crates[i][j]);
		piles.push_back(newPile);
	}
	return piles;
}

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	bool procedure = false;
	bool begin = true;
	std::vector<std::vector<char> > crates;
	std::vector<int> step;
	std::vector<std::stack<char> > piles;

	while (fgets(line, sizeof(line), file))
	{
		std::string s(line);
		if (begin)
		{
			crates = std::vector<std::vector<char> >(s.length() / 4);
			begin = false;
		}
		if (line[0] == '\n')
		{
			procedure = true;
			piles = setPiles(crates);
			continue;
		}

		if (!procedure)
		{
			std::cout << s << std::endl;
			for (size_t i = 0; i < s.size(); i += 4)
			{
				char crate = parseCrate(s.substr(i, 4));
				crates[i / 4].push_back(crate);
			}
		}
		if (procedure)
		{
			step = parseProcedure(s);
			std::cout << "Move " << step[0] << " crate from column " << step[1] << " to column " << step[2] << std::endl;

			std::vector<std::stack<char> >::iterator it = piles.begin();
			std::vector<std::stack<char> >::iterator ite = piles.end();

			std::string moved_crates;

			for (int i = 0; i < step[0]; i++)
			{
				char c = piles[step[1] - 1].top();
				moved_crates.push_back(c);
				std::cout << "Pop " << c << std::endl;
				piles[step[1] - 1].pop();
			}
			std::cout << moved_crates << std::endl;
			for (int i = moved_crates.length() - 1; i >=0 ; i--)
			{
				piles[step[2] - 1].push(moved_crates[i]);
				std::cout << "Push " << moved_crates[i] << std::endl;
			}
		}
	}


	std::vector<std::stack<char> >::iterator it = piles.begin();
	std::vector<std::stack<char> >::iterator ite = piles.end();


	std::cout << "TOP CRATES ARE: " << std::endl;

	for (it; it != ite; it++)
	{
		std::cout << it->top();
	}

	std::cout << std::endl;
	
	fclose(file);
	return 0;
}