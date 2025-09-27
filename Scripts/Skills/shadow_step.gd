class_name ShadowStep extends Skills

@export var DASH_SPEED      := 1000.0
@export var DASH_COUNTDOWN  := 1.0

@onready var player: Player = $"../.."

var is_dashing              := false
var tween                   : Tween


func use() -> void:
	if not is_dashing and Input.is_action_just_pressed("shadow step"):
		is_dashing = true
		player.dash_velocity = DASH_SPEED
		if tween: tween.stop()
		tween = create_tween()
		tween.tween_property(player, "dash_velocity", 0, 0.2).set_ease(Tween.EASE_OUT)

		var timer = get_tree().create_timer(DASH_COUNTDOWN)
		timer.timeout.connect(timeout)


func timeout() -> void:
	is_dashing = false
