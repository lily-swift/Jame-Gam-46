extends Node

@onready var label = $Label
@onready var timer = $Timer
@export var balloonGoal : int = 20
@export var time : float

var BalloonGod : Sprite2D

var BGstartPos : float

signal gameWin
signal gameLose

func _ready():
	
	timer.wait_time = time
	timer.start()
	$Label.show()
	BalloonGod = $"../../../../Background/BalloonGod"
	BGstartPos = BalloonGod.basePos.y
	
func time_left():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta):
	label.text = "%02d:%02d" % time_left()




func _on_timer_timeout():
	$Label.hide()
	print("timeout")
	if(BalloonGod.basePos.y > BGstartPos - balloonGoal):
		print("lose")
		gameLose.emit()
	else:
		gameWin.emit()
