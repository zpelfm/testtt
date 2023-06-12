debug = {}

function showDebug()
  if pageName == "play" then
    love.graphics.setColor(0,0,0)
  end
  love.graphics.setNewFont('Fonts/malgun.ttf', 12)
  for i, v in pairs(debug) do
    love.graphics.print(debug[i], 15, 15 * i)
  end
  love.graphics.setColor(1,1,1)
end

function updateDebug()
    debug[1] = "모드 :  "..tostring(pageName)
    debug[2] = "남은시간 :  "..leftTime
end
