lg = love.graphics
lgN = lg.newImage
la = love.audio
laN = love.audio.newSource
lm = love.mouse

--require 'Game'
button = require 'System.button'
map = require 'System.map'


function checkCollision(a, b)
  local x1, y1, w1, h1 = a[1], a[2], a[3], a[4]
  local x2, y2, w2, h2 = b[1], b[2], b[3], b[4]

  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
