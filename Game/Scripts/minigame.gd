extends Node2D
@export var startTimer : float
@export var cursorSpeed : float

var cursor
var winBars
var cursorArea2D
var winBarArea2D
var minigameFinishArea2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cursor = $Minigame_Cursor
	winBars = Array([$Minigame_WinBar])
	cursorArea2D = $Minigame_Cursor/Area2D
	winBarArea2D = $Minigame_WinBar/Area2D
	minigameFinishArea2D = $Minigame_Bar/Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if startTimer>0:
		startTimer -= delta
		return
	if cursorArea2D.global_position.y >= minigameFinishArea2D.global_position.y:
		if winBars.is_empty():
			print("Minigame win!")
		print("Minigame finished!")
		queue_free()
	checkWinBars()
	cursor.position = Vector2(cursor.position.x, cursor.position.y + delta * cursorSpeed)

func checkWinCondition() -> bool:
	return winBars.is_empty()
	
func checkWinBars() -> void:
	for bar in winBars:
		for curs in bar.get_node("Area2D").get_overlapping_areas():
			winBarArea2D.erase(bar)
			break
	pass
