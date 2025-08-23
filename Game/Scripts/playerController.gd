extends RigidBody2D

var input_directionW : int = 0

var rot : float = 0;

func _ready():
	$AnimatedSprite2D.play("Idle");
	
func get_input():
	input_directionW = 0;
	if Input.is_action_pressed("left"):
		input_directionW -= 1
	if Input.is_action_pressed("right"):
		input_directionW += 1


func _process(delta):
	rot += 1*delta;
	if rot >= 360:
		rot -= 360;
	rotation = rot;
