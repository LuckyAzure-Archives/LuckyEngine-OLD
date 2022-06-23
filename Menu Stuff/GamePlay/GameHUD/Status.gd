extends Position2D

var combobreaks = 0
var accuracy = 0
var maxaccuracy = 0

var scalescroller = 1

func _ready():
	combobreaks = 0

func _process(delta):
	var accur = 0
	scalescroller += (1 - scalescroller) * (0.2 * (delta / 0.016667))
	scale = Vector2(scalescroller,scalescroller)
	if accuracy != 0:
		accur = accuracy / maxaccuracy
	$Label.text = "Score:0 | Combo Breaks:" + str(combobreaks) + " | Accuracy:" + str(stepify(accur * 100.0,0.01)) + " % | N/A"

func miss():
	combobreaks += 1
