extends Control

var pausePanel : Panel
var pauseButtons : VBoxContainer
var options : Panel
var backButton : Button

var mainMenu : PackedScene

func _ready():
	mainMenu = preload("res://Scenes/main_menu.tscn")
	pausePanel = get_child(0)
	pauseButtons = pausePanel.get_child(2)
	options = pausePanel.get_child(1)
	backButton = options.get_child(1)
	
	backButton.pressed.connect(_back_pressed)

func _input(event) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.is_action("pause"):
			if not pausePanel.visible:
				EnterPauseMenu()
			else:
				if options.visible:
					EnterPauseMenu()
				ExitPauseMenu()
			pausePanel.visible = not pausePanel.is_visible_in_tree()

func _on_options_pressed() -> void:
	EnterOptionsMenu()

func _on_return_pressed() -> void:
	#await get_tree().create_timer(0.05).timeout
	#get_tree().change_scene_to_packed(mainMenu)
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_resume_pressed() -> void:
	pausePanel.hide()

func _back_pressed():
	EnterPauseMenu()

func EnterPauseMenu():
	options.hide()
	pauseButtons.show()

func EnterOptionsMenu():
	pauseButtons.hide()
	options.show()

func ExitPauseMenu():
	options.hide()
	pauseButtons.hide()
