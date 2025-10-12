extends Area2D
class_name AreaTrigger #YEAH I SUCK AT MAKING NAMES



@export_group("data")
@export var TRIGGER_DATA         : Dictionary[Node2D, AreaTriggerResource]
@export var NORMAL_COLOR         : Color = Color(1,1,1,1)
@export var HIDDEN_COLOR         : Color = Color(1,1,1,0)

@export_group("Graphics")
@export var ENTER_PROFILE        : GraphicsProfile = load("res://Assets/GraphicsProfile/default_graphics_profile.tres")
@export var EXIT_PROFILE         : GraphicsProfile = load("res://Assets/GraphicsProfile/default_graphics_profile.tres")
@export var ENTER_IN_RIGHT        : bool
@export var ROTATE90_RIGHT       : bool

func _enter_tree() -> void:
	body_exited.connect(_on_body_exited)


func _on_body_exited(player: Node2D) -> void:
	_update_hidden_areas(player)
	_update_graphics(player)

# DONT TOUCH THESE
func _update_hidden_areas(player: Node2D) -> void:
	if player.is_in_group("Player"):
		for i in TRIGGER_DATA.keys():
			var image            = i
			var exiting_in_right = TRIGGER_DATA[i].EXITING_IN_RIGHT
			var fade_time        = TRIGGER_DATA[i].FADE_TIME
			var up_down          = TRIGGER_DATA[i].ROTATE_RIGHT_90
			var tween = get_tree().create_tween()

			var diffrence : float
			if up_down: diffrence = (player.global_position.y - global_position.x) * -1
			else: diffrence = player.global_position.x - global_position.x

			if diffrence < 0:
				if exiting_in_right: tween.tween_property(image, "modulate", HIDDEN_COLOR, fade_time)
				else: tween.tween_property(image, "modulate", NORMAL_COLOR, fade_time)
			else:
				if not exiting_in_right: tween.tween_property(image, "modulate", HIDDEN_COLOR, fade_time)
				else: tween.tween_property(image, "modulate", NORMAL_COLOR, fade_time)


func _update_graphics(player: Node2D) -> void:
	var diffrence : float
	if ROTATE90_RIGHT: diffrence = (player.global_position.y - global_position.x) * -1
	else: diffrence = player.global_position.x - global_position.x

	if diffrence < 0:
		if not ENTER_IN_RIGHT: _set_profile(EXIT_PROFILE)
		else:  _set_profile(ENTER_PROFILE)
	else:
		if not ENTER_IN_RIGHT: _set_profile(EXIT_PROFILE)
		else: _set_profile(ENTER_PROFILE)



func _set_profile(profile: GraphicsProfile) -> void:
	GameManager.night_mode.emit(profile.NIGHT_MODE)
	GameManager.player_light_toggle.emit(profile.PLAYER_LIGHT)
	GameManager.player_iris_update.emit(profile.PLAYER_CIRCLE, profile.PLAYER_CIRCLE_RADIUS)
