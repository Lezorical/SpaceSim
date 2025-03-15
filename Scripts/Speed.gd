extends Label

@onready var player: CharacterBody3D = $"../.."

@onready var speed: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(0.01).timeout
	speed.text = str("SPEED: ", int(player.velocity.z))
