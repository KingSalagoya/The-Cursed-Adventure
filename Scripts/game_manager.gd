extends Node

signal sacrifice_skill(name: String)
signal toggle_hud(toggle: bool)
signal win_sequence()

var latest_check_point     := Vector2.ZERO
var player: Player
var best_time

func _ready() -> void:
	RenderingServer.global_shader_parameter_set("VIEWPORT_SIZE", get_viewport().size)
	print_debug(get_viewport().size)
	print("hellow")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func update_latest_checkpoint(pos: Vector2) -> void:
	print("CHECKPOINT" + str(pos))
	latest_check_point = pos

func _toggle_hud(toggle: bool) -> void:
	toggle_hud.emit(toggle)

func win_game() -> void:
	_toggle_hud(true)
	win_sequence.emit()
