extends Node

@export var MUSIC: AudioStream

@onready var speedrun_timer: Timer = $UI/HUD/Main/MarginContainer/Timer/Timer
@onready var timer_label: Label = $UI/HUD/Main/MarginContainer/Timer/TimerContainer/TimerLabel



func _ready() -> void:
	GlobalAudioManager.play_music(MUSIC)
	GameManager.win_sequence.connect(win_game)
	GameManager.start_game.connect(start_game)

func start_game() -> void:
	speedrun_timer.start()


func win_game() -> void:
	$WinAnimationPlayer.play("win")
	if GameManager.current_time < GameManager.best_time:
		GameManager.current_time = GameManager.best_time
		GameManager.save_game()
		SilentWolf.Scores.save_score(GameManager.player_name, timer_label.text)


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_timer_timeout() -> void:
	GameManager.current_time += 1
	var m = int(GameManager.current_time / 60.0)
	var s = GameManager.current_time - m * 60
	timer_label.text = str('%02d:%02d' % [m , s])
