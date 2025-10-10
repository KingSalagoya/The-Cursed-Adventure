extends Area2D

func _ready() -> void:
	collision_layer = 0
	collision_mask = 2
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	GameManager.win_game()
