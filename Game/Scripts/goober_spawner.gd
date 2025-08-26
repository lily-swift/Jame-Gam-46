extends Node2D

@export var spawnWidth : float = 20
@export var gooberSpeed : float = 30
@export var gooberCount : int = 10

const GOOBER = preload("res://Scenes/goober.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(gooberCount):
		var goobInstance : AnimatedSprite2D = GOOBER.instantiate()
		add_child(goobInstance)
		goobInstance.position = Vector2((randf() * (spawnWidth * 2)) - spawnWidth, 0)
		goobInstance.speed = gooberSpeed
		goobInstance.left_bound = get_node("LeftBound")
		goobInstance.right_bound = get_node("RightBound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
