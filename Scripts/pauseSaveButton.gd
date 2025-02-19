extends Button


var settings = ConfigFile.new()

#Settings adjusters
@onready var masterSound : float = $"../Sound/Master Sound".value
@onready var musicSound : float= $"../Sound/Music Sound".value
@onready var sfxSound : float = $"../Sound/SFX Sound".value
@onready var looksensitivity : float = $"../Look Sensitivity".value


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	settings.set_value("master_volume", "volume", masterSound)
	settings.set_value("music_volume", "volume", musicSound)
	settings.set_value("sfx_volume", "volume", sfxSound)
	settings.set_value("look_sensitivity", "sensitivity", looksensitivity)
	
	settings.save("res://settings.cfg")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
