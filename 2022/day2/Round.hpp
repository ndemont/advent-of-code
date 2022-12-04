#ifndef ROUND_HPP
# define ROUND_HPP

# include <string>
# include <map>

class Round
{
	public:
		typedef
		Round();
		~Round();

		int		getHand(std::string hand, std::string outcome);
		int		getOutcome(std::string adversary_hand, std::string my_hand);
		int		getPoints(std::string adversary_hand, std::string my_hand);
		int		getPoints(std::string outcome);


};

#endif