extends Node2D

@export var player : Player

func _ready() -> void:
	global_position = player.global_position

func _physics_process(_delta: float) -> void:
	global_position = player.global_position
