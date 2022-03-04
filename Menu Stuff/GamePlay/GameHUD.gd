extends CanvasLayer

var scalescroller = 1
var time = -200

func _process(delta):
	time = HUD.get_node("Music").AudioSync * 1000
	scalescroller += (1 - scalescroller) * (0.1 * (delta / 0.016667))
	scale = Vector2(scalescroller,scalescroller)
	if Input.is_action_just_pressed("ui_accept"):
		$Player1/Right.add_child(noteload.instance())

var noteload = load("res://Assets/Scripts/Note.tscn")
