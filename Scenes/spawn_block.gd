extends Node

@onready var halfBlock : PackedScene =  preload("uid://d4dteludr3m0s") # cube 0.5x0.5
@onready var originBlock : PackedScene =  preload("uid://dfbagtif6a1hd") # Origin Block
@export var spawnPath : Node


func _on_spawn_button_pressed() -> void:
	var instance = halfBlock.instantiate()
	instance.name = str("halfBlock")
	spawnPath.add_child(instance)
	instance.global_position = Vector3(0,0,0)
	
func _on_origin_cube_pressed() -> void:
	var instance = originBlock.instantiate()
	instance.name = str("originBlock")
	spawnPath.add_child(instance)
	instance.global_position = Vector3(0,0,0)
