extends Camera3D

@onready var cube = $"../../Cube 0_5"
const RAY_LENGTH = 1000
@onready var camera = $"."
@export var scrollSensitivity = 0.5
var isDragging = false


@onready var cubeObject = preload("res://assets/Vehicle Builder/Blocks/cube_0_5x0_5.tscn")

var cube1

func _on_spawn_button_pressed() -> void:
	var instance = cubeObject.instantiate()
	get_tree().get_root().add_child(instance)
	instance.global_position = Vector3(0,0,0)
	cube1 = instance



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var gridSize = Vector3(0.5,0.5,0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_movment()
	rotation.x=clamp(rotation.x,-1,1)
	
	if isDragging:
		var mousepos = get_viewport().get_mouse_position() #Get mouse position 
		var origin = camera.project_ray_origin(mousepos) #project ray to surface of viewport
		var end = camera.project_ray_normal(mousepos) #fire ray and pick up position in 3d space of object
		var depth = origin.distance_to(cube1.global_position) #set raycast length to distance of object
		var final_position = origin + end * depth
		#cube1.global_position = final_position
		
		final_position.x = round(final_position.x / gridSize.x) * gridSize.x
		final_position.y = round(final_position.y / gridSize.y) * gridSize.y
		final_position.z = round(final_position.z / gridSize.z) * gridSize.z
		cube1.global_position = final_position
	

func ray_cast():
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	result = result.get("collider")
	return result


func _input(event):
	if event.is_action_pressed("leftClick") and camera.ray_cast() != null:
		isDragging = !isDragging

	if isDragging and camera.ray_cast() != null:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				var move_direction = (cube1.global_position - camera.global_position).normalized()
				cube1.global_position += move_direction * scrollSensitivity
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				var move_direction = (cube1.global_position - camera.global_position).normalized()
				cube1.global_position -= move_direction * scrollSensitivity
	
	
	
	var sensitivity = 0.005
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		rotate(Vector3.UP, -event.relative.x * sensitivity)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * sensitivity)
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	elif Input.is_action_just_released("rightclic"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	
	
func camera_movment():
	var direction1 = -global_transform.basis.z
	var direction2 = -global_transform.basis.x
	var velocity =.02
	direction1 = direction1.normalized()
	direction2 = direction2.normalized()
	
	if Input.is_action_pressed("sprint"):
		velocity = .1
	if Input.is_action_pressed("move_forward"):
		global_position+=direction1*velocity
	if Input.is_action_pressed("move_back"):
		global_position-=direction1*velocity
	if Input.is_action_pressed("move_left"):
		global_position+=direction2*velocity
	if Input.is_action_pressed("move_right"):
		global_position-=direction2*velocity
