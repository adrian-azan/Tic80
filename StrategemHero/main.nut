// title:  game title
// author: game developer
// desc:   short description
// script: squirrel

#require "JSONParser.class.nut:1.0.1"
include("Constants")
include("Timer")
include("RepeatTimer")
include("Stratagem")
include("StratagemDuo")
include("StratagemStorage")
include("ClassicMode")
include("MenuPointer")
include("StateMainMenu")


local game = ClassicMode()
local mainMenu = StateMainMenu()
local settingsMenu = null

local game_state = {}
game_state[STATE_MENU_MAIN] <- mainMenu
game_state[STATE_GAME] <- game

local TIMERS = []

function TIC()
{
	cls()

	game_state[GAME_STATE].update()
	game_state[GAME_STATE].draw()
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

