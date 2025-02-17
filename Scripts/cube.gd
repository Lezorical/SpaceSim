extends MeshInstance3D

@onready var camera= $"../../Camera Holder/MeshCamera"
@onready var area= $".."
@export var scroll_speed: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
		
	if camera.ray_cast() != null and Input.is_action_pressed("leftClick"):
		var mousepos = get_viewport().get_mouse_position()
		var origin = camera.project_ray_origin(mousepos)
		var end =camera.project_ray_normal(mousepos)
		var depth= origin.distance_to(area.global_position)
		var final_position= origin + end * depth
		area.global_position=final_position
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			var move_direction = (area.global_position - camera.global_position).normalized()
			area.global_position += move_direction * scroll_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			var move_direction = (area.global_position - camera.global_position).normalized()
			area.global_position -= move_direction * scroll_speed
