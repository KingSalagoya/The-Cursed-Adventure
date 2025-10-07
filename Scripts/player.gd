class_name Player extends CharacterBody2D

@export var SPEED           := 250.0
@export var JUMP_VELOCITY   := 400.0
@export var MAX_HEALTH      := 5
@export var GRAVITY         := 19.6

@onready var graphics: AnimatedSprite2D = $Graphics

@onready var jump_sfx: AudioStreamPlayer = $Sounds/Jump
@onready var spike_hurt_sfx: AudioStreamPlayer = $Sounds/SpikeSound
@onready var footstep_sfx: AudioStreamPlayer = $Sounds/footstep
@onready var dash_sfx: AudioStreamPlayer = $Sounds/Swooosh


var dir                     := 0.0
var look_dir                := 1.0
var dash_velocity           := 0.0
var jump_countdown          := false
var hud_toggle              := false

enum STATES {RUNNING, JUMPING, DASHING, IDLE, FALLING}
var PLAYER_STATE: STATES

func _enter_tree() -> void:
	GameManager.player = self

func _ready() -> void:
	GameManager.toggle_hud.connect(toggle_menu)


func _physics_process(_delta: float) -> void:
	_handle_playerstate()
	_handle_playerstate_effects()
	_handle_jump()
	_handle_movement()
	move_and_slide()


func _handle_playerstate() -> void:
	if dash_velocity != 0:
		PLAYER_STATE     = STATES.DASHING

	elif is_on_floor():
		if velocity.x == 0:
			PLAYER_STATE = STATES.IDLE
		else:
			PLAYER_STATE = STATES.RUNNING

	elif velocity.y < 0:
		PLAYER_STATE     = STATES.JUMPING

	elif velocity.y > 0:
		PLAYER_STATE     = STATES.FALLING


func _handle_playerstate_effects() -> void:
	match PLAYER_STATE:
		STATES.RUNNING:
			if not footstep_sfx.playing: footstep_sfx.play()
			graphics.play("run", 2.0)

		STATES.JUMPING:
			if not jump_sfx.playing: jump_sfx.play()
			graphics.play("jump")

		STATES.FALLING:
			graphics.play("fall")

		STATES.IDLE:
			graphics.play("idle", 0.5)

		STATES.DASHING:
			graphics.play("dash", 3.5)
			if not dash_sfx.playing: dash_sfx.play(0.05)
			


func toggle_menu(toggle: bool) -> void:
	hud_toggle = toggle


func _handle_movement() -> void:
	if hud_toggle: return
	var direction           := Input.get_axis("left", "right")
	
	if dash_velocity != 0:
		velocity.x = look_dir * (SPEED + dash_velocity)
	elif direction:
		dir = direction
		velocity.x = direction * (SPEED)
		_update_orientation(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _handle_jump() -> void:
	if not is_on_floor():
		if dash_velocity == 0.0:
			velocity += Vector2(0, GRAVITY)
		else:
			velocity.y = 0.0
	elif Input.is_action_pressed("jump") and not hud_toggle:
		jump_countdown = true
		jump()
		var timer = get_tree().create_timer(0.1)
		await(timer.timeout)
		jump_countdown = false


func jump() -> void:
	PLAYER_STATE = STATES.JUMPING
	velocity.y = -JUMP_VELOCITY

func _update_orientation(_dir: float) -> void:
	if _dir < 0:
		graphics.flip_h = true
		look_dir = -1
	else:
		graphics.flip_h = false
		look_dir = 1


func take_damage() -> void:
	global_position = GameManager.latest_check_point
	$AdvancedGraphics.play("HurtAnim")
	spike_hurt_sfx.play()
