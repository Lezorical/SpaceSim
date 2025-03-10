extends Node

@onready var master_sound_slider = $"../Options Menu/Master Sound"
@onready var music_sound_slider = $"../Options Menu/Music Sound"

@onready var master_sound_icon: TextureRect = $"../Options Menu/Master Sound/MasterSound Icon"
@onready var music_sound_icon: TextureRect = $"../Options Menu/Music Sound/MusicSound Icon"
@onready var sfx_sound_icon: TextureRect = $"../Options Menu/SFX Sound/SFXSound Icon"


@export var master_bus : String
@export var main_menu_bus : String
@export var sfx_bus : String

var master_bus_index : int = 0
var main_menu_bus_index : int =  1
var sfx_bus_index : int = 2



#Change volume based on slider
func _on_master_sound_value_changed(value: float) -> void:
	$"../Options Menu/Master Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
	if value == 0:
		master_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIconMute.png")
	elif value <= 1:
		master_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIcon.png")

func _on_music_sound_value_changed(value: float) -> void:
	$"../Options Menu/Music Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(main_menu_bus_index, linear_to_db(value))
	if value == 0:
		music_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIconMute.png")
	elif value <= 1:
		music_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIcon.png")
	
func _on_sfx_sound_value_changed(value: float) -> void:
	$"../Options Menu/SFX Sound/Sound Level".text = str(int(lerp(0, 100, value)))
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))
	if value == 0:
		sfx_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIconMute.png")
	elif value <= 1:
		sfx_sound_icon.texture = ResourceLoader.load("res://Menus/Images/soundIcon.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	master_bus_index = AudioServer.get_bus_index(master_bus)
	main_menu_bus_index = AudioServer.get_bus_index(main_menu_bus)
	sfx_bus_index = AudioServer.get_bus_index(sfx_bus)
	
