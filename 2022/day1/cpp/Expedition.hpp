#ifndef __EXPEDITION_HPP__
#define __EXPEDITION_HPP__

#include <vector>
#include <map>
#include <numeric>
#include <iostream>
#include "Elf.hpp"

class Expedition
{
public:
	Expedition(void);
	Expedition(Expedition const &src);
	~Expedition(void);

	Expedition const &operator=(Expedition const &rhs);

	void addElf(Elf elf);
	std::map<int, Elf> getElfs(void) const;

private:
	std::map<int, Elf> elfs;
};

std::ostream &operator<<(std::ostream &o, Expedition const &i);

#endif