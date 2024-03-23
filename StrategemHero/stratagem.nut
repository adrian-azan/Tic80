// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel

t<-0
x<-96
y<-24

class Stratagem {
	_spriteId = null
	_combo = null
	
	constructor(spriteId, combo)
	{
		_spriteId = spriteId
		_combo = combo
	}
	
	
	function draw(x,y)
	{
		spr(_spriteId,x,y,14,3,0,0,2,2)
	}
	
	function combo()
	{
		return _combo;
	}
	
	function comboCheck(userInput)
	{
		for (local i = 0; i < userInput.len(); i++)
		{
			if (_combo[i] != userInput[i])
			{
				return -1;
			}
		}
		
		if (userInput.len() == _combo.len())
			return 1;
		
		return 0;
	}
}