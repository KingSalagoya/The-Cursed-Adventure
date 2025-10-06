extends Node2D

var player                  : Player
var speed                   := 10

func _ready() -> void:
	player = GameManager.player

func _physics_process(delta) -> void:
	if player:
		var direction       := (player.global_position-global_position).normalized()
		position += direction * speed * delta
