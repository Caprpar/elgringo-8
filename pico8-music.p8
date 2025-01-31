pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- init --
function _init() 
	player={
		x=70,
		y=90,
		ox=0,
		oy=0,
		dx=0,
		dy=0,
		w=4,
		h=5,
		max_dx=3,
		max_dy=3,
		acc=0.5,
		boost=4,	
		fliped=false,
		sp=1,
		running=false,
		falling=false,
		flying=false
	}
 
 gravity=0.3 friction=0.85
	clock = 0 timer = 0.25
end



-->8
-- update --
function _update()
	-- offset position
	player.ox = player.x-2
	player.oy = player.y-3

	--player.dy+=gravity
 player.dx*=friction
	player.dy*=friction
	
	-- movement detection --
	
 if (btn(⬅️)) then 
  player.dx-=player.acc
  player.flipped = true
 end
 
 if (btn(➡️)) then
  player.dx+=player.acc
  player.flipped = false
	end
	
 if (btn(⬆️)) then
  player.dy-=player.acc
	end

 if (btn(⬇️)) then
  player.dy+=player.acc
	end
	
	-- update player cords --

	player.dx=mid(
	-player.max_dx,
	player.dx,
	player.max_dx)

	player.dy=mid(
	-player.max_dy,
	player.dy,
	player.max_dy)
	
	-- collision calculation
	if cmap((player.ox + player.dx),
	 player.oy,
	 player.w,
	 player.h) then
		player.dx = 0
	end
	
	if cmap(player.ox,
	(player.oy + player.dy),
	player.w,
	player.h) then
		player.dy = 0
	end
	
	player.x+=player.dx
	player.y+=player.dy
	
	-- set player action --
	
	if player.dx > .5 
	or player.dx < -.5 then 
		player.running = true
	else 
		player.running = false 
	end
	
	if player.dy > .5 then 
		player.falling = true
	else 
		player.falling = false 
	end
	
	if player.dy < -.5 then 
		player.flying = true
	else 
		player.flying = false 
	end
	
	if (player.falling) then 
		animate(player,32,33)
	elseif (player.running) then
		animate(player,16,18)
	elseif (player.flying) then
		animate(player,48,49)
	else animate(player,0,1)
	end
	
	animate(coin,3,4)
	
	
			
end

-->8
-- draw -- 
function _draw() 
	cls()
	map(0,0,0,0,128,32)
	spr(
		player.sp, 
		player.ox, 
		player.oy,
		1,
		1,
		player.flipped)
	
	spr(coin.sp, coin.x, coin.y,1,1)
		
	print("dx= "..player.dx)
	print("dy= "..player.dy)
	print(player.sp)
	print(clock)
	print(player.x)
	print(player.y)
	local ax = flr(player.x)
	local ay = flr(player.y)
	print(ax)
	--print(fget(mget(ax/8, ay/8)))
	--print(cmap(player))
end
-->8
-- animate --
function animate(obj,st,en)
	--obj has .sp
	--st = start sprite
	--en = end sprite
	if obj.sp < st or en > obj.sp then
		obj.sp = st
	end
	
	local timer = 10
	clock += 1
		
	if clock > timer then	
		obj.sp += 1
		clock = 0
	end
	
	if (obj.sp > en) then 
		obj.sp = st 
	end
	
end
-->8
-- coin --
coin = {
	x = 63,
	y = 63,
	sp = 3,
}

-->8
-- collisions

-- expexts object a to have
-- a.x, a.y, a.w, a.h
-- same with object b
function aabb(a,b)
	return not(a.x < b.x + b.w or
		a.y < b.y + b.h or
		a.x + a.w > b.x or
		a.y + a.h > b.y)
end

function cmap(x, y, w, h)
	local col = false
	--if (fget(mget(o.x, o.y)) > 0) then col = true end
	for i=x, x+w, w do
		if (fget(mget(i/8,y/8)) > 0) or
		(fget(mget(i/8, (y + h)/8)) >0) then
			col = true
		end
	end
	for i=y, y+h,h do
		if (fget(mget(i/8,x)) > 0) or 
		(fget(mget(i/8,x + w)) > 0) then
			col = true
		end
	end
	return col
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0088a800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007888800088a800000000000007a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007070000078888000000000000a90000007a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007070000000000000000000000a90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700600007006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0088a8000088a8000088a80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788880007888800078888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00707000007070000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700077777000077770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700600000600000007600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000800000a88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0008a880008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00707000007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000600007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888000008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788a8000788a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00707880007078800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700600007006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
97aaaaf5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9aa99ff5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a97a4f5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a9af4f5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9af44ff5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9ffffff5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
95555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888777777888888888888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88778877788888888888888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee87777877788888e88888888888888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8777787778888eee8888888888888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee87777877788888e88888888888888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee877788877888888888888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee877777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111ddd1d111ddd1d1d1ddd1ddd11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111d1d1d111d1d1d1d1d111d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1ddd1ddd11111ddd1d111ddd1ddd1dd11dd111111ddd1ddd11111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111d111d111d1d111d1d111d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111d111ddd1d1d1ddd1ddd1d1d11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661611166616161666166611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16161611161616161611161611111777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661611166616661661166111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16111611161611161611161611111777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16111666161616661666161611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822288828222888888888888888888888888888888888888888888888888888888888228822282828882822282288222822288866688
82888828828282888888888288288882888888888888888888888888888888888888888888888888888888888828828282828828828288288282888288888888
82888828828282288888822288288222888888888888888888888888888888888888888888888888888888888828828282228828822288288222822288822288
82888828828282888888828888288288888888888888888888888888888888888888888888888888888888888828828288828828828288288882828888888888
82228222828282228888822282888222888888888888888888888888888888888888888888888888888888888222822288828288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000004040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
03020000080550a0700a07008050050400103000020000000a0000800006000030000100000000230002400011000180002400015000230002100011000290001100024000110002100024000110002300024000
011000000e0001a000240000e00023000210000e000290000e000240000e00021000240000e0002300024000100001c0002300010000210002000010000280001000023000100002000022000100002100023000
4a0200003967439675396043960439604396043960439604000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000e0001a000240000e00023000210000e000290000e000240000e00021000240000e0002300024000100001c0002300010000210002000010000280001000023000100002000022000100002100023000
01100000150501c050240501505123050210501505028050150502405015050210502405115050230502405011050180502405015051230502105011050290501105024050110502105024051110502305024050
011000000e0501a050240500e05123050210500e050290500e050240500e05021050240510e0502305024050100501c0502305010051210502005010050280501005023050100502005022051100502105023050
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a91000000e0101a030240300e03123030210300e030290300e010240300e03021030240310e0302303024030100101c0302303010031210302003010030280301001023030100302003021030230302603028030
a9100000150301c030240301503123030210301503028030150302403015030210302403115030230302403011030180302403015031230302103011030290301103024030110302103024031110302303024030
a91000000e0301a030240300e03123030210300e030290300e030240300e03021030240310e0302303024030100301c0302303010031210302003010030280301003023030100302003022031100302103023030
a9100000150101c030240301503123030210301503028030150102403015030210302403115030230302403011010180302403015031230302103011030290301101024030110302103024031110302303024030
a91000000e0101a030240300e03123030210300e030290300e010240300e03021030240310e0302303024030100101c030230301003121030200301003028030100102303010030200300000010000210000a000
a91000000e0101a030240300e03123030210300e030290300e010240300e03021030240310e0302303024030100101c0302303010031210302003010030280301001023030100302003014031100002100023000
bd100000211251c105241251c105281251c105211251c105241251c105281251c10521125241252612528125291251c105211251c105241251c105291251c105211251c105241251c105291251c105211251c105
bd100000261251c105291251c105211251c100261251c105291252112526125291252d1252b1252912528125261251c1001c1251c100201251c100261251c1001c1251c100201251c10026125241252312520125
b1100000211251c105241251c105281251c105211251c105241251c105281251c10521125241252612528125291251c105211251c105241251c105291251c105211251c105241251c105291251c105211251c105
01100000261251c105291251c105211251c100261251c105291252112526125291252d1252b1252912528125261251c1001c1251c100201251c100261251c1001c1251c100201251c10026125241252312520125
a91000000e0101a030240300e03123030210300e030290300e010240300e03021030240310e0302303024030100101c0302303010031210302003010030280301001023030100302003022031100302103023030
011000000901009030090300903009030090300903009030090100903009030090300903009030090300903005010050300503005030050300503005030050300501005030050300503005030050300503005030
011000000201002030020300203002030020300203002030020100203002030020300203002030020300203004010040300403004030040300403004030040300401004030040300403004030040300403004030
bd100000261251c105291251c105211251c100261251c1052912521125261252112529125281252612524125261251c1001c1251c100201251c100261251c1001c1251c100201251c10026125241252312520125
011000000201002030020300203002030020300203002030020100203002030020300203002030020300203004010040300403004030040300403004030040300401004030040300403000000000000400004000
011000000901109031090310903109011090310903109031090110903109031090310901109031090310903105011050310503105031050110503105031050310501105031050310503105011050310503105031
011000000201102031020310203102011020310203102031020110203102031020310201102031020310203104011040310403104031040110403104031040310401104031040310403104011040310403104031
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000181351c1051c1351c105211351c105181351c1051c1351c105211351c10518135151351613517135181351c1051d1351c105211351c105181351c1051d1351c105211351c105181351c1051d1351c105
01100000151351c1051a1351c1051d1351c105151351c1051a1351c1051d1351c105151351c1051a13517100171351c1051c1351c105201351c105171351c1051c1351c105201351c10526135241352313520135
01100000181351c1051c1351c105211351c105181351c1051c1351c105211351c1051813515135161351713518100181351c1051d1351c105211351c105181351c1051d1351c105211351c105181351c1051d135
011000000c073130003060015000006752100015000280000c0731c0003060015000006752100015000280000c0731c0003060015000006752100015000280000c0731c000306001500000675210001500028000
011000000c073130003060015000006752100015000280000c0731c0003060015000006752100015000280000c0731c0003060015000006752100015000280000c0731c000306001500000615006250063500645
5f1000000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa000c0731fa001ca001fa00
011000000c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa54
0110000028a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa4428a641fa441ca741fa44
011000000c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa001ca001fa000c0001fa001ca001fa000c0001fa001ca001fa000c0001fa001ca001fa00
011000000c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c073000000000000000
011000000c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa54006751fa541ca641fa54
011000000c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa54006751fa541ca641fa540c0731fa541ca641fa5400615006250063500645
01100000151351c1051a1351c1051d1351c105151351c1051a1351c1051d1351c105151351c1051a1351710017100171351c1051c1351c105201351c105171351c1351c1052010020135261001c1551a15518155
b11000001811118111181111811118111181111811118111181111811118111181111811118111181111811118111181111811118111181111811118111181111811118111181111811118111181111811118111
b91000001c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111c1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d111
b91000001d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d1111d11114111141111411114111141111411114111141111411114111141111411114111141111411114111
b11000001a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a1111a111
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bd0800002612524100241252010023125000002012500000261152410024115201002311500000201150000004115081150b1150e1151011514115171151a1151c125201252312526125281252c1252f12532125
bd0810002912524100241252010023125000002012500000261152410024115201002311500000201150000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa540c0731fa541ca641fa5400615006250063500645
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4a20000018a5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 4a4b430a
00 4a4c430b
00 1e14430c
00 1e17430e
00 1e140f0c
00 1e151013
00 1e140f0c
00 1f17100d
00 21280f29
00 212b162a
00 21180f29
00 2319102a
00 60422d4a
00 2242430a
00 2242430b
00 2142430a
00 2442430e
00 211b5b0a
00 211c500b
00 211d0f0a
00 32271609
00 25140f0c
00 25151013
00 25140f0c
00 26151609
00 60422e4a
00 60586869
00 60596a6b
00 61586869
00 61596a6b
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 60586869
00 60596a6b
00 61586869
00 61596a6b

