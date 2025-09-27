class_name Player extends CharacterBody2D

@export var SPEED           := 100.0
@export var JUMP_VELOCITY   := 150.0
@export var MAX_HEALTH      := 5
@export var GRAVITY         := 9.8

@onready var graphics: Sprite2D = $Graphics

var dir                     := 0.0

func _physics_process(_delta: float) -> void:
	_handle_jump()
	_handle_movement()
	#_play_animations()
	move_and_slide()


func _handle_movement() -> void:
	var direction           := Input.get_axis("left", "right")
	velocity.x = direction * SPEED
	if direction:
		dir = direction
		_update_orientation(direction * -1)


func _handle_jump() -> void:
	if not is_on_floor(): velocity += Vector2(0, GRAVITY)
	elif Input.is_action_pressed("jump"): velocity.y = -JUMP_VELOCITY


func _update_orientation(dir: float) -> void:
	if dir < 0: graphics.flip_h = true
	else:  graphics.flip_h = false


func _play_animations() -> void:
	if velocity.x == 0:  graphics.play("idle", 0.5)
	else:  graphics.play("walk")
