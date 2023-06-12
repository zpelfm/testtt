local monsterW = { 140, 204 }
local monsterH = { 100, 168 }

local monster = {
  sprite = lgN('ImagePacks/sprites/minigame_play/enemy/N.png'),
  type = 1,
  width = monsterW[1],
  height = monsterH[1],
  grid = nil,
  image = nil,
  posX = 0,
  posY = g_trackStartHeight,
  dis = 0, --총 거리는 g_trackDis 변수 여기 끝까지 도달하면 된다.
  scale = 0,
  speed = 1, -- 1초동안 1 dis 이동 5이면 g_trackDis가 30일 때 6초안에 이동으로.. 하려했으나 가까이 왔을때 너무 느려보여서 대충 가중치
  trackList = {-g_oneTrackWidth, 0, g_oneTrackWidth},
  startTrackList = {-g_oneStartTrackWidth, 0, g_oneStartTrackWidth},
  moveType = 1, -- 1 -> 고블린 2 -> 키놀
  moveDir = 1, -- -1 - 왼쪽 1 - 오른쪽
  moveDirRate = 0,
  moveDirSpeed = 0.5,
  track = 1
}
function copy(original)
	local c = {}
	for key, value in pairs(original) do
		c[key] = value
	end
	return c
end

local spawntime = 1
local spawntick = 0

monsters = {}

function monster:trackPosX(disRate, width, scale, track)
  local startAdjust = 1 - disRate
  if startAdjust <= 0 then
    startAdjust = 0
  end
  startAdjust = startAdjust * monster.startTrackList[track]

  return g_screen.width / 2 + disRate * monster.trackList[track] + startAdjust - width * scale / 2
end

function monster:start()
  if #monsters >= 1 then
    monsters = {}
  end
end

function monster:new()
  local type = math.random(g_monsterTypeCount) -- 몬스터 종류 설정

  local mon = copy(monster)
  mon.type = type

  mon.track = math.random(3)
  mon.width = monsterW[type]
  mon.height = monsterH[type]
  if type == 1 then
    mon.sprite = lgN('ImagePacks/sprites/minigame_play/enemy/N.png')
    mon.speed = 1
  elseif type == 2 then
    mon.moveType = 2
    mon.moveDirSpeed = 1 -- 1초에 한번씩 방향 바꾸게
    mon.speed = 1.2
    if mon.track == 1 then --왼쪽이면
      mon.moveDir = 1 --오른쪽이동
      mon.moveDirRate = 0
    elseif mon.track == 2 then
      local moveDir = math.random(2)
      if moveDir == 1 then
        mon.moveDir = 1
      else
        mon.moveDir = -1
      end
      mon.moveDirRate = 0.5
    else
      mon.moveDir = -1
      mon.moveDirRate = 1
    end
    mon.sprite = lgN('ImagePacks/sprites/minigame_play/enemy/S.png')
  end
  mon.grid = anim8.newGrid(mon.width, mon.height, mon.sprite:getWidth(), mon.sprite:getHeight(), 0,0, 1)

  if type == 1 then
    mon.image = anim8.newAnimation(mon.grid('1-4', 1), 0.1)
  elseif type == 2 then
    mon.image = anim8.newAnimation(mon.grid('1-4', 1), 0.1)
    if mon.moveDir == -1 then
      mon.image.flippedH = true
    end
  end

  --초기 위치 설정
  mon.posX = monster:trackPosX(0, mon.width, 0, mon.track)
  mon.posY = g_trackStartHeight

  table.insert(monsters, mon)
end

function monster:update(dt)

  for i, v in pairs(monsters) do
    v.image:update(dt)
    
    local accel = 10 * dt
    v.speed = v.speed + accel
    local disRate =  v.dis / g_trackDis
    v.dis = v.dis + v.speed * dt
    local lastScale = v.scale
    v.scale = disRate * g_monsterBaseScale

    local minX = monster:trackPosX(disRate, v.width, v.scale, 1) - v.scale * v.width / 2
    local maxX = monster:trackPosX(disRate, v.width, v.scale, 3) + v.scale * v.width / 2
    if v.moveType == 1 then
      v.posX = monster:trackPosX(disRate, v.width, v.scale, v.track)
    elseif v.moveType == 2 then
      local moveDirAccel = 20 * disRate * dt
      local deltaX = maxX - minX
      v.moveDirRate = v.moveDirRate + v.moveDirSpeed * v.moveDir * dt
      v.posX = minX + deltaX * v.moveDirRate
    end

    if v.posX < minX then
      v.moveDir = 1
      v.image.flippedH = false
    elseif v.posX > maxX then
      v.moveDir = -1
      v.image.flippedH = true
    end
    
    v.posY = g_trackStartHeight + disRate * g_trackHeight
  end

  if #monsters >= 1 then
    local last = monsters[1]
    local disRate = last.dis / g_trackDis
    if disRate >= g_goalDisRate then
      table.remove(monsters, 1) -- 첫번째 요소 삭제
    end
  end

  spawntick = spawntick + tick.dt
  if spawntick >= spawntime and game.isSpawnable() == 1 then
    spawntick = 0
    monster:new()
  end
end

--플레이어 앞에 있는 경우
function monster:drawFront(pRectB)
  -- 멀리있는게 table의 뒤에 있으니 역으로 드로우 해야 앞에있는애가 나중에 그려짐
  for i = #monsters, 1, -1 do
    local v = monsters[i]
    local rectB = v.posY + v.height * v.scale

    --키놀과 고블린의 크기가 다르기 때문에 그 다음 애는 앞에 있을수 있어 전부 순회해야한다.
    if pRectB > rectB then
      v.image:draw(v.sprite, v.posX, v.posY, 0, v.scale, v.scale)
      if g_debugLine == 1 then
        if i == 1 then
          lg.print(v.moveDir, 12, 12)
        end
        love.graphics.rectangle("line", v.posX, v.posY, v.width * v.scale, v.height * v.scale)
      end
    end
  end
  --lg.print(#monsters, 12, 12)
end

function monster:drawBack(pRectB)
  -- 멀리있는게 table의 뒤에 있으니 역으로 드로우 해야 앞에있는애가 나중에 그려짐
  for i = #monsters, 1, -1 do
    local v = monsters[i]
    local rectB = v.posY + v.height * v.scale

    --키놀과 고블린의 크기가 다르기 때문에 그 다음 애는 뒤에 있을수 있어 전부 순회해야한다.
    if pRectB <= rectB then
      v.image:draw(v.sprite, v.posX, v.posY, 0, v.scale, v.scale)
      if g_debugLine == 1 then
        if i == 1 then
          lg.print(v.moveDir, 12, 12)
        end
        love.graphics.rectangle("line", v.posX, v.posY, v.width * v.scale, v.height * v.scale)
      end
    end
  end
  --lg.print(#monsters, 12, 12)
end
--function enemyTrack(w) return {g_screen.w / 2 - w/3 , g_screen.w / 2, g_screen.w / 2 + w/3} end
--function enemyReset() for i, e in ipairs(enemies) do enemies[i] = nil end end

return monster
