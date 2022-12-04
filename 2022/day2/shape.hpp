#ifndef SHAPE_HPP
#define SHAPE_HPP

#include <string>
#include <map>

class Shape
{
public:
	Shape(char letter);
	Shape(Shape const &src);
	~Shape(void);

	Shape const &operator=(Shape const &rhs);

private:
	char _letter;
	int _points;
	std::string _hand;
};

#endif