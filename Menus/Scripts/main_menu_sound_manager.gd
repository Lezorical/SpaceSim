extends Node

@onready var background_music_1 = $backgroundMusic1
@onready var background_music_2 = $backgroundMusic2
@onready var background_music_3 = $backgroundMusic3

@onready var master_sound_slider = $"../Options Menu/Master Sound"
@onready var music_sound_slider = $"../Options Menu/Music Sound"

@export var master_bus : String
@export var main_menu_bus : String
@export var sfx_bus : String

var mapped_value
var master_bus_index : int = 0
var main_menu_bus_index : int =  1
var sfx_bus_index : int = 2

var current_playing : int = 0

#Change volume based on slider
func _on_master_sound_value_changed(value: float) -> void:
	$"../Options Menu/Master Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))

func _on_music_sound_value_changed(value: float) -> void:
	$"../Options Menu/Music Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(main_menu_bus_index, linear_to_db(value))
	
func _on_sfx_sound_value_changed(value: float) -> void:
	$"../Options Menu/SFX Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))



#Called when audio is done playing
func _on_audio_stream_finished() -> void:
	
	await get_tree().create_timer(10.0).timeout
	
	# Play the other track.
	if current_playing == 0:
		background_music_3.play()
		current_playing = 1
	else:
		background_music_1.play()
		current_playing = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	master_bus_index = AudioServer.get_bus_index(master_bus)
	main_menu_bus_index = AudioServer.get_bus_index(main_menu_bus)
	sfx_bus_index = AudioServer.get_bus_index(sfx_bus)
	
	randomize()
	var first_to_play = randi_range(0,1)
	
	if first_to_play == 0:
		background_music_1.play()
		current_playing = 0
	else:
		background_music_3.play()
		current_playing = 1
	
	background_music_1.finished.connect(_on_audio_stream_finished)
	background_music_2.finished.connect(_on_audio_stream_finished)
