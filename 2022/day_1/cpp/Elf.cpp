#include "Elf.hpp"

Elf::Elf(void) {}
Elf::Elf(Elf const & src) { *this = src; }
Elf::~Elf(void) {}

// Elf const & Elf::operator=(Elf const & rhs)
// {
// 	if (this != &rhs)
// 	{
//         calories = rhs.getCalories();
// 	}
// 	return *this;
// }

// void    Elf::addCalorie(int calorie)
// { 
//     calories.push_back(calorie); 
// }

// std::vector<int>    Elf::getCalories(void)  const
// { 
//     return calories;
// }

// int     Elf::getTotalCalories(void)  const
// { 
//     return std::accumulate(calories.begin(), calories.end(), 0);
// }

// std::ostream &	operator<<(std::ostream & o, Elf const & i)
// {
//     // o << i.getTotalCalories();
// 	return o;
// }
