extends Sprite2D

@export var fadeTime : float
@export var startDelay : float = 0.05
var fadeTimer : float

func _ready():
	fadeTimer = fadeTime;
	show()
	
func _process(delta):
	if(startDelay > 0):
		startDelay -= delta
	else:
		if(fadeTimer > 0):
			fadeTimer -= delta
		else:
			hide()
			queue_free()
	modulate.a = fadeTimer/fadeTime
	
