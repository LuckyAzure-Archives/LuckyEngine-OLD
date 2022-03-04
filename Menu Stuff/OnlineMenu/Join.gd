extends RichTextLabel

var scrollerx = 446
var posx = 446
var timer = 0

func _physics_process(delta):
	scrollerx += (posx - scrollerx) * 0.1
	if get_tree().get_current_scene().SelectionName == get_name():
		modulate = Color(1,1,1,1)
		if get_tree().get_current_scene().Selected == 1 and get_tree().get_current_scene().joinip == false:
			modulate = Color(1,1,1,0.5)
	else:
		modulate = Color(1,1,1,0.5)
	rect_position.x = scrollerx
