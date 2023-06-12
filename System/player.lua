local player = {
	sprite = lgN('ImagePacks/sprites/player.png'),
	width = 82,
	height = 118,
	grid = nil,
	image = nil,
						--트랙1 트랙2 트랙3
	isAlive = 1,
	pointX = {130, 300, 470},
	posX = 0,
	posY = 250,
	collideEnable = 1,
	alpha = 1,
					--기본 --최대
	track = 2
}
local function playerPoint(x) --x값을 이미지 중앙 값으로 설정할 수 있도록 조정
	local point_x = x - (player.width/2)
	return point_x
end

function player:start()
	player.isAlive = 1
	player.collideEnable = 1
	player.alpha = 1
	player.sprite = lgN('ImagePacks/sprites/player.png')
	player.width = 82
	player.height = 118
	player.grid = anim8.newGrid(player.width, player.height, player.sprite:getWidth(), player.sprite:getHeight(), 0,0, 1)
	player.image = anim8.newAnimation(player.grid('1-6', 1), 0.1)
						--트랙1 트랙2 트랙3
	player.pointX = {130, 300, 470}
					--기본 --최대
	player.track = 2
end

function player:update(dt)

	if player.isAlive == 1 then
		player.image:update(dt)
		player.posX = playerPoint(player.pointX[player.track])
		player.checkcoliison()
	else
		local dieSpeed = 0.6
		player.alpha = player.alpha - dt * dieSpeed
		if player.alpha < 0 then
			player.alpha = 0
			page:changePage(stat[5])
		end
	end
end

function player:draw()
	if player.isAlive == 0 then
		love.graphics.setColor(1,1,1,player.alpha)
	else
		love.graphics.setColor(1,1,1)
	end
	player.image:draw(player.sprite, player.posX, player.posY)
	if g_debugLine == 1 and player.collideEnable == 1 then
		love.graphics.rectangle("line", player.posX, player.posY, player.width, player.height)
	end
	--animation:draw("player", x, y)
end

function player:move(key)
	local now = player.track

	if key == "left" then
		now = now -1
	elseif key == "right" then
		now = now +1
	end

	if now >= 1 and now <= 3 then
		player.track = now
	end
end

function player:die()
	playSound("skill/voice_1", true)
	playBgm("minigame_play", false)
	player.isAlive = 0
end

function player:checkcoliison()
	if player.collideEnable == 1 then
		for i, v in pairs(monsters) do
			local rectL = v.posX
			local rectR = v.posX + v.width * v.scale
			local rectB = v.posY + v.height * v.scale
			local disrate = v.dis / g_trackDis

			local pRectL = player.posX
			local pRectR = pRectL + player.width
			local pRectB = player.posY + player.height

			local collide = 1
			if rectB <= pRectB and pRectB - rectB < g_monsterThick then
				if rectL > pRectR then
					collide = 0
				elseif rectR < pRectL then
					collide = 0
				end
			else
				collide = 0
			end

			if collide == 1 then
				player.collision()
				break
			end
		end
	end
end

function player:collision()
	player.die()
	player.collideEnable = 0
end

return player
