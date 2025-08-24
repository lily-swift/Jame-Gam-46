extends RigidBody2D
@export var size : int = 2
@export var crumbleSpeed : float = 0.5
@export var height : float
@export var rubblePos : Vector2
var crumbleProgress : float = 0
var crumbling : bool = false
var startpos : Vector2

func _ready():
	$AnimatedSprite2D.play("default")
	$Effects.hide()
	$Effects.position = Vector2(0,0)
	startpos = position
	print(startpos)
	z_index = -1
	

func balloon():
	$AnimatedSprite2D.play("balloon")
	mass = 2
	gravity_scale = -0.5
	
func _process(delta):
	if(Input.is_action_just_pressed("debug")):
		rubble()
	
	if(crumbling):
		position = startpos + Vector2(0,round(crumbleProgress * height * 1.1))
		$AnimatedSprite2D.position.x = round(randf_range(-2,2))
		$Effects.position = rubblePos -Vector2(0,round(crumbleProgress * height * 1.1))
		crumbleProgress += delta * crumbleSpeed
		if(crumbleProgress >= 1):
			crumbling = false
			$AnimatedSprite2D.hide()
		
	
	
func rubble():
	if(not crumbling):
		crumbling = true
		$Effects.play("Rubble")
		$Effects.position = rubblePos
		$Effects.show()
		freeze = true
		collision_layer = round(pow(2,10))
