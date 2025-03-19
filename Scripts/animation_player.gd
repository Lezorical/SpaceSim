extends AnimationPlayer
@onready var button_click: AudioStreamPlayer3D = $"../../Button Click Sound"

signal call_spawner


func _ready() -> void:
	MessageBus.Spawn_Vehicle_Button.connect(buttonAction)
	

func buttonAction():
	self.play("VehicleSpawnerButtonPushAnimation")
	button_click.play()
	emit_signal("call_spawner")
	
