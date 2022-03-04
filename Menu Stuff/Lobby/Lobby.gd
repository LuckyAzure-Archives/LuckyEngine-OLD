extends Node2D

var beat = 0
var beat2 = 0
var beatscroller = 1
var AudioSync = 0
var playerjoined = false
var Selected = 0
var back = false

func _ready():
	HUD.get_node("Trans").Fadeout = true
	if get_tree().is_network_server() == true:
		$Player1Text.text = Global.PlayerInfo.name
	else:
		$Player2.visible = 1
		$Player2Text.text = Global.PlayerInfo.name
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func _nextscene():
	if back == true:
		Network.Disconnect()
		get_tree().change_scene("res://Menu Stuff/Menu/Menu.tscn")
		return

func _process(delta):
	if Selected == 0:
		if Input.is_action_just_pressed("ui_cancel"):
			Selected = 1
			back = true
			HUD.get_node("Trans").Fadein = true
	if get_tree().is_network_server():
		if playerjoined == true:
			$Player2.visible = 1
			$Player2Text.text = str(Global.OpponentInfo.name)
			$Text.text = str("Game is ready!")
		else:
			$Player2.visible = 0
			$Player2Text.text = str("???")
			$Text.text = str("Waiting for opponent...")
	else:
			$Player1.visible = 1
			$Player1Text.text = str(Global.OpponentInfo.name)
			$Text.text = str("Game is ready!")

func _physics_process(delta):
	beatscroller += (1 - beatscroller) * 0.25
	$BackGround.scale = Vector2(beatscroller,beatscroller)
	if not HUD.get_node("Music").beat == beat2:
		beatscroller = 1.1
		beat2 = HUD.get_node("Music").beat

func _player_connected(id):
	playerjoined = true

func _player_disconnected(id):
	playerjoined = false

func _server_disconnected(id):
	get_tree().change_scene("res://Menu Stuff/OnlineMenu/Online.tscn")
