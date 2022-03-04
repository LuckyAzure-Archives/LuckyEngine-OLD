extends Sprite

var texture_data = null

func _ready():
	add_to_group("Textures")
	texture_data = get_tree().get_current_scene().get_node("Stage").texture_data
	#filename
	texture = load("res://Stages/" + get_tree().get_current_scene().get_node("Stage").stage_name + "/" + texture_data.filename)
	#name
	set_name(texture_data.name)
	#index
	z_index = texture_data.index
	#becentered
	centered = texture_data.becentered
	#x
	position.x = texture_data.x
	x = texture_data.x
	#y
	position.y = texture_data.y
	y = texture_data.y
	#width
	scale.x = texture_data.width / texture.get_size().x
	sx = texture_data.width / texture.get_size().x
	#height
	scale.y = texture_data.height / texture.get_size().y
	sy = texture_data.height / texture.get_size().y

func _process(delta):
	if texture_data.has("animations"):
		_Animation(delta)

var Anim = 0
var x = 0
var y = 0
var sx = 0
var sy = 0

func _Animation(delta):
	x += (texture_data.animations[Anim].x - x) * (0.1 * (delta / 0.016667))
	y += (texture_data.animations[Anim].y - y) * (0.1 * (delta / 0.016667))
	sx += (texture_data.animations[Anim].width - sx) * (0.1 * (delta / 0.016667))
	sy += (texture_data.animations[Anim].height - sy) * (0.1 * (delta / 0.016667))
	position = Vector2(x,y)
	scale = Vector2(sx / texture.get_size().x,sy / texture.get_size().y)

func BPM2():
	if texture_data.has("animations"):
		if (texture_data.animations.size() - 1) > Anim:
			Anim += 1
		else:
			Anim = 0
