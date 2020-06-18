class = require "clasp"

Scrollbar = class {
	init = function(x,y,size,orientation)
		self.x = x
		self.y = y
		self.size = size
		self.orientation = orientation
		self.grip = {}
		self.grip.x = 0
		self.grip.y = 0
		self.grip.width = 0
		self.grip.height = 0
	end,
	update = function(self,dt)

	end,
	draw = function(self)

	end,
	draw = function(self,camera)
	
	end
}