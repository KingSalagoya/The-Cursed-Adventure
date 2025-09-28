extends Node

@export var MUSIC: AudioStream

func _ready() -> void:
	GlobalAudioManager.play_music(MUSIC)
