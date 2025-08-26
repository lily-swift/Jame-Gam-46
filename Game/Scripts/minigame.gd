extends Node2D

@onready var injectPulseSFX : AudioStreamPlayer = $InjectPulseSFX
@onready var loseJingle: AudioStreamPlayer = $LoseJingle
@onready var winJingle: AudioStreamPlayer = $WinJingle
@onready var minigameFinishMarker : Node2D = $Background/FinishMarker
@onready var plungerCollisionShape : CollisionShape2D = $Plunger/CollisionShape2D
@onready var plungerRigidBody2D : RigidBody2D = $Plunger

@export var startDelay : float
@export var plungerSpeed : float
@export var winBarCount : int
@export var winBarPixelHeight : int
@export var offset : Vector2 

var initPlungerPosition : Vector2
var winBarDict : Dictionary
var isActive : bool = false
var startTimer : float
var beginMoving : bool = false

var winBarRef = preload("res://Scenes/minigame_win_bar.tscn")

signal minigameWin
signal minigameLose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func _physics_process(_delta: float) -> void:
	if beginMoving:
		plungerRigidBody2D.linear_velocity = Vector2(0, plungerSpeed)
		plungerRigidBody2D.position = Vector2(initPlungerPosition.x, plungerRigidBody2D.position.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not isActive:
		return
		
	if startTimer > 0:
		startTimer -= delta
		return
	beginMoving = true
	
	if plungerCollisionShape.global_position.y >= minigameFinishMarker.global_position.y:
		if winBarDict.size() == 0:	## Minigame win
			Win()
		else:
			Lose()
		hide()
		print("Minigame finished!")
		Reset()
		return

func _clicked(winBar: Sprite2D) -> void:
	winBarDict.erase(winBar)
	injectPulseSFX.play()
	
func _on_balloon_start_minigame(pos, difficulty):
	position = pos + offset
	winBarCount = difficulty
	winBarPixelHeight = 3 * (4 - difficulty)
	show()
	Start()

func Start() -> void:
	isActive = true
	initPlungerPosition = plungerRigidBody2D.position
	startTimer = startDelay
	
	for i in range(winBarCount):
		var bar : Sprite2D = winBarRef.instantiate()
		add_child(bar)
		bar.scale = Vector2(bar.scale.x, bar.scale.y * winBarPixelHeight)
		bar.clicked.connect(_clicked)
		
		var newPosition : Vector2 = Vector2(0, (randf() * 40) - 20)
		while IsOverlap(newPosition):
			newPosition = Vector2(0, (randf() * 40) - 20)
		bar.position = newPosition
		
		winBarDict.get_or_add(bar, newPosition)

func Reset() -> void:
	isActive = false
	beginMoving = false
	plungerRigidBody2D.linear_velocity = Vector2(0,0)
	plungerRigidBody2D.position = initPlungerPosition
	print("RESET!")
	for bar in winBarDict.keys():
		bar.queue_free()
	winBarDict.clear()

func IsOverlap(pos : Vector2) -> bool:
	for barPos in winBarDict.values():
		if pos.distance_to(barPos) <= winBarPixelHeight + 1:
			return true
	return false
	
func Win():
	winJingle.play()
	minigameWin.emit()

func Lose():
	loseJingle.play()
	minigameLose.emit()

## For debugging purposes
func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_L:
			Start()
		if event.pressed and event.keycode == KEY_K:
			position = Vector2(238, 42)
