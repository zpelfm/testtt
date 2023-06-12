
--화면 로딩 전 사전 변수 선언 및 설정
--windowW = 12
--hit = true

g_screen = {width = 600, height = 400}
g_screenRate = g_screen.width / g_screen.height
g_canvas = {width = 600, height = 400}

--아래 트랙은 모두 몬스터 기준의 시작지점
g_trackCount = 3
g_trackDis = 30 --가상의 거리 30 (실제 y값이 아님)
g_trackStartHeight = 168 -- 트랙의 실제 시작 y값
g_trackHeight = g_screen.height - g_trackStartHeight - 132 -- 실제 트랙의 y사이즈 마지막 뒤의 상수는 screen 아래에서 플레이어 위치까지의 y값 (player posy - player.height)
g_oneTrackWidth = g_screen.width / g_trackCount --끝지점에서 한 트랙의 너비
g_oneStartTrackWidth = 156 / g_trackCount --끝지점에서 한 트랙의 너비
g_goalDisRate = 1.3

g_monsterTypeCount = 2
g_monsterBaseScale = .8
g_debugLine = 1
g_monsterThick = 10
g_clearTime = 13
g_goalSpawnTime = g_clearTime - 3

--field = {maxW = 720, maxH = 320, minW = 180, minH = 80, vanish = 108}

function love.conf(t)
  t.window.width = g_screen.width
  t.window.height = g_screen.height
  t.window.borderless = true
end
