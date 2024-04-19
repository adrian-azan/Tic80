class StateGameOverMenu
{
	
	menuText = null
	choice = null

	constructor()
	{
		menuText = ["Run It Back", "Too Hawd, I Qwit"]
		choice = menuPointer(2);
	}


	function draw()
	{
		local scale = 3
		local spriteId = [243,244,245,246,247,248,246,249]

		for (local i = 0; i < spriteId.len(); i++)
		{
			spr(spriteId[i],(scale * i * 8) + (3*i)+10,30,-1,scale)
		}
		

			for (local i = 0; i < 2; i++)
		{
			local scale = 2
			local length = 6;
			local left = 120-(length*8*scale)/2
			local top = 80+i*32


			spr(240,left,top,0,2)
			local l = 1;
			for (; l <= length-2; l++)
			{	
				spr(241,left+16*l,top,0,2)
			}
			spr(242,left+16*l,top,0,2)

			local nameWidth = print(menuText[i],0,-10)
			local nameSideBuffer = (240-nameWidth)/2

			//Highlight selected option
			if (choice.eq(i))
			{
				rect(left+2,top+2,92,12,4)
			}

			print(menuText[i],nameSideBuffer,top+6)
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

		if (keyp(48) && choice.eq(0))
		{
			GAME_STATE = "Game"
		}

		if (keyp(48) && choice.eq(1))
		{
			exit()
		}		
	}
}