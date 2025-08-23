extends CharacterBody2D

var input_directionW : int = 0

func _ready():
	$AnimatedSprite2D.play("Idle");
	
func get_input():
	input_directionW = 0;
	if Input.is_action_pressed("left"):
		input_directionW -= 1
	if Input.is_action_pressed("right"):
		input_directionW += 1
