extends Node


@onready var scene_blocks: Node = $"../../SceneBlocks"
@onready var move_block: Node = $"../Blocks/Move Block"


var buildMode : bool


func _ready() -> void:
	buildMode = true


func _on_build_mode_button_pressed() -> void:
	buildMode = true
	for child in scene_blocks.get_children():
		child.visible = true


func _on_edit_mode_button_pressed() -> void:
	buildMode = false
	
	for child in scene_blocks.get_children():
		if not child.is_in_group("EditBlock"):
			child.visible = false
