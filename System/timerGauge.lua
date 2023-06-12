local timerGauge = 
{
	sprite = nil,
  width = 464,
  height = 28,
  accTime = 0
}

function timerGauge:start()
  timerGauge.sprite = lgN('ImagePacks/ui/timer.png')
  timerGauge.accTime = 0
end

function timerGauge:update(dt)
  timerGauge.accTime = timerGauge.accTime + dt
end

function timerGauge:draw()
  local posX = g_screen.width / 2 - timerGauge.width / 2
  local posY = 15
  
  love.graphics.draw(timerGauge.sprite, posX, posY)
  local outThick = 4
  local fillPosX = posX + outThick
  local fillPosY = posY + outThick
  local fillWidth = timerGauge.width - outThick * 2
  local fillHeight = timerGauge.height - outThick * 2
  local fillRate = timerGauge.accTime / g_clearTime

  lg.setColor(1,1,1,.3)
  lg.rectangle("fill", fillPosX, fillPosY, fillWidth, fillHeight)
  lg.setColor(1,1,1)
  lg.rectangle("fill", fillPosX, fillPosY, fillWidth * fillRate, fillHeight)

  lg.setColor(1,1,1,1)
end

return timerGauge