extends Node

@export var MUSIC: AudioStream
@onready var timer: Timer = $UI/HUD/Main/MarginContainer/Control/Timer/Timer
@onready var timer_label: Label = $UI/HUD/Main/MarginContainer/Timer/TimerLabel
var total_time_in_secs : int = 0

func _ready() -> void:
	GlobalAudioManager.play_music(MUSIC)
	GameManager.win_sequence.connect(win_game)
	$UI/HUD/Main/MarginContainer/Timer/Timer.start()

func win_game() -> void:
	$WinAnimationPlayer.play("win")
	GameManager.best_time = timer_label.text
	GameManager.score = GameManager.best_time
	SilentWolf.Scores.save_score(GameManager.player_name, GameManager.score)

func _on_quit_game_pressed() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	total_time_in_secs += 1
	var m = int(total_time_in_secs / 60.0)
	var s = total_time_in_secs - m * 60
	timer_label.text = str('%02d:%02d' % [m , s])
