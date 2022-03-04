extends Sprite

var ScrollerX = 800
var PosX = 800
var time = 0
var SongName = ""

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.x = 800 + ScrollerX
	$Text.text = SongName

func _physics_process(delta):
	if not SongName == Global.SongName:
		SongName = Global.SongName
		time = 300
	if time > 0:
		PosX = 0
		time -= 1
	else:
		PosX = 500
	ScrollerX += (PosX - ScrollerX) * 0.2
