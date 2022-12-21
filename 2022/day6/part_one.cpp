#include <iostream>
#include <vector>
#include <string>
#include <set>

using namespace std;

int main(int argc, char *argv[])
{
	char const	*const fileName = argv[1];
	FILE				*file = fopen(fileName, "r");
	char				line[256];
	string			packet;
	int					start_of_packet = 4;

	while (fgets(line, sizeof(line), file))
	{
		packet += std::string(line);
	}

	string::iterator it = packet.begin();
	string::iterator ite = packet.end();

	for (it = packet.begin(); it != packet.end(); it++)
	{
		set<char> chunk(it, it + 4);
		if (chunk.size() == 4)
			break;
		start_of_packet++;
	}

	cout << "Marker " << start_of_packet << endl;

	fclose(file);
	return 0;
}