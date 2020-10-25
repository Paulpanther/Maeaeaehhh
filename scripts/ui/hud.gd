extends CanvasLayer

export var max_time : int = 60 * 3

onready var starttime = OS.get_ticks_msec()


func _process(delta):
	var score = calc_score()
	Score.score = score
	$Score.text = "Score: " + str(score)
	var time = calc_time()
	$Timer.text = "Time: " + str(time)
	if time < 0:
		get_parent().die()

func calc_score():
	var cam = get_parent().get_node("Schaf")
	return int(cam.position.x / 10)

func calc_time():
	return max_time - (OS.get_ticks_msec() - starttime) / 1000
