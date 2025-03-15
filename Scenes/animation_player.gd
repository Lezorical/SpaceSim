extends AnimationPlayer
@onready var button_click: AudioStreamPlayer3D = $"../../Sound/Button Click"

func _ready() -> void:
	MessageBus.Spawn_Vehicle_Button.connect(buttonAction)

func buttonAction():
	self.play("VehicleSpawnerButtonPushAnimation")
	button_click.play()
	
	var craft_name : String = "arrow"
	
	var block_placement = ConfigFile.new()
	block_placement.load("res://saves/" + craft_name + ".cfg")
	
	for section in block_placement.get_sections():
		var scene_path = block_placement.get_value(section, "BlockType")
		var position = block_placement.get_value(section, "BlockPosition")
		
		var loaded_scene = load(scene_path)
		var instance = loaded_scene.instantiate()
		
		#instance.name = section # Restore the original name. VERY IMPORTANT!
		instance.global_position = position
		$".".add_child(instance)
