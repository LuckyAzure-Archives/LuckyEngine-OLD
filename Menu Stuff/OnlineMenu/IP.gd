extends LineEdit


var scroller = 0
var visibility = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	scroller += (visibility - scroller) * 0.1
	modulate = Color(1,1,1,scroller)
	rect_position.x = get_tree().get_current_scene().get_node("Join").rect_position.x + 320
