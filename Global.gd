extends Node

var SongName = ""
var StatusSongName = ""

var PlayerInfo = {name = "PLAYER"}
var OpponentInfo = null

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func _player_connected(id):
	rpc_id(id, "register_player", Global.PlayerInfo)

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	Global.OpponentInfo = info
