local winUI = {	}
winUI.playerSprite = lgN('ImagePacks/sprites/win_player.png')
winUI.playerGrid = anim8.newGrid(54, 45, winUI.playerSprite:getWidth(), winUI.playerSprite:getHeight(), 1,0)
winUI.playerImage = anim8.newAnimation(winUI.playerGrid('1-16', 1), 0.1)
winUI.swordSprite = lgN('ImagePacks/sprites/win1.png')
winUI.swordGrid = anim8.newGrid(55, 41, winUI.swordSprite:getWidth(), winUI.swordSprite:getHeight(), 0,0)
winUI.swordImage = anim8.newAnimation(winUI.swordGrid('1-8', 1), 0.1)
winUI.fighterSprite = lgN('ImagePacks/sprites/win2.png')
winUI.fighterGrid = anim8.newGrid(35, 38, winUI.fighterSprite:getWidth(), winUI.fighterSprite:getHeight(), 0,0)
winUI.fighterImage = anim8.newAnimation(winUI.fighterGrid('1-8', 1), 0.1)
winUI.mageSprite = lgN('ImagePacks/sprites/win3.png')
winUI.mageGrid = anim8.newGrid(71, 40, winUI.mageSprite:getWidth(), winUI.mageSprite:getHeight(), 1,0)
winUI.mageImage = anim8.newAnimation(winUI.mageGrid('1-8', 1), 0.1)

function winUI:update(dt)
	winUI.playerImage:update(dt)
	winUI.mageImage:update(dt)
	winUI.fighterImage:update(dt)
	winUI.swordImage:update(dt)
end

function winUI:draw()
	local scale = 1.35
	winUI.playerImage:draw(winUI.playerSprite, 320, 180, 0 , scale, scale)
	winUI.mageImage:draw(winUI.mageSprite, 220, 180, 0 , scale, scale)
	winUI.fighterImage:draw(winUI.fighterSprite, 190, 170, 0 , scale, scale)
	winUI.swordImage:draw(winUI.swordSprite, 195, 210, 0 , scale, scale)
end


return winUI
