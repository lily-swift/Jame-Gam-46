extends Sprite2D

var cursorOverlap : bool = false
	
func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			print("Space Pressed")
			if cursorOverlap:
				queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Area entered: ", area)
	if area == $"../Minigame_Cursor/Area2D/CollisionShape2D":
		cursorOverlap = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("Area exited: ", area)
	if area == $"../Minigame_Cursor/Area2D/CollisionShape2D":
		cursorOverlap = false
