local page = {}

page.image = {
  lgN("ImagePacks/title.png"), --title
  lgN("ImagePacks/help.png"), --help
  "", --play
  lgN("ImagePacks/win_bg.png"), --clear
  lgN("ImagePacks/failed.png") --failed
}

page.btn = {
  button:new("play", 300, 350),
  button:new("help", 300, 304),
  button:new("retry", 300, 330),
  button:new("exit", 564, 34, true)
}


--button:active("play", true)
--button:active("help", true)
--button:active("exit", true)
--button:active("failed", true)


function page:load()
  page:changePage(stat[1])
end

function page:update(dt, pg)
  if pg == stat[3] then
    game:update(dt)
  elseif pg == stat[4] then
    winUI:update(dt)
  end
  button.update(dt)
end

function page:draw(pg)
  if pg == stat[1] then --title
    lg.draw(page.image[1])
    button:active("play", true)
    button:active("help", true)
    button:active("retry", false)

  elseif pg == stat[2] then --help
    lg.draw(page.image[2])
    button:active("play", true)
    button:active("help", false)
    button:active("retry", false)

  elseif pg == stat[3] then --play
    game:draw()
    button:active("play", false)
    button:active("help", false)
    button:active("retry", false)

  elseif pg == stat[4] then --clear
    lg.draw(page.image[4])
    winUI:draw()
    button:active("play", false)
    button:active("help", false)
    button:active("retry", true)

  elseif pg == stat[5] then --failed
    lg.draw(page.image[5])
    button:active("play", false)
    button:active("help", false)
    button:active("retry", true)
  end

  button:draw()
end

function page:changePage(pg)
  local oldpage = currentPage

  if pg == stat[1] then
    playBgm("minigame_main", true)
  elseif pg == stat[3] then
    game:start()
  elseif pg == stat[4] then
    playSound("effect/sound_ye", true)
  elseif pg == stat[5] then
    playBgm("minigame_play", false)
    playSound("effect/sound_lose", true)
  end

  currentPage = pg
end

return page
