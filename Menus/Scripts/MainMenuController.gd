extends Control

var MainMenuCameraPosition : int = 0
var OptionsMenuCameraPosition : int = 1920

var configFile = ConfigFile.new()

@onready var transistion_sound = $"Sound Manager/SwooshSound"
@onready var hover_sound = $"Sound Manager/HoverSound"
@onready var click_sound = $"Sound Manager/ClickSound"


func _ready() -> void:
	$CameraHolder/MainMenuCamera.make_current()
	$CameraHolder/MainMenuCamera.position_smoothing_enabled


func _process(delta: float) -> void:
	pass

#Start button Actions
func _on_start_button_pressed() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

#option button Actions
func _on_options_button_pressed() -> void:
	click_sound.play()
	transistion_sound.play()
	$CameraHolder.position.x = OptionsMenuCameraPosition

#Quit button Actions
func _on_quit_button_pressed() -> void:
	click_sound.play()
	get_tree().quit()
	
#BackButton
func _on_back_button_pressed() -> void:
	click_sound.play()
	transistion_sound.play()
	$CameraHolder.position.x = MainMenuCameraPosition
#Save Button
func _on_save_button_pressed() -> void:
	click_sound.play()
	
	configFile.set_value("Master_Sound", "volume", $"Options Menu/Master Sound".value)
	configFile.set_value("Music_Sound", "volume", $"Options Menu/Music Sound".value)
	configFile.set_value("SFX_Sound", "volume", $"Options Menu/SFX Sound".value)
	
	configFile.save("res://settings.cfg")



#Play sound when mouse enters buttons
func _on_start_button_mouse_entered() -> void:
	hover_sound.play()

func _on_options_button_mouse_entered() -> void:
	hover_sound.play()

func _on_quit_button_mouse_entered() -> void:
	hover_sound.play()

func _on_back_button_mouse_entered() -> void:
	hover_sound.play()

func _on_save_button_mouse_entered() -> void:
	hover_sound.play()
