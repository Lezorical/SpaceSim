extends Node

@onready var move_block: Node = $"../Move Block"


func _input(event: InputEvent) -> void:

	if event.is_action_pressed("rotateq"):
		print(move_block.isDragging)
	if event.is_action_pressed("rotatee"):
		pass

func moveitYEAHH(direction):
	pass
