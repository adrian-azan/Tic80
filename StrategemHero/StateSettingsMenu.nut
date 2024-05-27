class StateSettingsMenu
{
	menuText = null
	choice = null

	constructor()
	{
		 menuText = ["Nothing"]
		 choice = menuPointer(1);
	}

	function draw()
	{
		drawBoxes()
	}

	function drawBoxes()
	{

		for (local i = 0; i < 1; i++)	
		{
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
	}
}




