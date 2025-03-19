extends Node

@export var CameraReference : Camera3D

var RAY_LENGTH = 2000

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
