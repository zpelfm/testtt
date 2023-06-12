
local goal = {
  sprite = lgN('ImagePacks/sprites/minigame_play/goal.png'),
  disRate = 0
}

function goal:start()
  goal.disRate = 0
end

function goal:update(dt)
  local totalTime = g_clearTime - g_goalSpawnTime
  goal.disRate = (game.playTime - g_goalSpawnTime) / totalTime
  if goal.disRate >= 1 then
    page:changePage(stat[4])
  end
end

function goal:draw()
  local disRate = goal.disRate
  local maxScale = 0.9
  local scale = disRate * maxScale
  if disRate >= 0 then
    local posX = g_screen.width / 2 - goal.sprite:getWidth() * scale / 2
    local posY = g_trackStartHeight + (player.posY + player.height - g_trackStartHeight) * disRate - goal.sprite:getHeight() * scale
    lg.draw(goal.sprite, posX, posY, 0, scale, scale)
  end
end

return goal
