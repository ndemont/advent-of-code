#include <iostream>
#include <vector>
#include <string>
#include "directory.hpp"

using namespace std;

vector<string> parse_line(string line)
{
	vector<string> words;

	int start = 0;
	for (int i = 0; i < line.size(); i++)
	{
		if (line[i] == ' ' || line[i] == '\n')
		{
			string word = line.substr(start, i - start);
			words.push_back(word);
			start = i + 1;
		}
	}
	return words;
}

void	command_line(vector<string> words, string *current_dir)
{
	if (words[1] == "cd" && words[2] != "..")
	{
		*current_dir = words[2];
		cout << "Command cd " << words[2] << endl << endl;
	}
	return;
}

void	file_line(vector<string> words)
{
	pair<string, int> new_file(words[1], stoi(words[0]));
	
	cout << "Line " << new_file.first << " " << new_file.second << endl << endl;
	return;
}

void	directory_line(vector<string> words)
{
	Directory new_dir(words[]);
	cout << "Directory" << endl << endl;
	return ;
}

int main(int argc, char *argv[])
{
	char const *const fileName = argv[1];
	FILE *file = fopen(fileName, "r");
	char line[256];
	string device;
	vector<Directory> directories;
	string current_dir = "/";
	string home_dir = "/";

	Directory home("/");
	while (fgets(line, sizeof(line), file))
	{
		vector<string> words = parse_line(line);

		if (words[0] == "$")
			command_line(words, &current_dir);
		else if (words[0] == "dir")
			directory_line(words);
		else
			file_line(words);
	}
	return 0;
}