extends Node2D


var AnimationCounter = 0
var CameraZoomScroller = 0.01
var CameraZoom = 0.01
var rng = 0
var beat2 = 0
var StartPressed = false

func _ready():
	get_tree().connect("connection_failed", self, "_connection_failed")

func _nextscene():
	HUD.get_node("Music").stream = load("res://Music/Promenade (Instrumental).ogg")
	HUD.get_node("Music").play()
	get_tree().change_scene("res://Menu Stuff/Menu/Menu.tscn")

func _physics_process(delta):
	if StartPressed == false and AnimationCounter > 640 and Input.is_action_just_pressed("ui_accept"):
		StartPressed = true
		AnimationCounter = 1000
		HUD.get_node("Fade").FadeScroller = 1
		HUD.get_node("Music").stop()
		$Select.play()
	if StartPressed == true:
		match AnimationCounter:
			1050:
				HUD.get_node("Trans").Fadein = true
	if AnimationCounter > 60 and AnimationCounter < 640 and Input.is_action_just_pressed("ui_accept"):
		AnimationCounter = 640
	match AnimationCounter:
		60:
			CameraZoom = 1
			HUD.get_node("Music").play()
			$Label.margin_top = 125
			$Label.bbcode_text = "[center]NINJAMUFFIN\nPHANTOMARCADE\nKAWAISPRITE\nEVILSKER"
			$Label.bbcode_text = "[shake rate=30 level=5]" + $Label.bbcode_text
		160:
			$Label.bbcode_text += "\nPRESENTS"
		180:
			$Label.bbcode_text = ""
			rng = round(rand_range(1,1))
		220:
			if rng == 1:
				$Label.margin_top = 200
				$Label.bbcode_text = "[center]BAD PC?"
				$Label.bbcode_text = "[shake rate=30 level=5]" + $Label.bbcode_text
		320:
			if rng == 1:
				$Label.bbcode_text += "\nCRY ABOUT IT LOL"
		340:
			$Label.bbcode_text = ""
			rng = round(rand_range(1,1))
		360:
			if rng == 1:
				$Label.margin_top = 200
				$Label.bbcode_text = "[center]NO ANDROID PORT"
			$Label.bbcode_text = "[shake rate=30 level=5]" + $Label.bbcode_text
		460:
			if rng == 1:
				$Label.bbcode_text += "\nGO HOME"
		480:
			$Label.bbcode_text = ""
		500:
			$Label.margin_top = 125
			$Label.bbcode_text = "[center]FRIDAY"
			$Label.bbcode_text = "[shake rate=30 level=5]" + $Label.bbcode_text
		530:
			$Label.bbcode_text += "\nNIGHT"
		560:
			$Label.bbcode_text += "\nFUNKIN"
		590:
			$Label.bbcode_text += "\nMULTIPLAYER"
		640:
			CameraZoom = 1
			$Logo.visible = true
			$gf.visible = true
			HUD.get_node("Fade").FadeScroller = 1
			$Label.bbcode_text = ""
			CameraZoomScroller = -1
	CameraZoomScroller += (CameraZoom - CameraZoomScroller) * 0.1
	$Camera.zoom = Vector2(CameraZoomScroller,CameraZoomScroller)
	AnimationCounter += 1
	if not HUD.get_node("Music").beat == beat2:
		$Logo.SizeScroller = 1.2
		beat2 = HUD.get_node("Music").beat
