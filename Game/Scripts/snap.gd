extends Node2D

@export var camera : Camera2D
var basePos : Vector2
@export var scaleX : float = 0.7
@export var scaleY : float = 0.7

func _init():
	basePos = position

func _process(delta):
	position = Vector2(round(camera.position.x * scaleX), round(camera.position.y * scaleY)) + basePos
	#position = round((position-camera.position)/4)*4 + camera.position
