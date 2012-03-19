
shell.run('clear')
rednet.close("back")
rednet.close("front")
rednet.close("bottom")
rednet.close("top")
rednet.close("left")
rednet.close("right")
print('Server ID: '..os.getComputerID())
print('C-SERVER v0.5')

local turtles ={} 
local serverstep = 0

tArgs = {...}
if #tArgs == 0 then
    nextX=25
    nextY=0
elseif #tArgs == 1 then
    nextX=tonumber(tArgs[1])
    nextY=0
    print('1 arg')
elseif #tArgs == 2 then
    nextX=tonumber(tArgs[1])
    nextY=tonumber(tArgs[2])
    print('2 args')
end



local function lite(color,time)
    rs.setBundledOutput('back',color)
    sleep(time)
    rs.setBundledOutput('back',0)
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

rednet.open("back")
rednet.open("front")
rednet.open("bottom")
rednet.open("top")
rednet.open("left")
rednet.open("right")

function listen(  )
    local laction, ltoX, ltoY
    rs.setBundledOutput('back',colors.yellow)
    print("Listning..")
    local ID, text = rednet.receive(3)

    rs.setBundledOutput('back',0)
    if(text == nil) then 
            return false;
    else
      --  rednet.send(ID,'ok')
        laction,ltoX,ltoY = unpack(split(text,','))
        ltoX=tonumber(ltoX)
        ltoY=tonumber(ltoY)
        if(ltoX==nil) then ltoX = 0 end
        if(ltoY==nil) then ltoY = 0 end
        --print(ID,text)
      --  sleep(20)
    end  
    
    ID=ID+1; -- костыль
    sleep(0.1)
    if(turtles[ID]==nil) then
       -- print(turtles[ID])
        table.insert (turtles,ID,{action=laction,toX=ltoX,toY=ltoY,lost=500})
        --print(ID," new turtle")
        lite(colors.lime+colors.yellow,0.3)
        
        return true;
    else

        lite(colors.red+colors.yellow,0.3)
        
        if(turtles[ID].action ~= laction) then
            print(ID..' now '.. laction)
            if(laction == 'idle' or laction == 'hello')then
               --[[ turtles[ID].action='dig'
                turtles[ID].toX=nextX;
                turtles[ID].toY=nextY
                nexX=nextX+1;]]
            elseif(laction == 'lost') then 
                turtles[ID].action='lost'      
                 
            elseif(laction == 'drop') then
               -- turtles[ID].action='idle'
            elseif(laction == 'dig') then
                -- it's ok
                turtles[ID].action='dig'
            else
                turtles[ID].action='lost'

            end
        else
            print(ID,' still doin ',laction)
        end
    end
end

function update()
    print('Updating...')
    lite(colors.lime+colors.red,0.3)
    for i,v in pairs(turtles) do
        if(v.lost <= 0) then v.action = 'lost' end
        if(v.action=="idle" or v.action == 'hello') then
            v.action = 'dig'
            v.toX = nextX
            v.toY = nextY
            nextX=nextX+1;
            v.lost = 500
            if(nextX>100) then
                nextX=25
                nextY=nextY+1
            end
        end
        if(v.action=="lost") then
            print(i.." is lost somevere near to ",v.toX,":",v.toY);
            lite(colors.red,1)
            lite(0,0.3)
            lite(colors.red,1)
            lite(0,0.3)
            lite(colors.red,1)
            lite(0,0.3)
            table.delete(turtles,i)
        end
        if(v.action=="drop") then
            print(i.." dropin");
        end

        if(v.action=='dig') then
        end
    end

end



function send(  )
    local x = 1
    print('Sending...')
    lite(colors.lime+colors.red+colors.yellow,0.3)
    for k,v in pairs(turtles) do
        rednet.send(k-1,v.action..','..v.toX..','..v.toY)
        if(math.fmod(x,3)== 0) then
            print(' ',k,' ',v.action,' ',v.toX,':',v.toY)
            else
            write(' '..k..' '..v.action..' '..v.toX..':'..v.toY)
            end

        v.lost = v.lost-1
        x=x+1
    end -- color
end

while true do
    rs.setBundledOutput('back',colors.lime)
    serverstep=serverstep+1
   -- print(serverstep.." serverstep")
    listen()

   


    update()
  --  newoders()
    send()
    rs.setBundledOutput('back',colors.lime)
    sleep(0.3)
    --shell.run('clear')
end









