extends Node

signal sacrifice_skill(name: String)

var latest_check_point     := Vector2.ZERO

func _ready() -> void:
	print("hellow")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func update_latest_checkpoint(pos: Vector2) -> void:
	latest_check_point = pos
