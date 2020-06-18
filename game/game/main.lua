require "camera"
require "player"
require "map"
require "view"

windowWidth, windowHeight, flags = love.window.getMode()

windowWidthHalf = windowWidth / 2
windowHeightHalf = windowHeight / 2

atlas = love.graphics.newImage("dungeon_sheet.png")
quad = love.graphics.newQuad(0,0,16,16,atlas:getDimensions())



map = Map(atlas,16,16,20,20)
player = Player(0,0,100,0)
camera = Camera(0,0,player)
view = View(atlas,0,0,250,200)

updatable = {}
table.insert(updatable,player)
table.insert(updatable,camera)
table.insert(updatable,view)

drawable = {}
-- table.insert(drawable,player
table.insert(drawable,map)

currentTile = 54

function love.update(dt)
	if love.keyboard.isDown("s") then
		map:save("save.txt")
	end
	if love.keyboard.isDown("l") then
		map:load("save.txt")
	end	
	if love.keyboard.isDown("k") then
		atlas = love.graphics.newImage("dungeon_sheet.png")
		view.image = atlas
	end
	-- Place tile
	if love.mouse.isDown(1) then
		mx,my = love.mouse.getPosition()
		wx = math.floor((camera.x + mx - windowWidthHalf) / map.tw) + 1
		wy = math.floor((camera.y + my - windowHeightHalf) / map.th) + 1
		if wx >= 1 and wx < map.width + 1 and wy >= 1 and wy < map.height  + 1 then
			map:add(wx,wy,currentTile)
		end
	-- Remove tile
	elseif love.mouse.isDown(2) then
		mx,my = love.mouse.getPosition()
		wx = math.floor((camera.x + mx - windowWidthHalf) / map.tw) + 1
		wy = math.floor((camera.y + my - windowHeightHalf) / map.th) + 1
		if wx >= 1 and wx < map.width + 1 and wy >= 1 and wy < map.height + 1 then
			map:remove(wx,wy,currentTile)
		end
	end

	-- Pick tile
	if view.selected then
		if love.mouse.isDown(1) then
			mx, my = love.mouse.getPosition()
			if mx > view.x and mx < view.x + view.image:getWidth() and my > view.y and my < view.y + view.image:getHeight() then
				tx = math.floor((mx + view.grip.x) / map.tw)
				ty = math.floor((my + view.grip.y) / map.th)
				id = tx + ty * map.sw
				currentTile = id
			end
		end
	end
	for _,v in ipairs(updatable) do
		v:update(dt)
	end
end

function love.draw()
	-- Canvas Draws
	love.graphics.push()
	love.graphics.translate(windowWidthHalf,windowHeightHalf)
	for _,v in ipairs(drawable) do
		v:draw(camera)
	end
	love.graphics.pop()

	view:draw()

	-- Tile selection
	local x = currentTile % map.sw * map.tw - view.grip.x
	local y = math.floor(currentTile / map.sw) * map.th - view.grip.y
	if x < view.x + view.width and y < view.y + view.height then
		love.graphics.rectangle("line",x,y,map.tw,map.th)
	end
end

function love.wheelmoved(x,y)
	currentTile = currentTile + y
	if currentTile < 0 then currentTile = 0 end
	if currentTile > map.sw * map.sh - 1 then currentTile = map.sw * map.sh - 1 end 
end