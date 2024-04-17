class Stratagem {
	_spriteId = null
	_combo = null
	_name = null
	
	constructor(spriteId, combo,name)
	{
		_spriteId = spriteId
		_combo = combo
		_name = name
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