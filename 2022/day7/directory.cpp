#include "directory.hpp"

Directory::Directory(string name) 
{ 
	_name = name;
}

Directory::Directory(string name, Directory *father) 
{ 
	_name = name;
	_father = father;
}

Directory::Directory(Directory const &src) { *this = src; }
Directory::~Directory(void) {}

Directory const &Directory::operator=(Directory const &rhs)
{
	if (this != &rhs)
	{
		_name = rhs._name;
		_size = rhs._size;
		_father = rhs._father;
		_children = rhs._children;
		_files = rhs._files;
	}
	return *this;
}

void Directory::addDirectory(Directory dir)
{
	_children.push_back(dir);
}

void Directory::addFile(string name, int size)
{
	pair<string, int> new_file(name, size);
	_files.push_back(new_file);
	_size += size;
}

int Directory::getSize(void) const
{
	int total_size = _size;

	for (int i = 0; i < _children.size(); i++)
	{
		total_size += _children[i].getSize();
	}

	return total_size;
}

std::ostream &operator<<(std::ostream &o, Directory const &i)
{
	return o;
}