extends Node

@export var MUSIC: AudioStream

func _ready() -> void:
	GlobalAudioManager.play_music(MUSIC)
	GameManager.win_sequence.connect(win_game)

func win_game() -> void:
	$WinAnimationPlayer.play("win")

func _on_quit_game_pressed() -> void:
	pass # Replace with function body.
