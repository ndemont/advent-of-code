#include "Expedition.hpp"


Expedition::Expedition(void) {}
Expedition::Expedition(Expedition const & src) { *this = src; }
Expedition::~Expedition(void) {}

void Expedition::addElf(Elf elf) 
{
    elfs.insert(std::pair<int, Elf>(elf.getTotalCalories(), elf));
}

Expedition const & Expedition::operator=(Expedition const & rhs)
{
	if (this != &rhs)
	{
        elfs = rhs.getElfs();
	}
	return *this;
}

std::map<int, Elf>  Expedition::getElfs(void) const
{
    return elfs;
}

std::ostream &	operator<<(std::ostream & o, Expedition const & i)
{
    
    std::map<int, Elf> elfs = i.getElfs();
    std::map<int, Elf>::iterator it = elfs.begin();

    while (it != elfs.end())
    {
        // o << it->second;
        it++;
    }
	return o;
}