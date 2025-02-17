extends CharacterBody3D


@export_group("Character Movement Settings")
@export var max_speed : float = 4.0
@export var braking : float = 20.0
@export var jump_force : float = 5.0
@export var gravity_modifyer : float = 1.5
@export var max_run_speed : float = 6.0


var is_running : bool = false

@export_category("Mouse Sensitivity")
@export var look_sensitivity : float = 0.005
var camera_look_input : Vector2

@onready var camera = $Camera3D
@onready var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") * gravity_modifyer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	var move_input = Input.get_vector("move_left","move_right","move_forward","move_back")
	
	var move_dir = (transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
	
	is_running = Input.is_action_pressed("sprint")
	
	var target_speed = max_speed
	
	if is_running:
		target_speed = max_run_speed
	
	velocity.x = move_dir.x * target_speed
	velocity.z = move_dir.z * target_speed
	
	rotate_y(-camera_look_input.x * look_sensitivity)
	camera.rotate_x(-camera_look_input.y * look_sensitivity)
	
	camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
	
	camera_look_input = Vector2.ZERO
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_look_input = event.relative
	
	
	
	
