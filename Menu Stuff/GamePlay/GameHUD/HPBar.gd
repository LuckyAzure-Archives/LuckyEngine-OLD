extends ProgressBar

func _ready():
	get("custom_styles/bg").set_bg_color(Color(0.65, 0, 0.3, 1))
	get("custom_styles/fg").set_bg_color(Color(0.19, 0.69, 0.82, 1))
