extends Sprite2D

@onready var keyPressTimer : Timer = $"../KeyPressTimer"
@onready var indicator : AnimatedSprite2D = $"../Plunger/Indicator"

var plungerOverlap : bool = false
signal clicked(winBar : Sprite2D)

func _input(event) -> void:
	if event is InputEventKey:
		if not (event.pressed and event.keycode == KEY_SPACE):
			return
		if not keyPressTimer.is_stopped():
			return
		if plungerOverlap:
			clicked.emit(self)
			keyPressTimer.start()
			indicator.animation = "Success"
			indicator.play()
			queue_free()
			return
		indicator.animation = "Failure"
		indicator.play("Failure")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../Plunger":
		plungerOverlap = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../Plunger":
		plungerOverlap = false
