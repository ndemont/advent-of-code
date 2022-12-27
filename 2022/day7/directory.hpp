#ifndef DIRECTORY_HPP
#define DIRECTORY_HPP

#include <numeric>
#include <iostream>
#include <vector>
#include <list>

using namespace std;

class Directory
{
public:
	Directory(string name);
	Directory(string name, Directory *father);
	Directory(Directory const &src);
	~Directory(void);

	Directory const &operator=(Directory const &rhs);

	void	addDirectory(Directory dir);
	void	addFile(string name, int size);
	int		getSize(void) const;

private:
	string										_name;
	int												_size;
	Directory									*_father;
	vector<Directory>					_children;
	vector<pair<string, int> >	_files;

};

std::ostream &operator<<(std::ostream &o, Directory const &i);


#endif