extends Button

@onready var prompt = $"../Are you sure Prompt"

func _on_pressed() -> void:
	prompt.visible = true

func _on_yes_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_no_button_pressed() -> void:
	prompt.visible = false
