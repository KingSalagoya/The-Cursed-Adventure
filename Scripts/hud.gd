extends CanvasLayer

func _ready() -> void:
	visible = true
	GameManager.toggle_hud.emit(true)


func _on_start_game_pressed() -> void:
	GameManager.toggle_hud.emit(false)
	visible = false


func _on_quit_game_pressed() -> void:
	get_tree().quit()
