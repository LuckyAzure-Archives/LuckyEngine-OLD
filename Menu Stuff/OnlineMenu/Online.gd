extends Node2D

var beat2 = 0
var beatscroller = 1
var SelectionName = ""
var Select = 0
var Selected = 0
var transaction = 0
var cooldown = 30
var joinip = false
var back = false

func _ready():
	HUD.get_node("Trans").Fadeout = true
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func _nextscene():
	if back == true:
		get_tree().change_scene("res://Menu Stuff/Menu/Menu.tscn")
		return
	match SelectionName:
		"Join":
			get_tree().change_scene("res://Menu Stuff/Lobby/Lobby.tscn")
		"Host":
			Network.create_server()
			get_tree().change_scene("res://Menu Stuff/Lobby/Lobby.tscn")

func _process(delta):
	if joinip == true:
		if Input.is_action_just_pressed("ui_accept"):
			$IP.editable = 0
			Network.ip_address = $IP.text
			Network.join_server()
			$Select.play()
	if Selected == 0:
		if Input.is_action_just_pressed("ui_down") and Select < 1:
			$Move.play()
			Select += 1
		if Input.is_action_just_pressed("ui_up") and Select > 0:
			$Move.play()
			Select -= 1
		if Input.is_action_just_pressed("ui_accept"):
			$Select.play()
			match SelectionName:
				"Host":
					transaction = 1
					Selected = 1
				"Join":
					$IP.editable = 1
					joinip = true
					Selected = 1
		if Input.is_action_just_pressed("ui_cancel"):
			Selected = 1
			back = true
			HUD.get_node("Trans").Fadein = true
	match Select:
		0:
			SelectionName = "Host"
		1:
			SelectionName = "Join"
	if joinip == true:
		$IP.visibility = 1
		$Join.posx = 170
	else:
		$IP.visibility = 0
		$Join.posx = 446

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

func _connected_to_server():
	HUD.get_node("Trans").Fadein = true
