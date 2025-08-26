extends AnimatedSprite2D

@export var left_bound: Node2D
@export var right_bound: Node2D
@export var speed : float
@export var animationSpeed : float

var turnDirection : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turnDirection = randi_range(0, 1)
	if turnDirection == 0:
		turnDirection = -1
	play()
	speed_scale
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x < left_bound.position.x:
		turnDirection = 1
	elif position.x > right_bound.position.x:
		turnDirection = -1
	position = Vector2(position.x + (delta * speed) * turnDirection, 0)
