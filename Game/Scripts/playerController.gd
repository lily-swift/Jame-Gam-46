extends RigidBody2D

var input_directionW : int = 0
var jumpPressed : bool = false
var drillPressed : bool = false
@export var jumpCoolDown : float = 1
@export var jumps : int = 3
var jumpsLeft : int = 3
var jumpCDT : float = 1
var jumpT : float = 0;
@export var virusBody : RigidBody2D
@export var virusAnims : AnimatedSprite2D
@export var virusDrillArea : Area2D
@export var groundDetector : Area2D
var balloonInflationLevel : int = 1;
@export var jumpForce : float = 1000;
@export var jumpStartup : float = 0.1;
var jumpSUT : float = 0;
var jumpELT : float = 0;
@export var jumpEndLag : float = 0.1; 
@export var jumpDuration : float = 0.25
@export var moveSpeed : float = 100;
var upAnimTimer : float = -1;
@export var frictionX : float = 1
@export var frictionY : float = 1
@export var drillCooldown : float = 0.5
@export var drillStartup : float = 0.05
var drillSUT : float = 0
var drillCDT = 0;
var building : Object

var state : String = "Idle"
var size : int = 2;

var rot : float = 0;

func _physics_process(delta):
	if(jumpT > 0):
		apply_central_force(Vector2(0,-1) * jumpForce)
		if(linear_velocity.y > 0):
			jumpT += delta/2
			apply_central_force(linear_velocity * (-1) * Vector2(0,3))
	
	apply_central_force(Vector2(1,0) * input_directionW * moveSpeed)
	apply_central_force(linear_velocity * (-1) * Vector2(frictionX,frictionY))
	

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
		if(jumpT <= 0):
			jumpELT = jumpEndLag
	if(upAnimTimer > -1):
		upAnimTimer += delta
	if(jumpSUT > 0):
		jumpSUT -= delta
		if(jumpSUT <= 0):
			jumpT = jumpDuration
	if(jumpELT > 0):
		jumpELT -= delta
		if(jumpELT <= 0):
			size = 2
	if(drillCDT > 0):
		drillCDT -= delta
	if(drillSUT > 0):
		drillSUT -= delta
		if(drillSUT <= 0):
			startDrill()

func startDrill():
	if virusDrillArea.has_overlapping_bodies():
		building = virusDrillArea.get_overlapping_bodies()[0]
		print(building)
		state = "Drill"
	else:
		state = "Idle"
		$LandSFX.play()
		drillCDT = drillCooldown
	

func jump():
	#apply_central_impulse(jumpImpuse * Vector2(0,-1))
	jumpCDT = jumpCoolDown
	jumpSUT = jumpStartup
	jumpsLeft -= 1
	#jumpT = jumpDuration
	$InflateSFX.pitch_scale = randf_range(0.95,1.05)
	$InflateSFX.play()
	

func on_ground():
	return groundDetector.has_overlapping_bodies()
	
	

func _process(delta):
	get_input()
	timers(delta)
	
	
	#states
	if(linear_velocity.y < -4):
		if(upAnimTimer == -1):
			upAnimTimer = 0
		elif upAnimTimer > 0.3:
			state = "Float"
	
	if(linear_velocity.y > 2 and state == "Float"):
		state = "Fall"
	
	if(on_ground() and (not jumpSUT  > 0) and (not jumpT > 0) and (not drillSUT > 0) and (not state == "Drill")):
		state = "Idle"
		if(jumpCDT <= 0):
			jumpsLeft = jumps
	
	if state == "Idle" and Input.is_action_just_pressed("drill") and drillCDT <= 0:
		drillSUT = drillStartup
		state = "Crouch"
		size = 2
			
	
	if state == "Crouch" or state == "Drill":
		freeze = true
		virusBody.freeze = true
	else:
		freeze = false
		virusBody.freeze = false
	
	if state == "Fall":
		virusAnims.play("Fall")
	elif state == "Float":
		virusAnims.play("Jump")
	elif state == "Idle":
		virusAnims.play("Idle")
	elif state == "Crouch":
		virusAnims.play("Crouch")
	elif state == "Drill":
		virusAnims.play("Injecting")
	
	#Jump
	if jumpPressed and (jumpCDT <= 0) and jumpsLeft > 0:
		jump()
	
	if(jumpT > 0 or jumpELT > 0 or jumpSUT > 0):
		size = 3
		mass = 1.6
	elif jumpsLeft == 0:
		size = 1
		mass = 0.7
	else:
		size = 2
		mass = 1
	
	if(state == "Fall"):
		if(size == 1):
			$AnimatedSprite2D.play("FloatS")
		elif(size == 2):
			$AnimatedSprite2D.play("FloatM")
		else:
			$AnimatedSprite2D.play("FloatL")
	elif(state == "Idle"):
		if(size == 1):
			$AnimatedSprite2D.play("IdleS")
		elif(size == 2):
			$AnimatedSprite2D.play("IdleM")
		else:
			$AnimatedSprite2D.play("IdleL")
	elif(state == "Float"):
		if(size == 1):
			$AnimatedSprite2D.play("JumpS")
		elif(size == 2):
			$AnimatedSprite2D.play("JumpM")
		else:
			$AnimatedSprite2D.play("JumpL")
	elif(state == "Crouch"):
		if(size == 1):
			$AnimatedSprite2D.play("CrouchS")
		elif(size == 2):
			$AnimatedSprite2D.play("CrouchM")
		else:
			$AnimatedSprite2D.play("CrouchL")
	elif state == "Drill":
		$AnimatedSprite2D.play("Drill")
	
	
