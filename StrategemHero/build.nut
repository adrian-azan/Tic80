//
// Bundle file
// Code changes will be overwritten
//

// title:  game title
// author: game developer
// desc:   short description
// script: squirrel

#require "JSONParser.class.nut:1.0.1"

// [included timer]

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
// [/included timer]
// [included prettyFont]

// title:  tiny 5x5 fonts and editor
// author: lb_ii
// desc:   simple editor for 5x5 fonts with samples in Cyrillic, Latin, Greek, Hebrew and even some Japanese writings
// script: lua

/* Tiny font's size is just 5x5 pixels.
-- It requires just 5x4 sprites/tiles.

-- Code usage sample:
--   LBFONTSTART = <TILE_ID>
--   lbprint("PRIVET, MIR;",42,100)

-- Supported letters:

-- +--UPPER MODIFIERS--+
-- |   |   |   |   |   |
-- | $ | ( | ' | ) | # |
-- |   |   |   |   |   |
-- +---+LETTER BASE+---+
-- |                   |
-- | +,-./012 3456789: |
-- | ;<=>?@AB CDEFGHIJ |
-- | KLMNOPQR STUVWXYZ |
-- |                   |
-- +--LOWER MODIFIERS--+
-- |   |   |   |   |   |
-- | ^ | [ | ` | ] | _ |
-- |   |   |   |   |   |
-- +--FONTS SWITCHERS--+
-- | abcdef ghijk      |
-- +-------------------+

-- Letter bases are mapped to 5x5 tiles,
-- which may be sprites of other letters
-- e.g. cyrillic, kana or runic stuff

-- Modifiers add extra pixels like
-- diacritic marks or just additional
-- pixels for letters bigger than 5x5,
-- e.g. 'Q' is good as "O" with "_" mod

-- Lowercase letters switches fonts,
-- e.g. "aPRIVET cIS RUSSIAN FOR HELLO"

----------------------------------------
-- copy to your code to use tiny font --
--                                    --
-- you can remove unused fonts or mods--
-- to save some code space            --
--                                    --
-- | | | | | | | | | | | | | | | | | |--
-- V V V V V V V V V V V V V V V V V V-- */

local LBFONTSTART = 278
local LBFONTCOLOR = 15
local LBSPACEWIDTH= 5
local LBLINESTEP  = 7
local LBFONTS = {
 a = 17,  // Cyrillic
 b = 97,  // Cyrillic Bold
 c = 22,  // Latin
 d = 102, // Latin Bold
 e = 27,  // Hebrew 
 f = 107, // Hebrew Bold
 g = 177, // Greek
 h = 182, // Greek & Math
 i = 273, // Japanese Katakana
 j = 278, // Japanese Hiragana
 k = 283, // Japanese Other
 l = 353, // Runic Slavic
};
local LBFONTMOD = {
    "$": [0, -1],
    "(": [1, -1],
    "'": [2, -1],
    ")": [3, -1],
    "#": [4, -1],
    "^": [0, 5],
    "[": [1, 5],
    "`": [2, 5],
    "]": [3, 5],
    "_": [4, 5]
};

function lbfont5x5(i,x,y)
{
local c = LBFONTSTART;
local X = x - (i % 8) * 5 % 8;
local Y = y - floor(i / 8) * 5 + floor(i / 16) * 8;
c = c + (i % 8) * 5 / 8 + floor(i / 16) % 8 * 16;

 clip(x,y,5,5)
 spr(c,X,Y,0)
 spr(c+1,X+8,Y,0)
 spr(c+16,X,Y+8,0)
 spr(c+17,X+8,Y+8,0)
}

function lbprint(str,x,y)
{
 local X = x-6
 foreach (c in str)
 {
  
  if (c in LBFONTMOD)
  {
    local m = LBFONTMOD[c]
   clip()
   pix(X+m[1],y+m[2],LBFONTCOLOR)
 }
  else if (c == '|')
   X,y = x-6,y+LBLINESTEP
  else if (c == ' ')
   X = X+LBSPACEWIDTH

  else
   X = X+6
   lbfont5x5(c,X,y)
  
 }
 clip()
}

// [/included prettyFont]
// [included stratagem]

// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel


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
// [/included stratagem]
// [included stratagemDuo]

// title:   game title
// author:  game developer, email, etc.
// desc:    short description
// site:    website link
// license: MIT License (change this to your license of choice)
// version: 0.1
// script:  squirrel

class StratagemDuo extends Stratagem
{
	_additionalSpriteId = null
	
	constructor(spriteId, additionalSpriteId, combo,name)
	{
	
		base.constructor(spriteId,combo,name)
		
		_additionalSpriteId = additionalSpriteId
	}
	
	function draw(x,y)
	{
		base.draw(x,y);
		
		spr(_additionalSpriteId,x-7,y+20,15,2,0,0,2,2)

	}
}

// [/included stratagemDuo]
// [included stratagemStorage]

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
// [/included stratagemStorage]
// [included board]


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
// [/included board]
// [included mainMenu]

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
// [/included mainMenu]



t<-0
x<-96
y<-24


local game = Board();
local menuTest = MainMenu()

local TIMERS = []

function TIC()
{
	if (btn(0)) y=y-1;
	if (btn(1)) y=y+1;
	if (btn(2)) x=x-1;
	if (btn(3)) x=x+1;

	cls()
	//game.Update()
	//game.Draw()
	
	menuTest.draw()
	

	if (t % 30 == 0)
		game.health -= 2.5
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
// 006:fffffffffffffffffffffffffffcccfffffcccfffffcccfffffcccfffffccccc
// 007:ffffffffffffffffffffffffffcccfffffcccfffffcccfffffcccfffcccccfff
// 008:ffffffccfffcffccffccfcccfcccccc0fcccccccfcccc0ccfcccccc0f0000000
// 009:ccffffffccffcfffcccfccff0ccccccfcccccccfccc0cccf0ccccccf00cccccf
// 010:ffffffccfffcffccffccfcccfcccccccfcc00000fcc00000fcccccccfcc0000c
// 011:ccffffffccffcfffcccfccffcccccccf0ccccccf0000cccfcccccccfcccccccf
// 012:ffffffffffffffffffffccccfcccccccfc000c00fcccccccfc000c00fc000c00
// 013:ffffffffffffffffcccfffffccccccff0c000cffccccccff0c000cff0c000cff
// 014:ffffffffffffffffffffccccfcccccccfcccccccfcccccc0fccccc00fcccc00c
// 015:ffffffffffffffffcccfffffccccccff0cccccff0cccccffccccccffccccccff
// 016:0000444400004444000044440000444400004444000044440000444400000000
// 017:4444000044440000444400004444000044440000444400004444000000000000
// 018:000ccc0a000ccc0a000ccc0a00accc0a0aa0000a000c0c00000c0c00000c0c00
// 019:a0ccc000a0ccc000a0ccc000a0ccca00a0000aa000c0c00000c0c00000c0c000
// 020:00aaaa0000aaaaaa00aaaaaa00aaaaaa00aaaaaa000aaaaa0000aaaa00000000
// 021:00aaaa00aaaaaa00aaaaaa00aaaaaa00aaaaaa00aaaaa000aaaa000000000000
// 022:fffcccccfffc0000fffc0000fffc0000fffcccccffffffffffffffffffffffff
// 023:cccccfff0ccccfff000ccfff0ccccfffcccccfffffffffffffffffffffffffff
// 024:f0000000fcccccc0fcccc0ccfcccccc0fcccccccffccfcccfffcffccffffffcc
// 025:00c00ccf0ccccccfcccccccf0ccccccfccccccffcccfccffccffcfffccffffff
// 026:fcc00000fcccccccfcc00000fcc00000fcccccccffccfcccfffcffccffffffcc
// 027:0000cccfcccccccf0ccccccf0000cccfccccccffcccfccffccffcfffccffffff
// 028:fc000c00fc000c00fc000c00fcc0ccc0ffccccccfffcccccfffffcccfffffffc
// 029:0c000cff0c000cff0c000cffccc0ccffcccccfffccccffffccffffffffffffff
// 030:fcccc000fcccccccfcccccccfcccccc0ffccccc0fffcccccfffffcccfffffffc
// 031:000cccffc00cccff00ccccff0cccccffcccccfffccccffffccffffffffffffff
// 032:0000000000000002000000220000022200002222000222220022222202222222
// 033:0000000020000000220000002220000022220000222220002222220022222220
// 038:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 039:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 040:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 041:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 042:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 043:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 044:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 045:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 046:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 047:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 048:0000222200002222000022220000222200002222000022220000222200000000
// 049:2222000022220000222200002222000022220000222200002222000000000000
// 054:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 055:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 056:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 057:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 058:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 059:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 060:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 061:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 062:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 063:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
// 064:000000000000000d000000dd00000ddd0000dddd000ddddd00dddddd0ddddddd
// 065:00000000d0000000dd000000ddd00000dddd0000ddddd000dddddd00ddddddd0
// 080:0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd00000000
// 081:dddd0000dddd0000dddd0000dddd0000dddd0000dddd0000dddd000000000000
// 240:ddddddddd0000000d00000000000000000000000d0000000d0000000dddddddd
// 241:7dddddd50000000000000000000000000000000000000000000000007dddddd5
// 242:dddddddd0000000d0000000d00000000000000000000000d0000000ddddddddd
// </TILES>

// <TILES1>
// 033:0000000000000000000000000000000000044000000040000000400000000000
// </TILES1>

// <SPRITES>
// 006:0222222202222222022222220222222202222222022222220222222202222222
// 007:2222222222222222222022222220222022202220222022202220002022222222
// 008:2222222222222222002000202022022020220220002202202022022022222222
// 009:2222222222222222202202222022022220020222202002222022022222222222
// 010:2222222022222220222222202222222022222220222222202222222022222220
// 022:c0c00000c0c00000c0ccc000c0c0c00cc0ccc0c0cccc0c000000cc000ccc00cc
// 023:0000c00000000000000cc00000c000c0000ccc000cccccc00cc0000ccccccc0c
// 024:0000000c000000000000000c0000000cc000000cccc0cccc00000000ccc0000c
// 025:00ccc0000c00cc0c0c0c0c000cc00c0000ccc00cc0ccc00ccc000cc000ccc00c
// 026:c00cccc0c000000cc000ccc0c00c0000cc0ccccccc00000000c0c000ccc00000
// 038:0000c000cccc00000c0000000c00000c0c00000c0000000c0c0000000ccc0ccc
// 039:0c0000cc0ccccc00c000000000ccccc00000000000ccccc0c0000000c0cccccc
// 040:000c00c0ccc00c00c0000ccc0c00c0000c0000cc0c000000c00000c0cccc0ccc
// 041:0c000c0000ccc00c00ccc000cc0c0c0c0c0cccc00c0000cc00ccc0c0cc000ccc
// 042:00c0c000cc000000ccccccc000cc000c00ccccc0cccc000c00ccccc0cccccccc
// 054:c000cc00c0000c00c000cc000ccc0cccc000cc00c00c0c00ccc00c00c00c0c00
// 055:0cc0000c0ccccc0c0cc0000cc0cccccc00c000cc00cc0ccc00c0c0cc00c000cc
// 056:0000c000ccc0c0cc0000c00000000ccc000c0cccc00cc0000c0cc00000ccc000
// 057:0c000c00cccccc00cc000c000c000ccc0cccc00ccc000cc0cc000cc0ccccc00c
// 058:c000000cc000000cc00c000cccc0ccc0cc0cccc000cc000c00cc00c0cc0ccc00
// 070:c000cccc0cccccccc000000c0ccc000c0000c00ccccc000c0000000000000000
// 071:ccc000ccccc000cc00c000c000c000c000c000c0000ccc000000000000000000
// 072:000c0ccc000cc0c0c0c0c0c0c0c0c0c00c000c0c0c000c0c0000000000000000
// 073:0c000000cc000cc0c0c0c00cc00c000000c0c0000c000c000000000000000000
// 074:00cc00cc00cccccc0c0000c0c0000c00c000c000c00ccccc0000000000000000
// 086:0222222202222222022222220222222202222222022222220222222202222222
// 087:2222222222222222222022222220222022202220222022202220002022222222
// 088:2222222222222222002000202022022020220220002202202022022022222222
// 089:2222222222222222202202222022022220020222202002222022022222222222
// 090:2222222022222220222222202222222022222220222222202222222022222220
// 102:c0c0c000c000c0000c0cc00000cc000ccc00c0cccccc0cc0000cccc00ccc00cc
// 103:000cc00000000000000cc000c0cc00c0000ccc00ccccccc0cccc000ccccccc0c
// 104:000000cc00000000000000cccc0000cccc0000ccccc0ccccc000000cccc000cc
// 105:00ccc0000cc0cc0c0ccccc000cc0cc0000ccc00cc0ccc00cccc0cccc00ccc00c
// 106:cc0cccc0cc0000cccc00ccc0cc0cc000cccccccccc00cc000cc0cc00ccc00000
// 118:000cc000cccc00000cc0000c0cc000cc0cc000cc000000cc0cc0000c0ccc0ccc
// 119:cc000ccccccccc00c000000000ccccc00000000000ccccc0c0000000c0cccccc
// 120:c0cc0cc0ccc00cc0cc000ccc0cc0c00c0cc000cc0cc00000cc0000cccccc0ccc
// 121:0cc0cc0000ccc00c00ccc000cc0c0c0c0c0ccccc0c0000cc00ccc0ccccc0cccc
// 122:0cc0cc00cc00cc00ccccccc0ccccc0cc0cccccc0ccccc0cc0cccccc0cc0ccccc
// 134:cc00ccc0cc000cc0cc00ccc00ccc0ccccc00ccc0cc0c0cc0ccc00cc0cc0c0cc0
// 135:cccc000ccccccc0ccccc000cc0cccccc00cc0ccc00cccccc00c0c0cc00c000cc
// 136:c000cc00ccc0cc0cc000cc00c0000cccc00c0ccccc0ccc0ccccccc0cc0cccc0c
// 137:0cc0cc0ccccccc0cccc0cc0c0cc0cccc0cccc000ccc0ccccccc0ccccccccc0cc
// 138:c00000ccc00000ccc00cc0cccc00ccc0000cccc00cccc0cc0cccccc00cccccc0
// 150:cc00cccc0ccccccccc0000cc0ccc00cc000cc0cccccc00cc0000000000000000
// 151:ccc000ccc0cc0ccc00cc0ccc00cc0ccc00cc0cc0000ccc000000000000000000
// 152:c00c0cccc0ccc000c0ccc000c0ccc0c0ccc0cccc0c00cc0c0000000000000000
// 153:0cc0000cccc0ccccc0ccc00cc00c0000c0ccc000ccc0cc0c0000000000000000
// 154:cc0cc0cc0cccccccccc000cccc000cc0cc00cc00c00ccccc0000000000000000
// </SPRITES>

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

