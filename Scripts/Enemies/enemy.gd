extends CharacterBody2D

@export var PLAYER: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 150
@export var ACCELERATION: int = 300

@onready var sprite: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $Sprite2D/RayCast2D
@onready var timer: Timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2

enum States{
	WANDER,
	CHASE
}
var current_state = States.WANDER

func _ready():
	left_bounds = self.position + Vector2(-125, 0)
	right_bounds = self.position + Vector2(125, 0)

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()


func look_for_player():
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider ==  PLAYER:
			CHASE_PLAYER()
		elif current_state == States.CHASE:
			stop_CHASE()
	elif current_state == States.CHASE:
		stop_CHASE()


func  CHASE_PLAYER() -> void:
	timer.stop()
	current_state = States.CHASE

func stop_CHASE() -> void:
	if timer.time_left <= 0:
		timer.start()

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)

	move_and_slide()
	

func change_direction() -> void:
	if current_state == States.WANDER:
		if sprite.flip_h:
			#moving right
			if self.position.x <= right_bounds.x:
				direction = Vector2(1, 0)
			else:
				#flip to moving left
				sprite.flip_h = false
				ray_cast_2d.target_position = Vector2(-125, 0)
		else:
			#moving left
			if self.position.x <= left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				#flip to moving right
				sprite.flip_h = true
				ray_cast_2d.target_position = Vector2(125, 0)
	else:
		#chase state follow player
		direction = (PLAYER.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			#flip to moving right
			sprite.flip_h = true
			ray_cast_2d.target_position = Vector2(125, 0)
		else:
			# flip to moving left
			sprite.flip_h = false
			ray_cast_2d.target_position = Vector2(-125, 0)

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_time_timeout():
	current_state = States.WANDER
