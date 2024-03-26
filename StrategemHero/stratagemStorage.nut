// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel

class StratagemStorage
{
	allStratagems = null
	constructor()
	{
		allStratagems = {}
		
		allStratagems["Backpack"] <- [Stratagem(4,"<<^"),Stratagem(2,"^vv^^"),
		StratagemDuo(4,6,"v<v^^v")]
	}
	
	
	function getRandomStratagems(amount)
	{
		local output = []
	
		for (local i = 0; i < amount; i++)
		{
			local randomCategory = rand() % 1;
			
			if (randomCategory == 0)
			{
				local categorySize = allStratagems["Backpack"].len()
				output.push(allStratagems["Backpack"][rand()%categorySize])
			}
		}
		
		return output;
		
	}


}