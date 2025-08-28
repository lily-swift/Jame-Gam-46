extends RigidBody2D
@export var size : int = 2
@export var crumbleSpeed : float = 0.5
@export var height : float
@export var width : float
@export var rubblePos : Vector2
@export var bubbleSpeed : float = 1
@export var shader : ShaderMaterial
var crumbleProgress : float = 0
var crumbling : bool = false
var bubbled : bool = false
var startpos : Vector2
@export var injectPoint : Node2D
var bubbleProgress : float

var BalloonForBalloonGod : CPUParticles2D

func _ready():
	$AnimatedSprite2D.play("default")
	$Effects.hide()
	$Effects.position = Vector2(0,0)
	startpos = position
	print(startpos)
	z_index = -1
	BalloonForBalloonGod = $"../../Background/BalloonGod/Balloon4BalloonGod"
	

func bubble():
	if not bubbled:
		bubbled = true
		#$AnimatedSprite2D.play("balloon")
		$Effects.play("balloon")
		$Effects.show()
		print("ballloooon")
		#print($AnimatedSprite2D.g)
		#$AnimatedSprite2D.set_instance_shader_parameter("enabled",true)
		
		var adjustedInjectPoint = injectPoint.global_position - position + Vector2(width,height)/2
		shader.set_shader_parameter("injectPoint", adjustedInjectPoint)
		shader.set_shader_parameter("sizeX",width)
		shader.set_shader_parameter("sizeY",height)
		#$AnimatedSprite2D.set_instance_shader_parameter("injectPoint", adjustedInjectPoint)
		print(adjustedInjectPoint)
		#$AnimatedSprite2D.set_instance_shader_parameter("sizeX",width)
		#$AnimatedSprite2D.set_instance_shader_parameter("sizeY",height)
		mass = 4
		gravity_scale = -0.25
		BalloonForBalloonGod.emitting = true
	
func _process(delta):
	BalloonForBalloonGod.emitting = false
	if(Input.is_action_just_pressed("debug") and visible):
		bubble()
	
	if(bubbled and bubbleProgress < 1):
		bubbleProgress += delta * bubbleSpeed
		#$AnimatedSprite2D.set_instance_shader_parameter("progress",bubbleProgress)
		shader.set_shader_parameter("progress", bubbleProgress)
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
