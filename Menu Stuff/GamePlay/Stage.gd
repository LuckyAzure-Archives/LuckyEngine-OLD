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
	var texturenode = load("res://Menu Stuff/GamePlay/StageTexture.tscn")
	for i in stage_data.Stage.StageTexture.size():
		texture_data = stage_data.Stage.StageTexture[i]
		add_child(textureobjload.instance())
