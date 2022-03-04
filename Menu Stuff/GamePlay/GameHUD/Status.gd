extends Position2D

var scalescroller = 1

func _ready():
	pass

func _process(delta):
	scalescroller += (1 - scalescroller) * (0.2 * (delta / 0.016667))
	scale = Vector2(scalescroller,scalescroller)
	if Input.is_action_just_pressed("ui_accept"):
		scalescroller = 1.5
