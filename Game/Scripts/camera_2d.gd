extends Camera2D
var positionTracker : Vector2
@export var parent : Node2D

func _init():
	positionTracker = position 

func _process(delta):
	var tx = parent.position.x
	var ty = parent.position.y
	var x = positionTracker.x
	var y = positionTracker.y
	if(x > tx + 50):
		positionTracker.x = tx+50
	if(x < tx - 50):
		positionTracker.x = tx-50
	if(y > ty + 60):
		positionTracker.y = ty+60
	if(y < ty+5  and not (ty+5 > -10)):
		positionTracker.y = ty+5
		
	if(y>-10):
		positionTracker.y = -10
	
	position = Vector2(round(positionTracker.x),round(positionTracker.y))
