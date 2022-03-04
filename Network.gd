extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENTS = 1

var player2id = ""

var ned_id = null
var server = null
var client = null

var ip_address = ""

func _ready() -> void:
	ip_address = IP.get_local_addresses()
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("196.168."):
			ip_address = ip
	
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")

func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	print("server successfully created")

func join_server() -> void:
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(client)

func _connected_to_server() -> void:
	print("Successfully connected to the server")

func _server_disconnected() -> void:
	print("Disconnected from the server")

func Disconnect():
	if get_tree().is_network_server() == true:
		server.close_connection()
		get_tree().set_network_peer(null)
		return
	else:
		client.close_connection()
		get_tree().set_network_peer(null)
		return
#https://www.google.com/search?q=godot+easier+multiplayer&oq=godot+easier+multiplayer&aqs=chrome..69i57j69i64.5423j0j4&sourceid=chrome&ie=UTF-8#kpvalbx=_qn7oYYmcBcnisAeOp5jYBw22


func _player_connected(id) -> void:
	print("player" + str(id) + " has connected")

func _player_disconnected(id) -> void:
	print("player" + str(id) + " has disconnected")
