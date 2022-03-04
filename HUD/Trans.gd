extends Sprite

var Fadeout = false
var Fadein = false
var AnimType = ""
var AnimCount = 0

func _ready():
	position.y = 960
	if Fadeout == true:
		position.y = 960
	if Fadein == true:
		position.y = 0


func _physics_process(delta):
	if AnimType == "":
		position.y = 0
	if Fadein == true:
		Fadein = false
		AnimType = "Fadein"
		AnimCount = 48
		position.y = 0
	if AnimType == "Fadein":
		AnimCount -= 1
		position.y += 20
		if AnimCount == 0:
			get_tree().get_current_scene()._nextscene()
			AnimType = ""
	if Fadeout == true:
		Fadeout = false
		AnimType = "Fadeout"
		AnimCount = 48
		position.y = 960
	if AnimType == "Fadeout":
		AnimCount -= 1
		position.y += 20
		if AnimCount == 0:
			AnimType = ""
