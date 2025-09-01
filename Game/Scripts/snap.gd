extends Node2D

@export var camera : Camera2D
@export var basePos : Vector2
@export var scaleX : float = 0.7
@export var scaleY : float = 0.7

var sink : bool = false
var rise : bool = false

func _init():
	basePos = position

func _process(delta):
	position = Vector2(round(camera.position.x * scaleX), round(camera.position.y * scaleY)) + round(basePos)
	if(sink):
		basePos += Vector2(0, delta * 5)
	if(rise):
		basePos -= Vector2(0, delta * 3)
	#position = round((position-camera.position)/4)*4 + camera.position


func _on_node_2d_game_lose():
	sink = true


func _on_node_2d_game_win():
	rise = true
