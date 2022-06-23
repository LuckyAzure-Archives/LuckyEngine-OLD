extends Position2D

#Stage Name
var stage_name = "test"

#Stage Datas
var stage_data = null
var texture_data = null

var textureobjload = load("res://Menu Stuff/GamePlay/StageTexture.tscn")

#Loads Stage Textures
func _ready():
	var data_file = File.new()
	data_file.open("res://Stages/" + stage_name + "/stage.json", File.READ)
	var data_json = JSON.parse(data_file.get_as_text())
	data_file.close()
	stage_data = data_json.result
	print(data_json.result)
	var Positions = [
		[#boyfriend
		stage_data.Stage.Player.x, stage_data.Stage.Player.y,
		stage_data.Stage.Player.cameraoffsetx, stage_data.Stage.Player.cameraoffsety
		],
		[#girlfriend
		stage_data.Stage.GF.x, stage_data.Stage.GF.y,
		stage_data.Stage.GF.cameraoffsetx, stage_data.Stage.GF.cameraoffsety,
		],
		[#enemy
		stage_data.Stage.Enemy.x, stage_data.Stage.Enemy.y,
		stage_data.Stage.Enemy.cameraoffsetx, stage_data.Stage.Enemy.cameraoffsety
		]
	]
	var CameraData = [
		stage_data.Stage.Camera.offsetx,
		stage_data.Stage.Camera.offsety,
		stage_data.Stage.Camera.zoom,
		stage_data.Stage.Camera.speed
	]
	get_tree().get_current_scene().Positioning(Positions,CameraData)
	var texturenode = load("res://Menu Stuff/GamePlay/StageTexture.tscn")
	for i in stage_data.Stage.StageTexture.size():
		texture_data = stage_data.Stage.StageTexture[i]
		add_child(textureobjload.instance())
