class_name Shard
extends Area2D

func _enter_tree() -> void:
	body_entered.connect(_on_body_connected)

func _on_body_connected(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.shards += 1
		GameManager.update_shard_text()
		queue_free()
