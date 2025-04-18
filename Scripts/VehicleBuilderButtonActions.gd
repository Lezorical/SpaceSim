extends Node

@onready var clear_slate: Node = $"../Clear Slate"
@onready var Are_You_Sure_prompt = $"../../GUI/Building Screen/Main/Main Menu Button/Are you sure Prompt"
@onready var MouseEnteredSound = $"../../Sound Manager/Button Hover Sound"
@onready var ButtonPressedSound = $"../../Sound Manager/Button Click Sound"

func _PlayMouseEnteredSound():
	MouseEnteredSound.play()
func _PlayButtonPressedSound():
	ButtonPressedSound.play()


func _ready() -> void:
	Are_You_Sure_prompt.visible = false


#Are you sure button Logic
func _on_main_menu_button_pressed() -> void:
	ButtonPressedSound.play()
	Are_You_Sure_prompt.visible = true
	Engine.time_scale = 0
func _on_yes_button_pressed() -> void:
	ButtonPressedSound.play()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
func _on_no_button_pressed() -> void:
	ButtonPressedSound.play()
	Engine.time_scale = 1
	Are_You_Sure_prompt.visible = false
func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _on_clear_pressed() -> void:
	ButtonPressedSound.play()
	clear_slate._clear_slate()


#Play mouse Hover sounds
func _on_settings_button_mouse_entered() -> void:
	_PlayMouseEnteredSound()
func _on_main_menu_button_mouse_entered() -> void:
	_PlayMouseEnteredSound()
func _on_yes_button_mouse_entered() -> void:
	_PlayMouseEnteredSound()
func _on_no_button_mouse_entered() -> void:
	_PlayMouseEnteredSound()
func _on_quit_button_mouse_entered() -> void:
	_PlayMouseEnteredSound()
