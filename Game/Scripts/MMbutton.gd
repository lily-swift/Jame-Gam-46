class_name MainMenu extends Node

@export var startButton : Button;
@export var optionsButton : Button;
@export var creditsButton : Button;
@export var exitButton : Button;

var levelScene : PackedScene;

func _ready():
	levelScene = preload("res://Scenes/level.tscn");
	startButton.pressed.connect(_start_pressed);
	optionsButton.pressed.connect(_options_pressed);
	creditsButton.pressed.connect(_credits_pressed);
	exitButton.pressed.connect(_exit_pressed);
	


func _start_pressed():
	get_tree().change_scene_to_packed(levelScene);
	
func _options_pressed():
	pass

func _credits_pressed():
	pass

func _exit_pressed():
	get_tree().quit()
