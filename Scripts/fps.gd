extends Label

func _process(delta: float) -> void:
	await get_tree().create_timer(1).timeout #Wait 1 second
	self.text = str("FPS: ", Engine.get_frames_per_second())
