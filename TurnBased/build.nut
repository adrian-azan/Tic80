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
    function Draw()
    {
        circ(transform.CenterX(), transform.CenterY(),12,2)
        spr(32,transform.X(), transform.Y(),0,1,0,0,2,2)
    }

    function Update()
    {
        transform.x -= 2
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
    B = null

    constructor()
    {
        base.constructor()
        B = Button()
        beatLine = BeatLine(null, Transform(50,10,2),null)
    }

    function Draw()
    {
        print(DistanceCenterX(B,beatLine),50,50,4)
    }
}




local player = GameObject()
local menu = MainMenu(player)

local enemy = GameObject()

local actionLane = ActionLane()


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
		menu.Prev()

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
// 000:0000000000000000000000000000000000000ddd0000dddd000ddddd000ddddd
// 001:00000000000000000000000000000000ddd00000dddd0000ddddd000ddddd000
// 002:0000000000000000000000000000000000000222000022220002222200022222
// 003:0000000000000000000000000000000022200000222200002222200022222000
// 004:0000000000000000000000000000000000000bbb0000bbbb000bbbbb000bbbbb
// 005:00000000000000000000000000000000bbb00000bbbb0000bbbbb000bbbbb000
// 016:000ddddd000ddddd000ddddd0000dddd00000ddd000000000000000000000000
// 017:ddddd000ddddd000ddddd000dddd0000ddd00000000000000000000000000000
// 018:0002222200022222000222220000222200000222000000000000000000000000
// 019:2222200022222000222220002222000022200000000000000000000000000000
// 020:000bbbbb000bbbbb000bbbbb0000bbbb00000bbb000000000000000000000000
// 021:bbbbb000bbbbb000bbbbb000bbbb0000bbb00000000000000000000000000000
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



