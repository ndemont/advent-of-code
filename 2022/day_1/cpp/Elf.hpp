#ifndef ELF_HPP
#define ELF_HPP

#include <numeric>
#include <iostream>
#include <vector>

class Elf
{
public:
	Elf(void);
	Elf(Elf const &src);
	~Elf(void);

	Elf const &operator=(Elf const &rhs);

	void addCalorie(int calorie);
	std::vector<int> getCalories(void) const;
	int getTotalCalories(void) const;

private:
	std::vector<int> calories;
};

std::ostream &operator<<(std::ostream &o, Elf const &i);

#endif