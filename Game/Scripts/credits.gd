extends Control

func _on_back_pressed() -> void:
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
