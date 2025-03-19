extends Node

@onready var first_person_camera: Camera3D = $"../First Person Camera"
@onready var third_person_camera: Camera3D = $"../Third Person Camera"

var is_fpv : bool = true


func _ready() -> void:
	first_person_camera.make_current()


func changeCamera():
	if is_fpv:
		first_person_camera.make_current()
	else:
		third_person_camera.make_current()


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F5):
		changeCamera()
		is_fpv = !is_fpv
