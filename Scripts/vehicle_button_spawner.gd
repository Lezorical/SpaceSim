extends Node

@onready var player : PackedScene = load("res://Scenes/player.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotateq"):
		SpaceCraftParent.apply_impulse(Vector3(0,0,0), Vector3(10,1,0))
		SpaceCraftParent.apply_torque_impulse(Vector3(1,0,0))
	if event.is_action_pressed("rotatee"):
		#SpaceCraftParent.apply_central_impulse(Vector3(1,0,0))
		pass
	

func _on_animation_player_call_spawner() -> void:
	spawn_vehicle()

var SpaceCraftParent : RigidBody3D = RigidBody3D.new()
func spawn_vehicle():
	var craft_name : String = "space"
	
	var block_placement = ConfigFile.new()
	block_placement.load("res://saves/" + craft_name + ".cfg")




	SpaceCraftParent.name = craft_name
	SpaceCraftParent.gravity_scale = 0
	SpaceCraftParent.linear_velocity = Vector3(0,0.01,0)
	SpaceCraftParent.mass = 10
	
	##PLAYER INSTANCE##
	var playerInstance = player.instantiate()
	SpaceCraftParent.add_child(playerInstance)
	playerInstance.global_position = Vector3(0,5,0)
	
	
	SpaceCraftParent.position = Vector3(-20,8,-50) #<-- Location above platform -20,8,-50 <--Middle location of Scaffold
	get_node("/root/Main").add_child(SpaceCraftParent)
	#get_node("/root/Main/spaceship").add_child(SpaceCraftParentMesh)
	
	for section in block_placement.get_sections():
		var scene_path = block_placement.get_value(section, "BlockType")
		var position = block_placement.get_value(section, "BlockPosition")
		
		var loaded_scene = load(scene_path)
		var instance = loaded_scene.instantiate()
		
		instance.global_position = position
		SpaceCraftParent.add_child(instance)
		instance.freeze = 1
		print("Spawned ", instance.name, " at position ", instance.global_position)
