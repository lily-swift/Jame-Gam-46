extends Sprite2D

var cursorOverlap : bool = false
signal clicked(winBar : Sprite2D)

func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and cursorOverlap:
			clicked.emit(self)
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../MinigamePlunger":
		cursorOverlap = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../MinigamePlunger":
		cursorOverlap = false
