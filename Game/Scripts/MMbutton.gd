class_name MainMenu extends Node

@export var startButton : Button;
@export var optionsButton : Button;
@export var creditsButton : Button;
@export var exitButton : Button;
@export var backButton : Button

@onready var mainMenuButtons: VBoxContainer = $"../VBoxContainer"
@onready var optionsPanel : Panel = $"../Options"

var levelScene : PackedScene;

func _ready():
	levelScene = preload("res://Scenes/level.tscn")
	startButton.pressed.connect(_start_pressed)
	optionsButton.pressed.connect(_options_pressed)
	creditsButton.pressed.connect(_credits_pressed)
	exitButton.pressed.connect(_exit_pressed)
	backButton.pressed.connect(_back_pressed)
	
	mainMenuButtons.show()
	optionsPanel.hide()

func _start_pressed():
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_packed(levelScene);
	
func _options_pressed():
	mainMenuButtons.hide()
	optionsPanel.show()

func _credits_pressed():
	pass

func _exit_pressed():
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()

func _back_pressed():
	mainMenuButtons.show()
	optionsPanel.hide()
	
