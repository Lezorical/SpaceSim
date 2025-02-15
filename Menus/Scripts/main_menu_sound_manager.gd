extends Node

@onready var background_music_1 = $backgroundMusic1
@onready var background_music_2 = $backgroundMusic2
@onready var background_music_3 = $backgroundMusic3

var current_playing : int = 0


func _on_audio_stream_finished() -> void:
	
	await get_tree().create_timer(10.0).timeout
	
	# Play the other track.
	if current_playing == 0:
		background_music_3.play()
		current_playing = 1
	else:
		background_music_1.play()
		current_playing = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	randomize()
	var first_to_play = randi_range(0,1)
	
	if first_to_play == 0:
		background_music_1.play()
		current_playing = 0
	else:
		background_music_3.play()
		current_playing = 1
	
	background_music_1.finished.connect(_on_audio_stream_finished)
	background_music_2.finished.connect(_on_audio_stream_finished)
