class_name ShadowStep extends Skills

@export var PLAYER          := Player
@export var DASH_SPEED      := 500.0
@export var Dash_COUNTDOWN  := 3.0

var is_dashing              := false

func use() -> void:
	if not is_dashing:
		PLAYER.velocity.x = DASH_SPEED * PLAYER.dir
	pass
