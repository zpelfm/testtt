local sList = {name, bgm, ui, state}
local upsList = {}
local bg = nil

local function laN_check(laN, state)
  if state then return laN:play() else return laN:stop() end
end

local function bgm(state)
  if bg ~= nil then
    if bg:isPlaying() then bg:stop() end
  end

  local name = sList.name
  bg = laN('Music/bgm_'..name..'.ogg', "stream")
  bg:setVolume(.7)
  bg:setLooping(true)
  laN_check(bg, state)
end

local function playRandomSound(name, num)
  local rs = laN('SoundPacks/'..name..'/'..num..'.ogg', "static")
  rs:play()
  upsList.timer = 0
end


function clickSound(i, state)
  local clickSnd = laN('SoundPacks/click'..i..'.ogg', "stream")
  laN_check(clickSnd, state)
end


function playBgm(fileName, state)
  sList.name = fileName
  bgm(state)
end

function playSound(fileName, state)
  local clickSnd = laN('SoundPacks/'..fileName..'.ogg', "stream")
  laN_check(clickSnd, state)
end

function upSound(dt)
  if upsList == {} or upsList.timer == nil then
  else
    upsList.timer = upsList.timer + dt
    if upsList.timer >= 15 and upsList.mode == 1 then
      playRandomSound(upsList.name, math.random(3))
    end
  end
end
