local button = {}
local buttons = {}

function button:new(name, x, y, active)
   local bn = {img = {}}
   bn.state = 0
   bn.img[0] = lgN('ImagePacks/ui/btn/'..name..'_0.png')
   bn.img[1] = lgN('ImagePacks/ui/btn/'..name..'_1.png')
   bn.img[2] = lgN('ImagePacks/ui/btn/'..name..'_2.png')
   bn.width = bn.img[1]:getWidth()
   bn.height = bn.img[1]:getHeight()
   bn.left = x - bn.width/2
   bn.top = y - bn.height/2
   --bn.func = func
   if active == nil then
     bn.active = false
   else
     bn.active = active
   end

   buttons[name] = bn
end

function button.update(dt)
	local mx, my = love.mouse.getPosition()

	for k, v in pairs(buttons) do
    --마우스 hover 상태
		if v.active
    and mx >= v.left
    and mx <= v.left + v.width
    and my >= v.top
    and my <= v.top + v.height then
      --down 확인
      if love.mouse.isDown(1) then
        v.state = 2
      else
        v.state = 1
      end

  --    if love.mouse.isDown(1) then
  --      mousedebug = tostring(love.mouse.isDown)
  --    end
    else
      v.state = 0
		end
    if v.state ~= 0 then break end
	end
end


function button:draw()
  --local i = 0
  for k, v in pairs(buttons) do
    --i = i + 1
    --lg.print(v.state, 300, 12*i)
    if v.active then
      lg.draw(v.img[v.state], v.left, v.top)
    end
  end

  --lg.print(tostring(love.mouse.isDown(1)), 15, 40)
end

function button:click()
  for k, v in pairs(buttons) do
    if v.state == 2 then
      fireEvent(k)
      break
    end
  end
end

function button:active(name, boolean)
  if buttons[name].active ~= boolean then
    buttons[name].active = boolean
  end
end



--이벤트

function fireEvent(name)
  --title
  if name == "help" then
    page:changePage(stat[2])
  elseif name == "play" then
    page:changePage(stat[3])
  elseif name == "retry" then
    page:changePage(stat[3])
  elseif name == "exit" then
    love.event.push("quit")
  end

end

return button
