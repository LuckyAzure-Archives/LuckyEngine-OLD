extends Position2D

var player = false

var timer = 0

func _process(delta):
	timer += 5 * delta
	position.x = -315 + (sin(timer) * 50)
	rotation_degrees = (sin(timer) * 10)
	position.y = 267 + (sin(timer * 2) * 50)
