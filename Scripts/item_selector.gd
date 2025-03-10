extends Node

@onready var camera = $"../../Camera Holder/Camera"
@onready var cube_scene = preload("uid://d4dteludr3m0s")


func _ready() -> void:
	pass

func _on_item_list_item_activated(index: int) -> void:
	var instance = cube_scene.instantiate()
	add_child(instance)

	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)

	var plane_distance = 10.0
	var plane_origin = camera.global_transform.origin + camera.global_transform.basis.z * -plane_distance
	var plane_normal = -camera.global_transform.basis.z

	var intersection_point = get_plane_intersection(ray_origin, ray_direction, plane_origin, plane_normal)

	# Check for Vector3.ZERO *before* using the result!
	if intersection_point != Vector3.ZERO:
		instance.global_position = intersection_point
	else:
		#Handle when there is no intersection
		instance.global_position = camera.global_transform.origin + camera.global_transform.basis.z * -10


func get_plane_intersection(ray_origin: Vector3, ray_direction: Vector3, plane_origin: Vector3, plane_normal: Vector3) -> Vector3:
	var denominator = plane_normal.dot(ray_direction)
	if abs(denominator) > 1e-6:
		var t = (plane_origin - ray_origin).dot(plane_normal) / denominator
		if t >= 0:
			return ray_origin + ray_direction * t
	return Vector3.ZERO  # Return Vector3.ZERO instead of null
