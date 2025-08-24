extends Area2D

@export var landSfxCooldown : float = 0.4
var landSfxCDT : float = 0

func _process(delta):
	if(landSfxCDT > 0):
		landSfxCDT -= delta

func _on_body_entered(body):
	if landSfxCDT <= 0:
		$LandSFX.pitch_scale = randf_range(0.95,1.05)
		$LandSFX.play()
		landSfxCDT = landSfxCooldown
