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
		for i=1,self.height do
			self.data[i] = {}
			for j=1,self.width do
				self.data[i][j] = -1
			end
		end
		self.quad = love.graphics.newQuad(0,0,self.tw,self.th,self.sw,self.sh)
	end,
	draw = function(self,camera)
		love.graphics.rectangle("line",0-camera.x,0-camera.y,self.width*self.tw,self.height*self.th)
		for i=1,#self.data do
			for j=1,#self.data[i] do
				local id = self.data[i][j]
				if id ~= -1 then
					local x = id % self.sw * self.tw
					local y = math.floor(id/self.sw) * self.th
					self.quad:setViewport(x,y,self.tw,self.th,self.atlas:getDimensions())
					love.graphics.draw(atlas,self.quad,math.floor((j-1)*self.tw - camera.x),math.floor((i-1)*self.th - camera.y))
				end
			end	
		end	
	end,
	add = function(self,x,y,id)
		self.data[y][x] = id
	end,
	remove = function(self,x,y)
		self.data[y][x] = -1
	end,
	save = function(self,path)
		local file = assert(io.open(path,"w"))
		io.output(file)
		io.write("return {")
		for i=1,#self.data do
			io.write("{")
			for j=1,#self.data[i] do
				local id = self.data[i][j]
					io.write(id..",")
			end
			io.write("},")
		end	
	io.write("}")
	io.close(file)
	end,
	load = function(self,path)
		if file_exists(path) then
			self.data = dofile(path)
		end	
	end 
}