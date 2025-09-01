extends Sprite2D

@onready var keyPressTimer : Timer = $"../KeyPressTimer"
#@onready var indicatorPos : Node2D
#@onready var indicator : PackedScene = preload("res://Scenes/indicator.tscn")

var plungerOverlap : bool = false
signal clicked(winBar : Sprite2D)

func _ready():
	#indicatorPos = get_node("../Plunger/IndicatorSpawnPos")
	pass

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			if false: #not keyPressTimer.is_stopped():
				return
			#var indicatorInstance : AnimatedSprite2D = indicator.instantiate()
			#indicatorInstance.global_position = indicatorPos.global_position
			if plungerOverlap:
				clicked.emit(self)
				keyPressTimer.start()
			#	indicatorInstance.play("Success")
				queue_free()
			#else:
			#	indicatorInstance.play("Failure")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../Plunger":
		plungerOverlap = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../Plunger":
		plungerOverlap = false
