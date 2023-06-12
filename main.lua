require 'System'

tick = require 'tick'
anim8 = require 'System/anim8'
page = require 'System/page'
sound = require 'Game/sound'
game = require 'game'
monster = require 'System/monster'
goal = require 'System/goal'
timerGauge = require 'System/timerGauge'
stat = {'title', 'help', 'play', 'win', 'lose'}
currentPage = stat[1]
winUI = require 'System/winUI'

player = require 'System/player'

--윈도우창 그리기
local window = lgN('ImagePacks/ui/window.png')

--local page = require 'Game.page'
--local sky = lgN('ImagePacks/map/minigame_play/map.png')

function love.load(arg)
  math.randomseed(os.time())
  page:load()
  tick.framerate = -1
  tick.rate = .03

end
--wntjr
function love.update(dt)
  tick.dt = dt
  page:update(dt, currentPage)
  --button.update(dt)
  map:update(dt)
end

function love.draw()
  map:draw()
  page:draw(currentPage)

  --debug
  --love.graphics.print(status, 15,12)
--  button:draw()
--프레임
  love.graphics.draw(window)
end



function love.mousereleased(x, y, btn)
  if btn == 1 then
    button:click()
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end

  if currentPage == stat[3] then
    if key == "left" or key == "right" then
      player:move(key)
    end

    if key == "space" then
      monster:new()
    end
  end
end
