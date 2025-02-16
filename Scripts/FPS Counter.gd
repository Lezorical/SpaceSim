extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(1).timeout
	$".".text = str("FPS: ", Engine.get_frames_per_second())
	
