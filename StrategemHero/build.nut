//
// Bundle file
// Code changes will be overwritten
//

// title:  game title
// author: game developer
// desc:   short description
// script: squirrel

#require "JSONParser.class.nut:1.0.1"

// [TQ-Bundler: timer]

// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel


class Timer
{
	length = null
	start = null
	
	constructor(Length)
	{
		length = Length*1000
		start = time()
	}
	
	function isFinished()
	{
		if (time() - start > length)
			return true
		return false
	}
	
	function reset()
	{
		start = time()
	}
	
	function toString()
	{
		return format("%d",time(),start)
	}
	


}

// [/TQ-Bundler: timer]

// [TQ-Bundler: board]


#require "math"

class Board
{
	round = null
	queue = null
	score = null
	health = null
	playerInput = null
	failureFlash = null
	
	constructor()
	{
		round = 0
		score = 0
		health = 100
		playerInput = ""
		
		queue = []
				
		queue.push(Stratagem(2,"^^vv<>"))
		queue.push(Stratagem(4,">>>"))	
		
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
			queue[i].draw(i*64,0)
		}
	
		if (queue.len() > 0)
		{
			local _combo = queue[0].combo()


			local comboWidth = 30*_combo.len()
			local sideBuffer = (240-comboWidth)/2
			local rotation = 0;
			
			
			for (local i = 0; i < _combo.len(); i++)
			{
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
			
			if (queue[0].comboCheck(playerInput) == -1)
			{
				playerInput = ""
				failureFlash = Timer(1)
			}
		}
	}

	function Input()
	{
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

// [/TQ-Bundler: board]

// [TQ-Bundler: stratagem]

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

// [/TQ-Bundler: stratagem]


t<-0
x<-96
y<-24


local game = Board();
local test = Stratagem(2,"^^vv<>");

local TIMERS = []

function TIC()
{
	if (btn(0)) y=y-1;
	if (btn(1)) y=y+1;
	if (btn(2)) x=x-1;
	if (btn(3)) x=x+1;

	cls(0)
	game.Update()
	game.Draw()
	
	

	if (t % 30 == 0)
		game.health -= 1
	t=t+1
}


// script: squirrel

// <TILES>
// 000:0000000000000004000000440000044400004444000444440044444404444444
// 001:0000000040000000440000004440000044440000444440004444440044444440
// 002:0000000000000000000aaaaa000aaaaa0000000a000ccc0a000ccc0a000ccc0a
// 003:0000000000000000aaaaa000aaaaa000a0000000a0ccc000a0ccc000a0ccc000
// 004:000000000000000000aaaaaa00aaaaaa000aaaaa00a0aaaa00aa000000aaaa0a
// 005:0000000000000000aaaaaa00aaaaaa00aaaaa000aaaa0a000000aa00a0aaaa00
// 016:0000444400004444000044440000444400004444000044440000444400000000
// 017:4444000044440000444400004444000044440000444400004444000000000000
// 018:000ccc0a000ccc0a000ccc0a00accc0a0aa0000a000c0c00000c0c00000c0c00
// 019:a0ccc000a0ccc000a0ccc000a0ccca00a0000aa000c0c00000c0c00000c0c000
// 020:00aaaa0000aaaaaa00aaaaaa00aaaaaa00aaaaaa000aaaaa0000aaaa00000000
// 021:00aaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaa000aaaa000000000000
// 032:0000000000000002000000220000022200002222000222220022222202222222
// 033:0000000020000000220000002220000022220000222220002222220022222220
// 048:0000222200002222000022220000222200002222000022220000222200000000
// 049:2222000022220000222200002222000022220000222200002222000000000000
// 064:000000000000000d000000dd00000ddd0000dddd000ddddd00dddddd0ddddddd
// 065:00000000d0000000dd000000ddd00000dddd0000ddddd000dddddd00ddddddd0
// 080:0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd00000000
// 081:dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd000000000000
// </TILES>

// <WAVES>
// 000:00000000ffffffff00000000ffffffff
// 001:0123456789abcdeffedcba9876543210
// 002:0123456789abcdef0123456789abcdef
// </WAVES>

// <SFX>
// 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
// </SFX>

// <PALETTE>
// 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
// </PALETTE>

