extends Node2D

var song_name = "powerdown"
var Player1 = "boyfriend"
var Player2 = "boyfriend"

func _ready():
	Global.SongName = song_name.to_upper()
	HUD.get_node("Music").stream = load("res://Songs/" + song_name + "/Inst.ogg")
	HUD.get_node("Music").stream.loop = false
	$Voices.stream = load("res://Songs/" + song_name + "/Voices.ogg")
	$Voices.stream.loop = false

var Cameraoffset : Vector2
var Positions

func Positioning(Position,CameraData):
	Positions = Position
	$Player1.position = Vector2(640 + Positions[0][0],320 + Positions[0][1])
	$Player2.position = Vector2(640 + Positions[2][0],320 + Positions[2][1])
	$Cam._zoom = CameraData[2]
	$Cam.scrollspeed = CameraData[3]
	Cameraoffset = Vector2(CameraData[0], CameraData[1])

func ChartData(mustHitSection):
	if mustHitSection:
		$Cam._posx = $Player1.position.x + Cameraoffset.x + Positions[0][2]
		$Cam._posy = $Player1.position.y + Cameraoffset.y + Positions[0][3]
	else:
		$Cam._posx = $Player2.position.x + Cameraoffset.x + Positions[2][2]
		$Cam._posy = $Player2.position.y + Cameraoffset.y + Positions[2][3]

func _BPM():
	$Cam.scroller_zoom -= 0.05
	$GameHUD.scalescroller = 1.08
	get_tree().call_group("sprites", "BPM")

func _BPM2():
	get_tree().call_group("sprites", "BPM2")
