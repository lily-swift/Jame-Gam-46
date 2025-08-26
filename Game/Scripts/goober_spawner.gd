extends Node2D

@onready var left_bound: Node2D = $LeftBound
@onready var right_bound: Node2D = $RightBound

@export var spawnWidth : float = 20
@export var gooberSpeed : float = 30
@export var gooberSpeedVariation : float = 10
@export var gooberCount : int = 10
@export var leftBoundDistance : int = 75
@export var rightBoundDistance : int = 75

const GOOBER = preload("res://Scenes/goober.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateGoobers()
	left_bound.position = Vector2(-leftBoundDistance, 0)
	right_bound.position = Vector2(rightBoundDistance, 0)

func generateGoobers():
	for i in range(gooberCount):
		var goobInstance : AnimatedSprite2D = GOOBER.instantiate()
		add_child(goobInstance)
		goobInstance.position = Vector2((randf() * (spawnWidth * 2)) - spawnWidth, 0)
		goobInstance.speed = gooberSpeed + randf_range(-gooberSpeedVariation, gooberSpeedVariation)
		goobInstance.left_bound = get_node("LeftBound")
		goobInstance.right_bound = get_node("RightBound")
