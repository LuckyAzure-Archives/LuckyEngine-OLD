extends Camera2D

var _posx = 640
var _posy = 360
var _angle = 0
var _zoom = 1
var scroller_posx = 640
var scroller_posy = 360
var scroller_angle = 0
var scroller_zoom = 1
var scrollspeed = 0.2
var scrollerspeed = 0.2
var scrollershake = 0

func _process(delta):
	scrollerspeed = scrollerspeed + (scrollspeed - scrollerspeed ) * (0.1 * (delta / 0.016667))
	scroller_posx = scroller_posx + (_posx - scroller_posx ) * (scrollerspeed * (delta / 0.016667))
	scroller_posy = scroller_posy + (_posy - scroller_posy ) * (scrollerspeed * (delta / 0.016667))
	scroller_angle = scroller_angle + (_angle - scroller_angle ) * (scrollerspeed * (delta / 0.016667))
	scroller_zoom = scroller_zoom + (_zoom - scroller_zoom ) * (scrollerspeed * (delta / 0.016667))
	scrollershake = scrollershake + (0 - scrollershake ) * (0.1 * (delta / 0.016667))
	position.x = scroller_posx + int(rand_range(0 - scrollershake, scrollershake))
	position.y = scroller_posy + int(rand_range(0 - scrollershake, scrollershake))
	rotation_degrees = scroller_angle
	zoom.x = scroller_zoom
	zoom.y = scroller_zoom
