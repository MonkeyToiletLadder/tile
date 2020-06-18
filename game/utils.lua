function isPointInRect(px,py,rx,ry,rw,rh)
	return px > rx and px < rx + rw and py > ry and py < ry + rh
end