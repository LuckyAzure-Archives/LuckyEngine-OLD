extends Node2D

var AudioSync = 0
var beat2 = 0
var beatscroller = 1
var SelectionName = ""
var Select = 0
var Selected = 0
var transaction = 0
var cooldown = 30
var changename = false
var back = false

func _ready():
	$ChangeName.editable = 0
	$ChangeName.text = Global.PlayerInfo.name
	HUD.get_node("Trans").Fadeout = true

func _nextscene():
	if back == true:
		get_tree().change_scene("res://Menu Stuff/Menu/Menu.tscn")
		return
	match SelectionName:
		"Online":
			get_tree().change_scene("res://Menu Stuff/OnlineMenu/Online.tscn")

func _process(delta):
	match Select:
		0:
			SelectionName = "Change Name"
	if changename == true:
		if Input.is_action_just_pressed("ui_accept"):
			Global.PlayerInfo.name = $ChangeName.text
			$Select.play()
			Selected = 0
			$ChangeName.editable = 0
			changename = false
			return
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
				"Change Name":
					$ChangeName.editable = 1
					Selected = 1
					changename = true
		if Input.is_action_just_pressed("ui_cancel"):
			Selected = 1
			back = true
			HUD.get_node("Trans").Fadein = true


func _physics_process(delta):
	if changename == true:
		$ChangeName.visibility = 1
	else:
		$ChangeName.visibility = 0
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
