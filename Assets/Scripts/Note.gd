extends Sprite

var Time = 0

func _ready():
	Time = (HUD.get_node("Music").AudioSync * 1000) + 1000

func _process(delta):
	position.y = ((HUD.get_node("Music").AudioSync * 1000) - Time)
	visible = true
