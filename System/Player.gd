extends Sprite

var char_name = "boyfriend"

var has_cordinates = 0
var idlemin = 0
var idlecount = 0
var leftmin = 0
var leftcount = 0
var downmin = 0
var downcount = 0
var upmin = 0
var upcount = 0
var rightmin = 0
var rightcount = 0
var animationcount = 0
var minanim = 0
var maxanim = 0
var char_data
var animpart = 0
var timer = 1
var hold = 0
var start = 0
var px = 0
var py = 0

func _ready():
	px = int(position.x)
	py = int(position.y)
	#print(str(px) + ";" + str(py))
	var data_file = File.new()
	data_file.open("res://Characters/" + char_name + "/" + char_name + ".json", File.READ)
	texture = load("res://Characters/" + char_name + "/" + char_name + ".png")
	var data_json = JSON.parse(data_file.get_as_text())
	data_file.close()
	char_data = data_json.result
	var idle = str(char_data.TextureAtlas.Idle)
	var up = str(char_data.TextureAtlas.Up)
	var down = str(char_data.TextureAtlas.Down)
	var left = str(char_data.TextureAtlas.Left)
	var right = str(char_data.TextureAtlas.Right)
	#print(char_data.TextureAtlas.SubTexture[0]._height)
	var checkcount = 0
	var idleminchecker = 0
	var upminchecker = 0
	var downminchecker = 0
	var leftminchecker = 0
	var rightminchecker = 0
	idlecount = str(char_data.TextureAtlas.SubTexture).count(idle) - 1
	leftcount = str(char_data.TextureAtlas.SubTexture).count(left) - 1
	rightcount = str(char_data.TextureAtlas.SubTexture).count(right) - 1
	upcount = str(char_data.TextureAtlas.SubTexture).count(up) - 1
	downcount = str(char_data.TextureAtlas.SubTexture).count(down) - 1
	if char_data.TextureAtlas.position == true:
		has_cordinates = 1
	for i in char_data.TextureAtlas.SubTexture.size():
		if idleminchecker == 0 and str(char_data.TextureAtlas.SubTexture[checkcount]._name).count(idle) == 1:
			idleminchecker = 1
			idlemin = checkcount
		if leftminchecker == 0 and str(char_data.TextureAtlas.SubTexture[checkcount]._name).count(left) == 1:
			leftminchecker = 1
			leftmin = checkcount
		if downminchecker == 0 and str(char_data.TextureAtlas.SubTexture[checkcount]._name).count(down) == 1:
			downminchecker = 1
			downmin = checkcount
		if upminchecker == 0 and str(char_data.TextureAtlas.SubTexture[checkcount]._name).count(up) == 1:
			upminchecker = 1
			upmin = checkcount
		if rightminchecker == 0 and str(char_data.TextureAtlas.SubTexture[checkcount]._name).count(right) == 1:
			rightminchecker = 1
			rightmin = checkcount
		checkcount += 1
	#if rightminchecker == 1 and leftminchecker == 1 and downminchecker == 1 and upminchecker == 1 and idleminchecker == 1:
		#print("enemy char loaded")

var offsetx = 0
var offsety = 0

func _physics_process(delta):
	match animpart:
		0:
			maxanim = idlecount
			minanim = idlemin
			offsetx = int(char_data.TextureAtlas.IdleOffsets.x)
			offsety = int(char_data.TextureAtlas.IdleOffsets.y)
		1:
			maxanim = leftcount
			minanim = leftmin
			offsetx = int(char_data.TextureAtlas.LeftOffsets.x)
			offsety = int(char_data.TextureAtlas.LeftOffsets.y)
		2:
			maxanim = downcount
			minanim = downmin
			offsetx = int(char_data.TextureAtlas.DownOffsets.x)
			offsety = int(char_data.TextureAtlas.DownOffsets.y)
		3:
			maxanim = upcount
			minanim = upmin
			offsetx = int(char_data.TextureAtlas.UpOffsets.x)
			offsety = int(char_data.TextureAtlas.UpOffsets.y)
		4:
			maxanim = rightcount
			minanim = rightmin
			offsetx = int(char_data.TextureAtlas.RightOffsets.x)
			offsety = int(char_data.TextureAtlas.RightOffsets.y)
	timer -= 1
	if hold == 1 and animationcount > 0:
		hold = 0
		animationcount = 0
	if start == 1:
		start = 0
		animationcount = 0
	if timer <= 0:
		if animationcount == 10 and animpart > 0:
			animationcount = -1
			animpart = 0
		if animationcount == maxanim and animpart == 0:
			animationcount = -1
			animpart = 0
		timer = 2
		animationcount += 1
		region_rect.position.x = int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._x)
		region_rect.position.y = int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._y)
		region_rect.size.x = int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._width)
		region_rect.size.y = int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._height)
		if has_cordinates == 0:
			offset.y = 0 + offsety
			offset.x = 0 + offsetx
			position.x = px + int(char_data.TextureAtlas.virtual_posx)
			position.y = py + int(char_data.TextureAtlas.virtual_posy)
		if has_cordinates == 1:
			position.x = px + int(char_data.TextureAtlas.virtual_posx)
			position.y = py + int(char_data.TextureAtlas.virtual_posy)
			scale.x = (int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._frameHeight) / int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._height)) * float(char_data.TextureAtlas.size)
			scale.y = (int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._frameWidth) / int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._width)) * float(char_data.TextureAtlas.size)
			offset.x = (int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._frameX) * -1) + offsetx
			offset.y = (int(char_data.TextureAtlas.SubTexture[minanim+animationcount]._frameY) * -1) + offsety

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		start = 1
		animpart = 1
	if Input.is_action_just_pressed("ui_down"):
		start = 1
		animpart = 2
	if Input.is_action_just_pressed("ui_up"):
		start = 1
		animpart = 3
	if Input.is_action_just_pressed("ui_right"):
		start = 1
		animpart = 4
