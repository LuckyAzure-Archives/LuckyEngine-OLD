extends Sprite

var Fade = 0
var FadeScroller = 0

func _ready():
	modulate = Color(1,1,1,0)
	visible = true
	FadeScroller = 0

func _physics_process(delta):
	FadeScroller += (Fade - FadeScroller) * 0.1
	modulate = Color(1,1,1,FadeScroller)
