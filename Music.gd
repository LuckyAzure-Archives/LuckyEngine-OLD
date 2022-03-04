extends AudioStreamPlayer

var BPM = 128
var AudioSync = 0
var beat = 0
var beat2 = 0
var beat3 = 0

func _process(delta):
	if not HUD.get_node("Music").beat < beat2 + 4:
		beat2 = HUD.get_node("Music").beat
		if get_tree().get_current_scene().has_method("_BPM"):
			get_tree().get_current_scene()._BPM()
	if not HUD.get_node("Music").beat == beat3:
		beat3 = HUD.get_node("Music").beat
		if get_tree().get_current_scene().has_method("_BPM2"):
			get_tree().get_current_scene()._BPM2()
	AudioSync = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	Global.SongName = stream.resource_path.get_file().get_basename().to_upper()
	beat = int(AudioSync * BPM / 60.0)
