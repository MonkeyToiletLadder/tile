class = require "clasp"

Camera = class {
	init = function(self,x,y,target)
		self.x = x
		self.y = y
		self.target = target
	end,
	update = function(self,dt)
		self.x = self.target.x
		self.y = self.target.y
	end,
}