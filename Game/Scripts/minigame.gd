extends Node2D

@export var startDelay : float
@export var cursorSpeed : float
@export var winBarCount : int
@export var winBarPixelHeight : int

var cursorCollisionShape : CollisionShape2D
var cursorRigidBody2D : RigidBody2D
var initCursorPosition : Vector2
var minigameFinishArea2D : Area2D
var winBarDict : Dictionary
var isActive : bool = false
var startTimer : float

var winBarRef = preload("res://Scenes/minigame_win_bar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cursorCollisionShape = $Minigame_Cursor/CollisionShape2D
	cursorRigidBody2D = $Minigame_Cursor
	minigameFinishArea2D = $Minigame_Bar/Area2D
	initCursorPosition = cursorRigidBody2D.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not isActive:
		return
		
	if startTimer > 0:
		startTimer -= delta
		return
		
	if cursorCollisionShape.global_position.y >= minigameFinishArea2D.global_position.y:
		if winBarDict.size() == 0:
			print("Minigame win!")
		print("Minigame finished!")
		Reset()
		return
	cursorRigidBody2D.linear_velocity = Vector2(0, cursorSpeed)

func _clicked(winBar: Sprite2D) -> void:
	winBarDict.erase(winBar)

func Start() -> void:
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
		isActive = true

func Reset() -> void:
	isActive = false
	cursorRigidBody2D.linear_velocity = Vector2(0,0)
	cursorRigidBody2D.position = initCursorPosition
	for bar in winBarDict.keys():
		bar.queue_free()
	winBarDict.clear()

func IsOverlap(pos : Vector2) -> bool:
	for barPos in winBarDict.values():
		if pos.distance_to(barPos) <= winBarPixelHeight + 1:
			return true
	return false

## For debugging purposes
#func _input(event) -> void:
#	if event is InputEventKey:
#		if event.pressed and event.keycode == KEY_L:
#			Start()
