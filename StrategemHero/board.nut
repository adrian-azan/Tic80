
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
			queue[i].draw(i*64+15,5)
		}
	
		if (queue.len() > 0)
		{
			local _combo = queue[0].combo()
			local name = queue[0]._name

			local comboWidth = 25*_combo.len()
			local sideBuffer = (240-comboWidth)/2
			
			
			foreach(i, value in _combo)
			{
				local rotation = 0;

				if (value == '>')
					rotation = 1
				else if (value == 'v')
					rotation = 2
				else if (value == '<')
					rotation = 3
				
				if (failureFlash != null && !failureFlash.isFinished())
					spr(32, sideBuffer + 25*i + (rand() % 6 - 3), 100 + (rand() % 6 - 3), 0, 1, 0,rotation,2,2)				
				else if (i < playerInput.len())
					spr(0, sideBuffer + 25*i, 100, 0, 1, 0,rotation,2,2)
				else
					spr(64, sideBuffer + 25*i, 100, 0, 1, 0,rotation,2,2)
			}
			
			local nameWidth = print(name,0,-10)
			local nameSideBuffer = (240-nameWidth)/2
			
			
			rect(20,65,200,15,4)
			print(name,nameSideBuffer,70)
		}
		rect(20,120,200,10,13)
		
		if(health<15)
			rect(20,120,200 * (health*0.01),10,2)
		else if (health < 30)
			rect(20,120,200 * (health*0.01),10,3)
		else
			rect(20,120,200 * (health*0.01),10,4)
	}
	
	function Check()
	{
		if (queue.len() > 0)
		{
			if (queue[0].comboCheck(playerInput)== 1)
			{
				playerInput = ""
				health +=5
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