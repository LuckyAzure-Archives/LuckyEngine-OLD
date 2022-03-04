extends Sprite

var SizeScroller = 1
var BPM = 200
var Time = 0

func _ready():
	pass

func _physics_process(delta):
	Time += 0.05
	SizeScroller += (1 - SizeScroller) * 0.2
	scale = Vector2(SizeScroller,SizeScroller)
	rotation_degrees = sin(Time) * 4
