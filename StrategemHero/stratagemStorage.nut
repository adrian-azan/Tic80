class StratagemStorage
{
	allStratagems = null
	constructor()
	{
		allStratagems = {}
		
		allStratagems["Backpack"] <- [Stratagem(2,"v^^v^","LIFT-850 Jump Pack"),
		StratagemDuo(4,6,"v<v^^v","B-1 Supply Pack"),StratagemDuo(4,8,"v^<^>>","AX/LAS-5 \"Gaurd Dog\" Rover"),
		StratagemDuo(4,10,"v^<^>v","AX/AR-23 \"Guard Dog\""),StratagemDuo(4,12,"v<vv^<","SH-20 Ballistic Shield Backpack"),
		StratagemDuo(4,14,"v^<><>","SH-32 Shield Generator Pack")]
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