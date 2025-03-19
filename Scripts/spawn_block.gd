extends Node

@export var spawnPath : Node


##BLOCKS#################################################################################################

#Engines
@export var EngineBlock = preload("uid://dnh7ojgwcax0b") #Engine Block

#Blocks
@onready var halfBlock : PackedScene =  preload("uid://d4dteludr3m0s") # cube 0.5x0.5
@onready var originBlock : PackedScene =  preload("uid://dfbagtif6a1hd") # Origin Block

#Misc
@export var ChairBlock = preload("uid://cuw5gyu2lvy4u") #Engine Block
@export var PlayerSpawnSpot = preload("uid://d3u0ahmfu0xvp") #Engine Block

##BLOCKS#################################################################################################


func spawnAndPlace(instance):
	spawnPath.add_child(instance)
	instance.global_position = Vector3(0,0,0)
	#instance.freeze = true


func _on_spawn_button_pressed() -> void:
	var instance = halfBlock.instantiate()
	instance.name = str("halfBlock", " ", instance.get_instance_id())
	spawnAndPlace(instance)


func _on_origin_cube_pressed() -> void:
	var instance = originBlock.instantiate()
	instance.name = str("originBlock", " ", instance.get_instance_id())
	spawnAndPlace(instance)


func _on_engine_block_pressed() -> void:
	var instance = EngineBlock.instantiate()
	instance.name = str("EngineBlock", " ", instance.get_instance_id())
	spawnAndPlace(instance)


func _on_chair_block_2_pressed() -> void:
	var instance = ChairBlock.instantiate()
	instance.name = str("ChairBlock", " ", instance.get_instance_id())
	spawnAndPlace(instance)


func _on_player_spawn_spot_pressed() -> void:
	var instance = PlayerSpawnSpot.instantiate()
	instance.name = str("PlayerSpawnBlock", " ", instance.get_instance_id())
	spawnAndPlace(instance)
