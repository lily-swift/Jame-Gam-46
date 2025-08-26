extends Node2D

@export var camera : Camera2D
var basePos : Vector2

func _init():
	basePos = position

func _process(delta):
	position = round(camera.position*0.7)+basePos
	#position = round((position-camera.position)/4)*4 + camera.position
