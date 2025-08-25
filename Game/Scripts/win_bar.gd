extends Sprite2D

var cursorOverlap : bool = false
signal clicked

func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and cursorOverlap:
			clicked.emit()
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../Minigame_Cursor":
		cursorOverlap = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../Minigame_Cursor":
		cursorOverlap = false
