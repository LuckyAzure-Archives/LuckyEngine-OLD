extends CanvasLayer

var scalescroller = 1
var time = -1000

func _ready():
	song_name = get_parent().song_name
	readchart()

func _process(delta):
	_chartreading(delta)
	if time <= 0:
		time += 1000 * delta
	elif HUD.get_node("Music").playing == false:
		HUD.get_node("Music").stream.loop = false
		get_parent().get_node("Voices").stream.loop = false
		HUD.get_node("Music").play()
		get_parent().get_node("Voices").play()
	else:
		time = HUD.get_node("Music").AudioSync * 1000
	scalescroller += (1 - scalescroller) * (0.1 * (delta / 0.016667))
	scale = Vector2(scalescroller,scalescroller)

var sectionNotes
var chart
var song_name
var mustHitSection

func readchart():
	var chart_file = File.new()
	chart_file.open("res://Songs/" + song_name + "/" + song_name + ".json", File.READ)
	var chart_json = JSON.parse(chart_file.get_as_text())
	chart_file.close()
	chart = chart_json.result

var section = 0
var notecount = 0
var pagecount = 0

func _chartreading(delta):
	notehit = [0,0,0,0,0,0,0,0]
	HUD.get_node("Music").BPM = chart.song.bpm
	sectionNotes = int((time / (240.0 / HUD.get_node("Music").BPM)) / 1000.0)
	mustHitSection = chart.song.notes[sectionNotes].mustHitSection
	if get_tree().get_current_scene().has_method("ChartData"):
		get_tree().get_current_scene().ChartData(mustHitSection)
	
	if chart.song.notes.size() > pagecount:
		if chart.song.notes[pagecount].sectionNotes.size() == notecount:
			notecount = 0
			pagecount += 1
		else:
			if time + 2000 >= chart.song.notes[pagecount].sectionNotes[notecount][0]:
				var type = 0
				if range(chart.song.notes[pagecount].sectionNotes[notecount].size()).has(3):
					type = chart.song.notes[pagecount].sectionNotes[notecount][3]
				if !(chart.song.notes[pagecount].sectionNotes[notecount][1] == -1):
					Arrow(
						chart.song.notes[pagecount].sectionNotes[notecount][0],
						chart.song.notes[pagecount].sectionNotes[notecount][1],
						chart.song.notes[pagecount].sectionNotes[notecount][2],
						type,
						chart.song.notes[pagecount].mustHitSection
					)
				
				notecount += 1
	$debug/Label.text = "Section: " + str(sectionNotes)
	$debug/Label.text += "\nmustHitSection: " + str(mustHitSection)

var arrow_data

var noteload = load("res://Assets/Scripts/Note.tscn")
var dirs = ["Left","Down","Up","Right","Left","Down","Up","Right"]
var notedata = [[],[],[],[],[],[],[],[]]
var notehit = [0,0,0,0,0,0,0,0]

func Arrow(pos,dir,size,type,mustHitSection):
	var dir2 = dir
	if !mustHitSection:
		if dir2 > 3:
			dir2 -= 4
		elif dir2 <= 3:
			dir2 += 4
	
	arrow_data = [pos,dir2,size,type,mustHitSection,dirs[dir2]]
	
	if dir2 <= 3:
		notedata[dir2].append(pos)
		notedata[dir2].sort()
		get_node("Player1/" + dirs[dir2]).add_child(noteload.instance())
	if dir2 > 3:
		notedata[dir2].append(pos)
		notedata[dir2].sort()
		get_node("Player2/" + dirs[dir2]).add_child(noteload.instance())
	

func Notehit(dir,splash,accuracy):
	get_node("Player1/" + dirs[dir]).ArrowActive = true
	if splash:
		$Status.scalescroller = 1.05
	$Status.accuracy += accuracy * 4
	$Status.maxaccuracy += 250 * 4
	notehit[dir] = 1
	notedata[dir].remove(0)

func Notemiss(dir):
	$Status.maxaccuracy += 250 * 4
	notehit[dir] = 1
	notedata[dir].remove(0)
	$Status.miss()

func Notehitenemy(dir):
	notehit[dir] = 1
	notedata[dir].remove(0)
