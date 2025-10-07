extends CanvasLayer

@onready var player_name: LineEdit = $MainMenu/VBoxContainer/MarginContainer/VBoxContainer2/NameInput


func _ready() -> void:
	player_name.text = GameManager.player_name
	visible = true
	GameManager.toggle_hud.emit(true)
#	$"Enter Name".visible = true

func _on_start_game_pressed() -> void:
	if player_name.text != "" :
		GameManager.toggle_hud.emit(false)
		GameManager.player_name = player_name.text
		GameManager.save_game()
		GameManager.start_game.emit()
		visible = false
	#	$"Enter Name".visible = true

func _on_leader_board_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
	
