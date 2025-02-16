extends RayCast3D

var collider = $".".get_collider()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	await get_tree().create_timer(0.01).timeout
	
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("interactable"):
			$"../../ISCOLLIDING".text = str("COLLIDING: ", is_colliding())
			$"../../InteractSprite".visible = true
			
	else:
		$"../../ISCOLLIDING".text = str("COLLIDING: ", is_colliding())
		$"../../InteractSprite".hide()
