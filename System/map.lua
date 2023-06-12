local map = {}

--[1] = 기본값, [2] = 최댓값
map.bg = lgN('ImagePacks/map/bg.png')
map.img = {
  lgN('ImagePacks/map/t0.png'),
  lgN('ImagePacks/map/t1.png'),
  lgN('ImagePacks/map/t2.png'),
  lgN('ImagePacks/map/t3.png'),
  lgN('ImagePacks/map/t4.png'),
  lgN('ImagePacks/map/t5.png'),
  lgN('ImagePacks/map/t6.png'),
  lgN('ImagePacks/map/t7.png')
}
map.frame = {1, #map.img}
map.speed = {0, 0.03}
map.width = 720
map.center = -60 --맵 가운데 정렬하기 위한 x값

function map:update(dt)
  map.speed[1] = map.speed[1]+tick.dt
  if map.speed[1] >= map.speed[2] then
    map.speed[1] = 0
    map.frame[1] = map.frame[1] + 1
  end
  if map.frame[1] > map.frame[2] then map.frame[1] = 1 end
end


function map:draw()
  love.graphics.draw(map.bg)
	love.graphics.draw(map.img[map.frame[1]], map.center)
end

return map
