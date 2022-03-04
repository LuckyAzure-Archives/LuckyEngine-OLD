extends Node2D

var AudioSync = 0
var beat2 = 0
var beatscroller = 1
var SelectionName = ""
var Select = 0
var Selected = 0
var transaction = 0
var cooldown = 30

func _ready():
	HUD.get_node("Trans").Fadeout = true

func _nextscene():
	match SelectionName:
		"Online":
			get_tree().change_scene("res://Menu Stuff/OnlineMenu/Online.tscn")
		"Options":
			get_tree().change_scene("res://Menu Stuff/Options/Options.tscn")

func _process(delta):
	if Selected == 0:
		if Input.is_action_just_pressed("ui_down") and Select < 2:
			$Move.play()
			Select += 1
		if Input.is_action_just_pressed("ui_up") and Select > 0:
			$Move.play()
			Select -= 1
		if Input.is_action_just_pressed("ui_accept"):
			$Select.play()
			match SelectionName:
				"Online":
					transaction = 1
					Selected = 1
				"Options":
					transaction = 1
					Selected = 1
	match Select:
		0:
			SelectionName = "Online"
		1:
			SelectionName = "FreePlay"
		2:
			SelectionName = "Options"

func _physics_process(delta):
	beatscroller += (1 - beatscroller) * 0.25
	$BackGround.scale = Vector2(beatscroller,beatscroller)
	if not HUD.get_node("Music").beat == beat2:
		beatscroller = 1.1
		beat2 = HUD.get_node("Music").beat
	if transaction == 1:
		if cooldown > 0:
			cooldown -= 1
		if cooldown == 0:
			transaction = 0
			HUD.get_node("Trans").Fadein = true
