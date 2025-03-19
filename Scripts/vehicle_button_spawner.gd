extends Node

func _on_animation_player_call_spawner() -> void:
	spawn_vehicle()


func spawn_vehicle():
	var craft_name : String = "spaceship"
	
	var block_placement = ConfigFile.new()
	block_placement.load("res://saves/" + craft_name + ".cfg")
	
	var SpaceCraftParent : Area3D = Area3D.new()
	SpaceCraftParent.name = craft_name
	SpaceCraftParent.position = Vector3(-20,-1.5,0) #<-- Location above platform -20,8,-50 <--Middle location of Scaffold
	get_node("/root/Main").add_child(SpaceCraftParent)
	
	for section in block_placement.get_sections():
		var scene_path = block_placement.get_value(section, "BlockType")
		var position = block_placement.get_value(section, "BlockPosition")
		
		var loaded_scene = load(scene_path)
		var instance = loaded_scene.instantiate()
		
		instance.global_position = position
		SpaceCraftParent.add_child(instance)
		instance.freeze = 0
		print("Spawned ", instance.name, " at position ", instance.global_position)
