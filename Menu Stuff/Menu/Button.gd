extends RichTextLabel

var timer = 0

func _physics_process(delta):
	if get_tree().get_current_scene().SelectionName == get_name():
		modulate = Color(1,1,1,1)
		if get_tree().get_current_scene().Selected == 1:
			modulate = Color(1,1,1,0.5)
	else:
		modulate = Color(1,1,1,0.5)
