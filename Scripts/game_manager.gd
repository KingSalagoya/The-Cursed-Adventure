extends Node

signal teleport_player
signal change_scenes

func _ready() -> void:
	print("hellow")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
