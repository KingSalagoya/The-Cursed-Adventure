extends Node

signal sacrifice_skill(name: String)
signal toggle_hud(toggle: bool)
signal start_game ()
signal win_sequence ()

var best_time              := 0
var current_time           := 0
var player_name            := ""

var latest_check_point     := Vector2.ZERO
var player                 : Player

const save_path: String = "user://userdata.json"


func _enter_tree() -> void:
	load_game()

func _ready() -> void:
	RenderingServer.global_shader_parameter_set("VIEWPORT_SIZE", get_viewport().size)
	print_debug(get_viewport().size)
	print("hellow")

func save_game() -> void:
	var contents_to_save = {
	"player_name": player_name,
	"best_time": best_time
	}

	var file = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, "dev_snapshot")
	file.store_var(contents_to_save.duplicate())
	file.close()


func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, "dev_snapshot")
		var data: Dictionary = file.get_var()
		file.close()
			
		var save_data = data.duplicate()
		
		player_name = save_data.player_name
		best_time = int(save_data.best_time)


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
