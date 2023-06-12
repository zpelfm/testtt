local game = { playTime = 0 }

function game:new()

end

function game:isSpawnable()
    if game.playTime < g_goalSpawnTime then
        return 1
    end
    return 0
end

function game:start()
  game.playTime = 0
  playBgm("minigame_play", true)
  player:start()
  monster:start()
  timerGauge:start()
  goal:start()
end

function game:update(dt)
  game.playTime = game.playTime + dt
  if player.isAlive == 1 then
    monster:update(dt)
    timerGauge:update(dt)
    goal:update()
  end
  player:update(dt)
end


function game:draw()
  goal:draw()
  monster:drawFront(player.posY + player.height)
  player:draw()
  monster:drawBack(player.posY + player.height)
  game:uiDraw()
end

function game:uiDraw()
  timerGauge:draw()
end

return game
