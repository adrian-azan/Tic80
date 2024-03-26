
#require "math"

class Board
{
	round = null
	queue = null
	score = null
	health = null
	playerInput = null
	failureFlash = null
	stratagemPool = null
	
	
	constructor()
	{
		round = 0
		score = 0
		health = 100
		playerInput = ""
		stratagemPool = StratagemStorage()
		queue = stratagemPool.getRandomStratagems(3)
		
	}
	
	function Update()
	{
		Check()
		Input()
	}

	function Draw()
	{		
		for (local i = 0; i < queue.len(); i++)
		{
			queue[i].draw(i*64+10,5)
		}
	
		if (queue.len() > 0)
		{
			local _combo = queue[0].combo()
			print(_combo)

			local comboWidth = 30*_combo.len()
			local sideBuffer = (240-comboWidth)/2
			local rotation = 0;
			
			
			for (local i = 0; i < _combo.len(); i++)
			{
				trace(format("%d: %d",i,_combo[i].tointeger()))
				if (_combo[i] == '>')
					rotation = 1
				else if (_combo[i] == 'v')
					rotation = 2
				else if (_combo[i] == '<')
					rotation = 3
				
				if (failureFlash != null && !failureFlash.isFinished())
					spr(32, sideBuffer + 30*i + (rand() % 6 - 3), 80 + (rand() % 6 - 3), 0, 2, 0,rotation,2,2)				
				else if (i < playerInput.len())
					spr(0, sideBuffer + 30*i, 80, 0, 2, 0,rotation,2,2)
				else
					spr(64, sideBuffer + 30*i, 80, 0, 2, 0,rotation,2,2)
			}
		}
		rect(20,120,200,15,13)
		rect(20,120,200 * (health*0.01),15,4)
	}
	
	function Check()
	{
		if (queue.len() > 0)
		{
			if (queue[0].comboCheck(playerInput)== 1)
			{
				playerInput = ""
				queue.remove(0)
			}
			
			else if (queue[0].comboCheck(playerInput) == -1)
			{
				playerInput = ""
				failureFlash = Timer(1)
			}
		}
		
		if (queue.len() == 0)
		{
			queue =stratagemPool.getRandomStratagems(5)
		}
			
	}

	function Input()
	{
		if (failureFlash != null && !failureFlash.isFinished())
			return;
		if (keyp(58) && queue.len() > 0)
		{
			playerInput += "^"
		}
		
		else if (keyp(59) && queue.len() > 0)
		{
			playerInput += "v"
		}
		
		else if (keyp(60) && queue.len() > 0)
		{
			playerInput += "<"
		}
		
		else if (keyp(61) && queue.len() > 0)
		{
			playerInput += ">"
		}		
	}
}