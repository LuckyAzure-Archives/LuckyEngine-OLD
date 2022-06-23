extends Sprite

var Player = true
var ArrowType = "Normal"
var dir = "Right"
var animation = ""
var frametime = 0
var frames = 0
var splashframetime = 0
var splashframes = 0
var ArrowActive = false
var ArrowSplash = false

func _ready():
	dir = name

func _physics_process(delta):
	var InputPressed = Input.is_action_pressed(dir)
	match animation:
		"":
			texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + dir + ".png")
			frames = 0
		"Hold":
			texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + dir + "_" + animation + str(frames) + ".png")
			if frametime > 0:
				frametime -= 1
			else:
				frametime = 1
				if frames < 1:
					frames += 1
		"Glow":
			texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + dir + "_" + animation + str(frames) + ".png")
			if frametime > 0:
				frametime -= 1
			else:
				frametime = 1
				if frames < 2:
					frames += 1
	if $Splash.visible == true:
		if splashframes == 0:
			$Splash.rotation_degrees = 0
		$Splash.texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + "" + "Right_Splash" + str(splashframes) + ".png")
		$Splash.modulate = Color(1,1,1,(10 - (splashframes * 1.75)) * 0.1)
		if splashframetime > 0:
			splashframetime -= 1
		else:
			splashframetime = 2
			if splashframes < 5:
				splashframes += 1
		if splashframes == 5:
			splashframes = 0
			$Splash.visible = false

func _process(delta):
	var InputPressed
	if get_parent().player:
		InputPressed = Input.is_action_pressed(dir)
	match animation:
		"":
			if InputPressed:
				if ArrowActive:
					frametime = 1
					animation = "Glow"
					texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + dir + "_" + animation + str(frames) + ".png")
					if ArrowSplash == true:
						splashframes = 0
						splashframetime = 2
						$Splash.visible = true
				else:
					frametime = 1
					animation = "Hold"
					texture = load("res://Assets/images/Arrows/" + ArrowType + "/" + dir + "_" + animation + str(frames) + ".png")
		"Hold":
			if not InputPressed:
				animation = ""
		"Glow":
			if not InputPressed:
				animation = ""
	ArrowActive = false
	ArrowSplash = false
