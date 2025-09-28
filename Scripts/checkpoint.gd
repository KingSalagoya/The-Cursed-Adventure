extends Area2D
class_name CheckPoint

func _enter_tree() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body) -> void:
	print(str(_body))
	GameManager.update_latest_checkpoint(_body.global_position)
