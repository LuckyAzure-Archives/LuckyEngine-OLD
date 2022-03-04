extends Node2D

func _ready():
	HUD.get_node("Music").stream = load("res://Music/Powerdown.ogg")
	HUD.get_node("Music").play()
	HUD.get_node("Music").BPM = 180

func _process(delta):
	var time = (HUD.get_node("Music").AudioSync * 1000)
	

func _BPM():
	$Cam.scroller_zoom -= 0.05
	$GameHUD.scalescroller = 1.06
	get_tree().call_group("sprites", "BPM")

func _BPM2():
	get_tree().call_group("sprites", "BPM2")
