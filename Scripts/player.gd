class_name Player extends CharacterBody2D

@export var SPEED           := 250.0
@export var JUMP_VELOCITY   := 400.0
@export var MAX_HEALTH      := 5
@export var GRAVITY         := 19.6

@onready var graphics: AnimatedSprite2D = $Graphics

var dir                     := 0.0
var dash_velocity           := 0.0
var jump_countdown          := false

func _physics_process(_delta: float) -> void:
	_handle_jump()
	_handle_movement()
	_play_animations()
	move_and_slide()


func _handle_movement() -> void:
	var direction           := Input.get_axis("left", "right")
	
	if direction:
		dir = direction
		velocity.x = direction * (SPEED + dash_velocity)
		_update_orientation(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _handle_jump() -> void:
	if not is_on_floor(): velocity += Vector2(0, GRAVITY)
	elif Input.is_action_just_pressed("jump"):
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
	else:  graphics.play("run")


func take_damage() -> void:
	global_position = GameManager.latest_check_point
