extends Camera3D

const RAY_LENGTH = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_movment()
	rotation.x=clamp(rotation.x,-1,1)

func ray_cast():
	var space_state = get_world_3d().direct_space_state
	var cam = $"."
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	result = result.get("collider")
	return result



func _input(event):
	
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
