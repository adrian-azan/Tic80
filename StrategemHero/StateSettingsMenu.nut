class StateSettingsMenu
{
	menuText = null
	choice = null

	constructor()
	{
		 menuText = ["fart"]
		 choice = menuPointer(1);
	}

	function draw()
	{
		drawBoxes()
	}

	function drawBoxes()
	{

		for (local i = 0; i < 1; i++)	{
			


			print(menuText[i],20,20)
		}
	}


	function update()
	{
		if (keyp(59) || btnp(1))
		{
			choice += 1
		}

		else if (keyp(58) || btnp(0))
		{
			choice -= 1
		}

		if (keyp(48) && choice.eq())
		{
			
		}

		if (keyp(48) && choice.eq())
		{
			
		}	
	}
}




