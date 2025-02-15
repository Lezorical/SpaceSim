extends Control

var MainMenuCameraPosition : int = 0
var OptionsMenuCameraPosition : int = 1920

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



#Play sound when mouse enters buttons
func _on_start_button_mouse_entered() -> void:
	hover_sound.play()

func _on_options_button_mouse_entered() -> void:
	hover_sound.play()

func _on_quit_button_mouse_entered() -> void:
	hover_sound.play()

func _on_back_button_mouse_entered() -> void:
	hover_sound.play()
