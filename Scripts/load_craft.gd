extends Node

@onready var vehicle_name_editor: LineEdit = $"../../GUI/Building Screen/Main/Vehicle Name/Vehicle Name Editor"
@onready var clear_slate: Node = $"../Clear Slate"
@onready var scene_blocks: Node = $"../../SceneBlocks"


func _on_load_pressed() -> void:
	clear_slate._clear_slate()
	
	var craft_name : String = str(vehicle_name_editor.text)
	
	var block_placement = ConfigFile.new()
	block_placement.load("res://saves/" + craft_name + ".cfg")
	
	for section in block_placement.get_sections():
		var scene_path = block_placement.get_value(section, "BlockType")
		var position = block_placement.get_value(section, "BlockPosition")
		
		var loaded_scene = load(scene_path)
		var instance = loaded_scene.instantiate()
		
		instance.global_position = position
		scene_blocks.add_child(instance)
		
