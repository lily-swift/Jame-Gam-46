extends Sprite2D

@export var fadeTime : float
@export var startDelay : float = 0.05
@export var music : AudioStreamPlayer2D
@export var shader : ShaderMaterial
var fadeTimer : float
var fadeIn = true
var disabled = false
var balloonTime = false

var balloon : RigidBody2D
@export var balloonGod : Sprite2D


func _ready():
	fadeTimer = fadeTime
	shader.set_shader_parameter("progress", 10)
	show()
	balloon = get_parent().get_parent().get_parent().get_parent()
	modulate = Color(0,0,0,1)
	
func _process(delta):
	if(balloonTime):
		var sourcePoint = (balloonGod.global_position - global_position + Vector2(180,75))
		print(sourcePoint)
		shader.set_shader_parameter("injectPoint", sourcePoint)
		shader.set_shader_parameter("progress", shader.get_shader_parameter("progress") + delta/3.0)
		if(shader.get_shader_parameter("progress") > 3):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
			
		
	if(disabled):
		return
	if(startDelay > 0):
		startDelay -= delta
	else:
		if fadeIn:
			if(fadeTimer > 0):
				fadeTimer -= delta
			else:
				hide()
				balloon.noInput = false
				disabled = true
		else:
			if(fadeTimer < fadeTime*1.3):
				fadeTimer += delta/2.5
			else:
				get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
				
		
	modulate.a = fadeTimer/fadeTime


func _on_node_2d_game_lose():
	print("start fade")
	disabled = false
	fadeIn = false
	fadeTimer = -0.8
	music.stop()
	show()


func _on_node_2d_game_win():
	balloonTime = true
	modulate = Color(0.682,0.157,0.314,1)
	shader.set_shader_parameter("progress", -0.5)
	music.stop()
	show()
	
	
