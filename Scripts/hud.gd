extends CanvasLayer

func _ready() -> void:
	visible = true
	GameManager.toggle_hud.emit(true)
	$"Enter Name".visible = true

#Main Menu

func _on_start_game_pressed() -> void:
	if GameManager.player_name != "" :
		GameManager.toggle_hud.emit(false)
		visible = false
	else:
		$MainMenu.visible = false
		$"Enter Name".visible = true

func _on_leader_board_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()

#Enter Name


func _on_start_game_with_name_pressed() -> void:
	if GameManager.player_name != "" :
		GameManager.player_name = $"MainMenu/Enter Name/LineEdit".text
		GameManager.toggle_hud.emit(false)
		visible = false

func _on_back_with_name_pressed() -> void:
	visible = true
	GameManager.toggle_hud.emit(true)
	
