extends Node

@export var MUSIC: AudioStream

func _ready() -> void:
	GlobalAudioManager.play_music(MUSIC)


func _on_quit_game_pressed() -> void:
	pass # Replace with function body.
