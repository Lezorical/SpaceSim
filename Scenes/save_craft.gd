extends Node

@onready var vehicle_name_editor: LineEdit = $"../../GUI/Building Screen/Main/Vehicle Name/Vehicle Name Editor"
@onready var scene_blocks: Node = $"../../SceneBlocks"

func _on_save_pressed() -> void:
	var block_placement = ConfigFile.new()
	
	var craft_name : String = str(vehicle_name_editor.text)
	
	for child in scene_blocks.get_children():
		
		var name = child.name
		var position = child.global_position
		var scene_path = child.get_scene_file_path()
		
		block_placement.set_value(str(name), "BlockType", scene_path)
		block_placement.set_value(str(name), "BlockPosition", position)
		
	block_placement.save("res://saves/" + craft_name + ".cfg")
