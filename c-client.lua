shell.run('clear')
print('Turtle ID: '..os.getComputerID())
print('C-CLINET')
print('V - 000005')

--write('Host ID: ')
--sender = read()

local action = 'hello'
local X,Y,Z = 1,1,64
local dX,dY=0,0
local toX, toY = 1,1
local naction,msg,ID
local new = false
local Xok,Yok = false,false
local oldX, oldY = 0,100000



local function fluTo(  )
	print('Goin to ',toX,';',toY)
 		repeat
 		if(toX == X) then 
 			Xok=true
 			dX=0
 		elseif(toX>X) then
 			Xok=false
 			dX=1
 			turtle.turnRight()
 			
 			
 		elseif(toX<X) then
 			Xok = false
 			dX=-1
 			turtle.turnLeft()
 			
 			
 		end

 		while(toX~=X) do
 			X=X+dX
 			turtle.forward()
 		end

 		if(toX == X) then 
 			Xok=true
 		end
 		if(dX==1) then
 			Xok=false
 			
 			
 			turtle.turnLeft()
 			
 		elseif(dX==-1) then
 			Xok = false
 			
 			
 			turtle.turnRight()
 			
 		end

 		if(toY == Y) then 
 			Yok=true
 			dY=0
 		elseif(toY>Y) then
 			Yok=false
 			turtle.forward()
 			dY=1
 		elseif(toY<Y) then
 			Yok = false
 			turtle.back()
 			dY=-1
 		end

 		
 		Y=Y+dY

 		while(toY~=Y) do
 			Y=Y+dY
 			if(dY >0) then turtle.forward() else turtle.back() end
 		end
 		until (Xok == true and Yok == true)
end 


local function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end


--shell.run('clear')
 rednet.open("right")


rednet.broadcast('hello,1,1')
sleep(0.2)
rednet.broadcast('hello,1,1')
sleep(0.2)
rednet.broadcast('hello,1,1')
sleep(0.2)
rednet.broadcast('hello,1,1')
sleep(0.2)
rednet.broadcast('hello,1,1')
sleep(0.2)

 while true do
 	if( action == 'hello' or action == 'idle') then
 		if(rs.getInput('left')~=true) then action = 'lost'  
 		else


 		sleep(3)
  		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		rednet.broadcast(action..',1,1')
		sleep(0.4)
		print(action)
 		print('Listning..')
 		ID,msg=rednet.receive(5)
 		print(msg)
 		if(msg ~= nil) then
 			naction,toX,toY = unpack(split(msg,','))
 			toX= tonumber(toX)
 			toY= tonumber(toY)

 			if(naction ~= action) then
 				action = naction
 				new = true 
 			else
 				new = false
 			end
 		else 
 			new = false
 		end
 		end
 	end

 	if(new == true) then
 	end

 	if(action == 'dig') then 
 		print('Flyin UP')
 		while (Z<128) do
 			Z=Z+1

 			turtle.up()

 		end
 		print('Goin to ',toX,';',toY)
 		fluTo()

 		print('Digin')
 		while (Z>6) do 
 			turtle.digDown()
 			turtle.down()
 			Z=Z-1
 		end
 		print('Flyin up again')
 		while (Z<128) do
 			Z=Z+1
 			turtle.up()
 		end
 		print('next - drop')
 		action = 'drop';
 		toX = 1
 		toY = 1
 	end
 	if(action == 'drop') then
 		print ('Dropin')
 		print('Flyin UP')
 		while (Z<128) do
 			Z=Z+1
 			if(turtle.detectUp()) then turtle.back() sleep(4) turtle.forward() end
 			turtle.up()

 		end
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		turtle.back()
 		fluTo()
 		
 		print('down to dropzone')
 		while not turtle.detectDown() do
 			Z=Z-1

 			turtle.down()

 		end
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()
 		turtle.forward()

 		for i=1,9 do
 			turtle.select(i)
 			turtle.drop()
  		end
 		print('next - idle')
 		action = 'idle'
 	end
 	if(action=='lost') then
 	--	turtle.digUp()
 	--	turtle.up()
 		shell.run('a1')
 	end
print(action..','..toX..','..toY)
rednet.broadcast(action..','..toX..','..toY)
sleep(0.1)

 	
end
