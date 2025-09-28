class_name Player extends CharacterBody2D

@export var SPEED           := 250.0
@export var JUMP_VELOCITY   := 400.0
@export var MAX_HEALTH      := 5
@export var GRAVITY         := 19.6

@onready var graphics: AnimatedSprite2D = $Graphics
@onready var dust: AnimatedSprite2D = $Marker2D/dust

@onready var jump: AudioStreamPlayer = $Sounds/Jump
@onready var spike_sound: AudioStreamPlayer = $Sounds/SpikeSound
@onready var footstep: AudioStreamPlayer = $Sounds/footstep


var dir                     := 0.0
var dash_velocity           := 0.0
var jump_countdown          := false
var hud_toggle              := false

func _physics_process(_delta: float) -> void:
	#toggle_menu()
	_handle_jump()
	_handle_movement()
	_play_animations()
	move_and_slide()

func toggle_menu() -> void:
	if Input.is_action_just_pressed("open_hud"):
		hud_toggle = !hud_toggle
		GameManager._toggle_hud(hud_toggle)


func _handle_movement() -> void:
	if hud_toggle: return
	var direction           := Input.get_axis("left", "right")
	
	if direction:
		dir = direction
		velocity.x = direction * (SPEED + dash_velocity)
		_update_orientation(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _handle_jump() -> void:
	if not is_on_floor(): velocity += Vector2(0, GRAVITY)
	elif Input.is_action_just_pressed("jump") and not hud_toggle:
		jump.play()
		jump_countdown = true
		velocity.y = -JUMP_VELOCITY
		var timer = get_tree().create_timer(0.1)
		await(timer.timeout)
		jump_countdown = false


func _update_orientation(_dir: float) -> void:
	if _dir < 0: graphics.flip_h = true
	else:  graphics.flip_h = false


func _play_animations() -> void:
	if velocity.x == 0:  graphics.play("idle", 0.5)
	else:
		graphics.play("run")
		if is_on_floor():
			if footstep.playing: return
			footstep.play()


func take_damage() -> void:
	global_position = GameManager.latest_check_point
	$Hurt.play("HurtAnim")
	spike_sound.play()
