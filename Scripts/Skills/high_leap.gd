class_name HighLeap extends Skills

@onready var player: Player = $"../.."
@onready var jump: AudioStreamPlayer = $"../../Sounds/Jump"

var jumped                  := false

func use() -> void:
	if Input.is_action_just_pressed("jump") and not player.is_on_floor() and not jumped and not player.jump_countdown:
		jumped = true
		player.velocity.y = -player.JUMP_VELOCITY
		jump.play()
	if player.is_on_floor():
		jumped = false
