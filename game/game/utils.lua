function isPointInRect(px,py,rx,ry,rw,rh)
	return px > rx and px < rx + rw and py > ry and py < ry + rh
end
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end