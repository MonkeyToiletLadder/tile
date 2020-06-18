class = require "clasp"
require "scrollbar"
require "utils"

View = class {
	init = function(self,image,x,y,width,height)
		self.image = image
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.quad = love.graphics.newQuad(0,0,self.width,self.height,self.image:getDimensions())
		self.selected = false
		self.grip = {}
		self.grip.x = 0
		self.grip.y = 0
		-- self.scrollbar = Scrollbar()
	end,
	draw = function(self)
		self.quad:setViewport(self.grip.x,self.grip.y,self.width,self.height,self.image:getDimensions())
		love.graphics.draw(self.image,self.quad,self.x,self.y)
		love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
	end,
	update = function(self,dt)
		if love.mouse.isDown(1) then
			mx, my = love.mouse:getPosition()
			if isPointInRect(mx,my,self.x,self.y,self.width,self.height) then
				self.selected = true
			else
				self.selected = false
			end
		end
		if self.selected then
			if love.keyboard.isDown("up") then
				self.grip.y = self.grip.y - 64 * dt
			elseif love.keyboard.isDown("left") then
				self.grip.x = self.grip.x - 64 * dt
			elseif love.keyboard.isDown("down") then
				self.grip.y = self.grip.y + 64 * dt
			elseif love.keyboard.isDown("right") then
				self.grip.x = self.grip.x + 64 * dt
			end
			if self.grip.x < 0 then self.grip.x = 0 end
			if self.grip.x + self.width > self.image:getWidth() then
				if self.image:getWidth() - self.width < 0 then 
					self.grip.x = 0 
				else 
					self.grip.x = self.image:getWidth() - self.width 
				end	
			end
			if self.grip.y < 0 then self.grip.y = 0 end
			if self.grip.y + self.height > self.image:getHeight() then 
				if self.image:getHeight() - self.height < 0 then 
					self.grip.y = 0 
				else 
					self.grip.y = self.image:getHeight() - self.height 
				end	
			end
		end
	end
} 