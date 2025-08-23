extends RigidBody2D

var input_directionW : int = 0
var jumpPressed : bool = false
var drillPressed : bool = false
@export var jumpCoolDown : float = 1
var jumpCDT : float = 1
var jumpT : float = 0;
@export var virusBody : RigidBody2D
@export var virusAnims : AnimatedSprite2D
var balloonInflationLevel : int = 1;
@export var jumpForce : float = 1000;
@export var jumpDuration : float = 0.25
@export var moveSpeed : float = 100;
var upAnimTimer : float = -1;
@export var frictionX : float = 1;
@export var frictionY : float = 1;

var state : String = "Idle"

var rot : float = 0;

func _ready():
	$AnimatedSprite2D.play("IdleM");
	state = "Idle"
	
func get_input():
	input_directionW = 0;
	if Input.is_action_pressed("moveLeft"):
		input_directionW -= 1
	if Input.is_action_pressed("moveRight"):
		input_directionW += 1
	jumpPressed = Input.is_action_just_pressed("jump")
	drillPressed = Input.is_action_just_pressed("drill")
		
func timers(delta):
	if(jumpCDT > 0):
		jumpCDT -= delta
	if(jumpT > 0):
		jumpT -= delta
	if(upAnimTimer > -1):
		upAnimTimer += delta

func jump():
	print("jump")
	#apply_central_impulse(jumpImpuse * Vector2(0,-1))
	jumpCDT = jumpCoolDown
	jumpT = jumpDuration

func _process(delta):
	get_input()
	timers(delta)
	
	print(linear_velocity)
	
	#states
	if(linear_velocity.y < -4):
		if(upAnimTimer == -1):
			upAnimTimer = 0
		elif upAnimTimer > 0.3:
			state = "Fall"
			virusAnims.play("Idle")
	
	if(linear_velocity.y > 2 and virusAnims.animation == "Idle"):
		state = "Float"
	
	if(state == "Fall" or state == "Idle"):
		virusAnims.play("Idle")
	elif state == "Float":
		virusAnims.play("Float")
	
	#Jump
	if jumpPressed and (jumpCDT <= 0):
		jump()
	
	if(jumpT > 0):
		apply_central_force(Vector2(0,-1) * jumpForce)
		if(linear_velocity.y > 0):
			jumpT += delta/2
			apply_central_force(linear_velocity * (-1) * Vector2(0,3))
		if(state == "Fall"):
			$AnimatedSprite2D.play("IdleL")
		if(state == "Float"):
			$AnimatedSprite2D.play("FloatL")
	else:
		if(state == "Fall"):
			$AnimatedSprite2D.play("IdleM")
		if(state == "Float"):
			$AnimatedSprite2D.play("FloatM")
		
		print("ascending")
		
	apply_central_force(Vector2(1,0) * input_directionW * moveSpeed)
	apply_central_force(linear_velocity * (-1) * Vector2(frictionX,frictionY))
