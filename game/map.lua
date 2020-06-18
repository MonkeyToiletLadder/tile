class = require "clasp"

Map = class {
	init = function(self,atlas,tw,th,mw,mh)
		self.atlas = atlas
		self.data = {}
		self.width = mw
		self.height = mh
		self.size = self.width * self.height
		self.tw = tw
		self.th = th
		local sw,sh = self.atlas:getDimensions()
		self.sw = sw / self.tw
		self.sh = sh / self.th
		for i=0,self.height-1 do
			self.data[i] = {}
			for j=0,self.width-1 do
				self.data[i][j] = -1
			end
		end
		self.quad = love.graphics.newQuad(0,0,self.tw,self.th,self.sw,self.sh)
	end,
	draw = function(self,camera)
		for i=0,#self.data do
			for j=0,#self.data[i] do
				local id = self.data[i][j]
				if id ~= -1 then
					local x = id % self.sw * self.tw
					local y = math.floor(id/self.sw) * self.th
					self.quad:setViewport(x,y,self.tw,self.th,self.atlas:getDimensions())
					love.graphics.draw(atlas,self.quad,math.floor(j*self.tw - camera.x),math.floor(i*self.th - camera.y))
				end
			end	
		end	
	end,
	add = function(self,x,y,id)
		self.data[y][x] = id
	end,
	remove = function(self,x,y)
		self.data[y][x] = -1
	end
}