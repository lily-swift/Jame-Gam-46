extends Panel

@export var testSFX : AudioStreamWAV

@onready var musicSlider : HSlider = $MusicSlider/HSlider
@onready var sfxSlider : HSlider = $SFXSlider/HSlider
@onready var sfxPlayer : AudioStreamPlayer = $AudioStreamPlayer

var musicBusId : int
var sfxBusId : int

func _ready():
	sfxPlayer.stream = testSFX
	sfxPlayer.playing = false
	musicBusId = AudioServer.get_bus_index("Music")
	sfxBusId = AudioServer.get_bus_index("SFX")
	
	musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(musicBusId))
	sfxSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfxBusId))

func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(musicBusId, db)

func _on_sfx_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(sfxBusId, db)

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	sfxPlayer.play()
