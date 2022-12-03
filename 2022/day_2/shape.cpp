#include "shape.hpp"

Shape::Shape(char letter)
{
	_letter = letter;
	_points = letterPointsMap().find(letter)->second;
	_hand = letterHandMap().find(letter)->second;
}

Shape::Shape(Shape const &src)
{
	*this = src;
}

Shape const &Shape::operator=(Shape const &rhs)
{
	if (this != &rhs)
	{
		_letter = rhs._letter;
		_points = rhs._points;
		_hand = rhs._hand;
	}
	return *this;
}

std::map<char, std::string> letterHandMap(void)
{
	std::map<char, std::string> letter_hand_map;

	letter_hand_map.insert(std::pair<char, std::string>('A', "Rock"));
	letter_hand_map.insert(std::pair<char, std::string>('B', "Paper"));
	letter_hand_map.insert(std::pair<char, std::string>('C', "Scissors"));
	letter_hand_map.insert(std::pair<char, std::string>('X', "Rock"));
	letter_hand_map.insert(std::pair<char, std::string>('Y', "Paper"));
	letter_hand_map.insert(std::pair<char, std::string>('Z', "Scissors"));

	return letter_hand_map;
}

std::map<char, int> letterPointsMap(void)
{
	std::map<char, int> letter_points_map;

	letter_points_map.insert(std::pair<char, int>('X', 1));
	letter_points_map.insert(std::pair<char, int>('Y', 2));
	letter_points_map.insert(std::pair<char, int>('Z', 3));

	return letter_points_map;
}
