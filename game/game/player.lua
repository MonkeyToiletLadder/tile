class = require "clasp"
require "utils"

Player = class {
	init = function(self,x,y,speed,direction)
		self.selected = false
		self.x = x
		self.y = y
		self.width = 20*16
		self.height = 20*16
		self.speed = 0
		self.direction = direction
	end,
	update = function(self,dt)
		if love.mouse.isDown(1) then
			mx, my = love.mouse:getPosition()
			wx = camera.x + mx - windowWidthHalf
			wy = camera.y + my - windowHeightHalf
			if isPointInRect(wx,wy,0,0,self.width,self.height) then
				self.selected = true
			else
				self.selected = false
			end
		end
		if self.selected then
			if love.keyboard.isDown("up") and love.keyboard.isDown("left") then
				self.direction = 5 * math.pi / 4
			elseif love.keyboard.isDown("up") and love.keyboard.isDown("right") then
				self.direction = 7 * math.pi / 4
			elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
				self.direction = 3 * math.pi / 4
			elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
				self.direction = math.pi / 4
			elseif love.keyboard.isDown("up") then
				self.direction = 3 * math.pi / 2
			elseif love.keyboard.isDown("left") then
				self.direction = math.pi
			elseif love.keyboard.isDown("down") then
				self.direction = math.pi / 2
			elseif love.keyboard.isDown("right") then
				self.direction = 0
			end
			if 
				love.keyboard.isDown("up") or 
				love.keyboard.isDown("left") or 
				love.keyboard.isDown("down") or 
				love.keyboard.isDown("right") then
				self.speed = 50
			else
				self.speed = 0
			end
		end
		self.x = self.x + self.speed * math.cos(self.direction) * dt
		self.y = self.y + self.speed * math.sin(self.direction) * dt
	end,
	draw = function(self,camera)
		love.graphics.setColor(1,1,1,1)
		love.graphics.rectangle("line", math.floor(self.x - camera.x - 50), math.floor(self.y - camera.y - 50),self.width,self.height)
	end
}