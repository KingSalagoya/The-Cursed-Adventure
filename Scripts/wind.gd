extends TileMapLayer

var player            : Player

func _ready() -> void:
	player = GameManager.player
	$"../WindTimer".timeout.connect(_refresh_player_pos)

func _refresh_player_pos() -> void:
	#if player: material.set_shader_param("player_pos", player.global_position)
	#else: player = GameManager.player
	pass
