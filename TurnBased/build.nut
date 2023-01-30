// title:   Turn Based Prototype
// author:  Adrian Azan, https://github.com/adrian-azan, etc.
// desc:    A prototype for a basic fight in a turn based RPG
// license: MIT License
// version: 0.1
// script:  squirrel

function Deg2Rad(angle)
{
    return (angle * PI) / 180;
}

function SortByDepth(a,b)
{
    return a.transform.z <=> b.transform.z
}

function DistanceX(obj1, obj2)
{
    if (obj1.transform == null || obj2.transform == null)
        return -1
    return abs(obj1.transform.X() - obj2.transform.X())
}

function DistanceCenterX(obj1, obj2)
{
    return abs(obj1.transform.CenterX() - obj2.transform.CenterX())
}

local OBJECTS = []
local Score = 0



const SCREEN_WIDTH = 240
const SCREEN_HEIGHT = 136



enum Buttons {
    Green = 0,
    Red = 2,
    Blue = 4,
    Yellow = 6,
    B = 64,
    A = 65,
    X = 66,
    Y = 67
}



//TRANSFORM
// The transform will keep track of
// x & y position, and the rotation
// of an ingame object

class Transform
{
	constructor(_x = 0, _y = 0, _z = 0, _scale = 1, _parent = null)
	{
			x = _x
			y = _y
			z = _z
			scale = _scale
			parent = _parent
	}

	function X()
	{
		if (parent != null)
			return parent.x + this.x
		return x
	}

	function CenterX()
	{
		if (parent != null)
			return parent.x + this.x+8
		return x+8
	}

	function Y()
	{
		if (parent != null)
			return parent.y + this.y
		return y
	}

	function CenterY()
	{
		if (parent != null)
			return parent.y + this.y + 8
		return y + 8
	}


	x = null
	y = null
	z = null
	scale = null
	parent = null
}


//Object is the absolute base class
//Everything should exist in the code as an Object

class Object
{
    constructor(trans = null, parentTrans = null)
    {
        OBJECTS.append(this)
        if (trans == null)
            transform = Transform()
        else
            transform = trans


        transform.parent = parentTrans
    }

    transform = null
}


//A Gameobject is something that will likely show up in the game
//Or at least it will exist in the game, even if not visible

class GameObject extends Object
{
    sprite = null
    color = null

    constructor(sp = null, trans = null, parent = null )
    {
        base.constructor(trans, parent)
        sprite = sp
        color = rand()%16
    }

    function SetPosition(_x = 0, _y = 0, _z = 0)
    {
        transform.x = _x
        transform.y = _y
        transform.z = _z
    }

    function Draw()
    {
        if (sprite != null)
            spr(sprite,transform.X(),transform.Y(),0,transform.scale,0,0,2,2)
        else
            rect(transform.x,transform.y, 10*transform.scale, 10*transform.scale, color)
    }

    function Update()
    {

    }
}



class MainMenu extends GameObject
{

    constructor(_player)
    {
        base.constructor()
        base.SetPosition(0,0,-5)

        local d1 = 40
        ItemOption = GameObject(0, Transform(), _player.transform)
        ItemOption.SetPosition(cos(Deg2Rad(70))*d1,-sin(Deg2Rad(70))*d1,0)

        AttackOption = GameObject(2,Transform(),_player.transform)
        AttackOption.SetPosition(cos(Deg2Rad(40))*d1,-sin(Deg2Rad(40))*d1,1)

        DefendOption = GameObject(4,Transform(),_player.transform)
        DefendOption.SetPosition(cos(Deg2Rad(10))*d1,-sin(Deg2Rad(10))*d1,1)

        Focus = 0
        Options = []
        ANGLES = [70,40,10]
        Options.push(ItemOption)
        Options.push(AttackOption)
        Options.push(DefendOption)


        player = _player
    }

    targets = null
    function Draw()
    {
        tri(player.transform.CenterX(),player.transform.CenterY(),
        Options[Focus].transform.CenterX()-5*cos(Deg2Rad(45)),Options[Focus].transform.CenterY()-sin(Deg2Rad(45))*5,
        Options[Focus].transform.CenterX()+5*cos(Deg2Rad(45)),Options[Focus].transform.CenterY()+sin(Deg2Rad(45))*5,
        5)
    }

    function Next()
    {
        Focus += 1
        Focus %= Options.len()
    }

    function Prev()
    {
        Focus -= 1
        if (Focus < 0)
            Focus = Options.len()-1
    }

    ItemOption = null
    AttackOption = null
    DefendOption = null

    Options = null
    Focus = null
    ANGLES = null

    player = null

}




class Button extends GameObject
{
    Letter = null
    Color = null
    constructor(color,letter)
    {
        base.constructor(null,Transform(0,40))
        Letter = letter
        Color = color
    }
    function Draw()
    {
        print(color,40,40)
        #circ(transform.CenterX(), transform.CenterY(),5,2)
       spr(Color,transform.CenterX(), transform.CenterY(),0,1,0,0,2,2)
       spr(Letter,transform.X()+12, transform.Y()+12,0,1,0,0)
    }

    function Update()
    {
        transform.x -= 1
        if (transform.x < -20)
            transform.x = 260
    }
}



class BeatLine extends GameObject
{
    function Draw()
    {
        line(transform.x, transform.y,transform.x, transform.y+40,4)
    }
}



class ActionLane extends GameObject
{
    beatLine = null
    lane = null

    constructor()
    {
        lane = []
        base.constructor()
        AddButton()
        beatLine = BeatLine(null, Transform(50,10,2),null)
    }

    function Draw()
    {
        print(DistanceCenterX(lane[0],beatLine),50,50,4)
    }

    function AddButton()
    {
        local choice = rand() % 4

        if (choice == 0)
            lane.append(Button(Buttons.Blue, Buttons.X))


        if (choice == 1)
            lane.append(Button(Buttons.Green, Buttons.A))


        if (choice == 2)
            lane.append(Button(Buttons.Yellow, Buttons.Y))


        if (choice == 3)
            lane.append(Button(Buttons.Red, Buttons.B))
    }
}




local player = GameObject()
local menu = MainMenu(player)

local enemy = GameObject()

local actionLane = ActionLane( )


player.transform.x = SCREEN_WIDTH * 0.1
player.transform.y = SCREEN_HEIGHT * 0.8
player.transform.scale = 2

enemy.transform.x = SCREEN_WIDTH * 0.8
enemy.transform.y = SCREEN_HEIGHT * 0.8
enemy.transform.scale = 2


OBJECTS.sort(SortByDepth)
function TIC()
{
	cls(10)

	print(Score, 10, 10)

	GRAPHICS_PIPELINE()
	UPDATE_PIPELINE()
	if ( btnp(2) )
	{
		menu.Prev()
		actionLane.AddButton()
	}

	if (btnp(3))
		menu.Next()
}


function GRAPHICS_PIPELINE()
{
	foreach (idx, val in OBJECTS)
	{
		try
		{
			val.Draw()
		}
		catch(exception)
		{
			trace("Graphics Failure" + val)
		}
	}
}

function UPDATE_PIPELINE()
{
	foreach (idx, val in OBJECTS)
	{
		try {
			val.Update()
		} catch (exception){
			trace("Update Failure" + val)
		}

	}
}

// <TILES>
// 000:00000ddd000ddddd00dddddd0ddddddd0ddddddddddddddddddddddddddddddd
// 001:ddd00000ddddd000dddddd00ddddddd0ddddddd0dddddddddddddddddddddddd
// 002:0000022200022222002222220222222202222222222222222222222222222222
// 003:2220000022222000222222002222222022222220222222222222222222222222
// 004:00000bbb000bbbbb00bbbbbb0bbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
// 005:bbb00000bbbbb000bbbbbb00bbbbbbb0bbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbb
// 006:0000044400044444004444440444444404444444444444444444444444444444
// 007:4440000044444000444444004444444044444440444444444444444444444444
// 016:dddddddddddddddddddddddd0ddddddd0ddddddd00dddddd000ddddd00000ddd
// 017:ddddddddddddddddddddddddddddddd0ddddddd0dddddd00ddddd000ddd00000
// 018:2222222222222222222222220222222202222222002222220002222200000222
// 019:2222222222222222222222222222222022222220222222002222200022200000
// 020:bbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbb0bbbbbbb00bbbbbb000bbbbb00000bbb
// 021:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbb0bbbbbb00bbbbb000bbb00000
// 022:4444444444444444444444440444444404444444004444440004444400000444
// 023:4444444444444444444444444444444044444440444444004444400044400000
// 032:000000000000000000000ccc0000c0000000c0000000c0000000c0000000c000
// 033:0000000000000000cc00000000c0000000c0000000c0000000c000000c000000
// 034:000000000000000c000000c0000000c000000c0000000c0000000c000000cccc
// 035:0000000000000000c0000000c00000000c0000000c0000000c000000ccc00000
// 036:000000000000000000c00000000c00000000c00000000c00000000c00000000c
// 037:000000000000000000000c000000c000000c000000c000000c000000c0000000
// 038:00000000000000000000c00000000c00000000c00000000c0000000000000000
// 039:00000000000000000000c000000c000000c000000c000000c0000000c0000000
// 048:0000cccc0000c0000000c0000000c0000000c00000000ccc0000000000000000
// 049:cc00000000c00000000c0000000c0000000c0000ccc000000000000000000000
// 050:0000c0000000c000000c0000000c000000c00000000000000000000000000000
// 051:00c0000000c00000000c0000000c00000000c000000000000000000000000000
// 052:0000000c000000c000000c000000c000000c000000c000000000000000000000
// 053:c00000000c00000000c00000000c00000000c00000000c000000000000000000
// 055:c0000000c0000000c0000000c0000000c0000000000000000000000000000000
// 064:5555550050000550500005505555550050000550500005505555550000000000
// 065:0055500005555500555055505500055055000550555555505500055000000000
// 066:5500005555500555055555500055550000555500055555505550055555000055
// 067:5500550055005500550055000555500000550000005500000055000000550000
// </TILES>

// <WAVES>
// 000:00000000ffffffff00000000ffffffff
// 001:0123456789abcdeffedcba9876543210
// 002:0123456789abcdef0123456789abcdef
// </WAVES>

// <SFX>
// 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
// </SFX>

// <TRACKS>
// 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// </TRACKS>

// <PALETTE>
// 000:16171a7f0622d62411ff8426ffd100fafdffff80a4ff267494216a43006723497568aed4bfff3c10d275007899002859
// </PALETTE>



