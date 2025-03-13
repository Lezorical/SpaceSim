extends Node

@onready var scene_blocks: Node = $"../../SceneBlocks"

func _clear_slate():
	for child in scene_blocks.get_children():
			child.queue_free()
