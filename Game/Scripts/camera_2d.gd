extends Camera2D
var positionTracker : Vector2
@export var parent : Node2D

var fix : bool = false

func _init():
	positionTracker = position 

func _process(delta):
	var tx = parent.position.x
	var ty = parent.position.y
	var x = positionTracker.x
	var y = positionTracker.y
	if(x<-520):
		positionTracker.x = -520
	
	if(x > tx + 50 and not tx+50 < -520):
		positionTracker.x = tx+50
	if(x < tx - 50 and not tx-50 > 700):
		positionTracker.x = tx-50
	if(y > ty + 60):
		positionTracker.y = ty+60
	if(y < ty+5):
		if(ty+5 > -10):
			positionTracker.y = -10
		else:
			positionTracker.y = ty+5
		
	if(x > 700):
		positionTracker.x = 700
	
	
	
	if(y>-10):
		positionTracker.y = -10
	if not fix:
		position = Vector2(round(positionTracker.x),round(positionTracker.y))


func _on_node_2d_game_lose():
	fix = true
