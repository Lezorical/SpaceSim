extends RayCast3D

var collider = $".".get_collider()

@onready var iscolliding: Label = $"../../Debug Info/ISCOLLIDING"
@onready var interact_sprite: Sprite2D = $"../../Debug Info/InteractSprite"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	await get_tree().create_timer(0.01).timeout
	
	if is_colliding():
		
		var collider = get_collider()
		
		if collider.is_in_group("interactable"):
			iscolliding.text = str("COLLIDING: ", is_colliding())
			interact_sprite.visible = true
			
			if collider.is_in_group("spawnBlock"):
				if Input.is_action_just_pressed("interact"):
					MessageBus.Spawn_Vehicle_Button.emit()
			
			if collider.is_in_group("builderMachine"):
				if Input.is_action_just_pressed("interact"):
					get_tree().change_scene_to_file("res://Scenes/vehicle_builder.tscn")
			
		else:
			interact_sprite.hide()
	else:
		iscolliding.text = str("COLLIDING: ", is_colliding())
		interact_sprite.hide()
