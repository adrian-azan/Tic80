// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel

class menuPointer
{
	current = null
	limit = null

	constructor (_limit)
	{
		current = 0 
		limit = _limit
	}
	
	function _add(right)
	{
		current = (curent + right) % limit
	}
	
	function _sub(right)
	{
		current = (current - right);
		if (current < 0)
			current = limit - 1
	}
	
}