extends Control

var MainMenuCameraPosition : int = 0
var OptionsMenuCameraPosition : int = 1920

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraHolder/MainMenuCamera.make_current()
	$CameraHolder/MainMenuCamera.position_smoothing_enabled

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Start button Actions
func _on_start_button_pressed() -> void:
	pass # Replace with function body.

#option button Actions
func _on_options_button_pressed() -> void:
	$CameraHolder.position.x = OptionsMenuCameraPosition

#Quit button Actions
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
#BackButton
func _on_back_button_pressed() -> void:
	$CameraHolder.position.x = MainMenuCameraPosition
