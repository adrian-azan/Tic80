// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel

class MainMenu
{
	menuText = null

	constructor()
	{
		 menuText = ["Play","Settings","Quit"]
	}

	function draw()
	{
		drawBoxes()
			
			
	}

	function drawBoxes()
	{

		for (local i = 0; i < 3; i++)
		{
			local scale = 2
			local length = 5;
			local left = 120-(length*8*scale)/2
			local top = 40+i*32


			spr(240,left,top,0,2)
			local l = 1;
			for (; l <= length-2; l++)
			{	
				spr(241,left+16*l,top,0,2)
			}
			spr(242,left+16*l,top,0,2)

			local nameWidth = print(menuText[i],0,-10)
			local nameSideBuffer = (240-nameWidth)/2

					print(menuText[i],nameSideBuffer,top+6)

		}
	}
}