extends Sprite

var data
var Pos

func _ready():
	data = get_tree().get_current_scene().get_node("GameHUD").arrow_data 
	texture = load("res://Assets/images/Arrows/" + "Normal" + "/" + data[5] + "_Note.png")
	Pos = data[0]

func _process(delta):
	var notedata = get_tree().get_current_scene().get_node("GameHUD").notedata
	var notehit = get_tree().get_current_scene().get_node("GameHUD").notehit
	var time = get_tree().get_current_scene().get_node("GameHUD").time
	var hittable = notedata[data[1]][0] == Pos and notehit[data[1]] == 0
	var ArrowSplash = false
	position.y = (time - Pos) * 2
	visible = true
	if data[1] > 3 and (time > Pos):
		get_tree().get_current_scene().get_node("GameHUD").Notehitenemy(data[1])
		queue_free()
	if data[1] <= 3 and time > Pos - 250 and time < Pos + 150 and hittable:
		get_parent().ArrowActive = true
		if time > Pos - 50 and time < Pos + 50:
			get_parent().ArrowSplash = true
			ArrowSplash = true
		if Input.is_action_just_pressed(data[5]):
			get_tree().get_current_scene().get_node("GameHUD").Notehit(data[1],ArrowSplash,250 - abs(time - Pos))
			queue_free()
	if data[1] <= 3 and time > Pos + 300:
		get_tree().get_current_scene().get_node("GameHUD").Notemiss(data[1])
		queue_free()
