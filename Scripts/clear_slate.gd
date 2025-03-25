extends Node

@onready var scene_blocks: Node = $"../../SceneBlocks"
@onready var delete_block_sound: AudioStreamPlayer = $"../../Sound Manager/Delete Block Sound"


func _clear_slate():
	delete_block_sound.play()
	for child in scene_blocks.get_children():
			child.queue_free()
