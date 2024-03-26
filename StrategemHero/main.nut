// title:  game title
// author: game developer
// desc:   short description
// script: squirrel

#require "JSONParser.class.nut:1.0.1"

include("timer")
include("stratagem")
include("stratagemDuo")
include("stratagemStorage")
include("board")


t<-0
x<-96
y<-24


local game = Board();

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

