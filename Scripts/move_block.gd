extends Node

@export_category("Camera Settings")
@export var CameraReference : Camera3D
@export var scrollSensitivity = 0.5
@export var RAY_LENGTH = 2000
@onready var spawn_block: Node = $"../Spawn Block"
@onready var delete_block_sound: AudioStreamPlayer = $"../../../Sound Manager/Delete Block Sound"



#Dragging or not
var isDragging : bool = false

@onready var block_instance : RigidBody3D
@onready var scene_blocks : Node = $"../../../SceneBlocks"

var gridSize = Vector3(0.5,0.5,0.5)

func delete_current_block(instance):
	delete_block_sound.play()
	if isDragging:
		isDragging = !isDragging
		instance.queue_free()


func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("deleteBlock") and ray_cast() != null:
		block_instance = scene_blocks.find_child(_get_object_in_mouse(), true, false)
		delete_current_block(block_instance)
	
	if event.is_action_pressed("leftClick") and ray_cast() != null:
		block_instance = scene_blocks.find_child(_get_object_in_mouse(), true, false)
		isDragging = !isDragging
		
		if not isDragging and event.is_action_pressed("leftClick"):
			
			
			spawn_block.spawnAndPlaceAfterPlace(block_instance.global_position, block_instance )
			print(scene_blocks.find_child(_get_object_in_mouse(), true, false))
			isDragging = !isDragging
			
		
		
		_translate_block()
		
		
	if event is InputEventMouseButton and isDragging:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			var move_direction = (block_instance.global_position - CameraReference.global_position).normalized()
			block_instance.global_position += move_direction * scrollSensitivity
		elif event.button_index == +MOUSE_BUTTON_WHEEL_DOWN:
			var move_direction = (block_instance.global_position - CameraReference.global_position).normalized()
			block_instance.global_position -= move_direction * scrollSensitivity


func _process(delta: float) -> void:
	if isDragging:
		_translate_block()

func _translate_block():

		var mousepos = get_viewport().get_mouse_position() #Get mouse position 
		var origin = CameraReference.project_ray_origin(mousepos) #project ray to surface of viewport
		var end = CameraReference.project_ray_normal(mousepos) #fire ray and pick up position in 3d space of object
		var depth = origin.distance_to(block_instance.global_position) #set raycast length to distance of object
		var final_position = origin + end * depth
		block_instance.global_position = final_position
		
		final_position.x = round(final_position.x / gridSize.x) * gridSize.x
		final_position.y = round(final_position.y / gridSize.y) * gridSize.y
		final_position.z = round(final_position.z / gridSize.z) * gridSize.z
		block_instance.global_position = final_position



func ray_cast():
	var space_state = CameraReference.get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = CameraReference.project_ray_origin(mousepos)
	var end = origin + CameraReference.project_ray_normal(mousepos) * RAY_LENGTH
	
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	result = result.get("collider")
	return result



func _get_object_in_mouse():
	var space_state = CameraReference.get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = CameraReference.project_ray_origin(mousepos)
	var end = origin + CameraReference.project_ray_normal(mousepos) * RAY_LENGTH
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.get("collider")
		return collider.name
	return null
