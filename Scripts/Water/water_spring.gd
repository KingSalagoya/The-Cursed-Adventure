extends Node2D

var velocity = 0
var force = 0
var height = 0
var target_height = 0
var index = 0
var motion_factor = 0.02
var cam

signal splash

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area_2d: Area2D = $Area2D

func water_update(spring_constraint, dampening) -> void:
	height = position.y
	
	var x  = height - target_height
	var loss = -dampening * velocity
	
	# hook's law of motion
	force = -spring_constraint * x + loss
	velocity += force
	
	position.y += velocity
	

func unload_collisions() -> void:
	if cam:
		if cam.global_position.distance_to(global_position) >= 300:
			area_2d.monitoring = false
			area_2d.monitorable = false
			collision.disabled = true
		else:
			area_2d.monitoring = true
			area_2d.monitorable = true
			collision.disabled = false

func check_viewport_visible() -> bool:
	if cam.global_position.distance_to(global_position) >= 300:
		return false
	else:
		return true

func initialize(x_position: float, _id) -> void:
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = _id


func set_collision_width(value) -> void:
	var extents = (collision.shape as RectangleShape2D).extents
	var new_extents = Vector2(value/2, extents.y)
	(collision.shape as RectangleShape2D).extents = new_extents


func _on_area_2d_body_entered(body: Node2D) -> void:
	#var speed = body.velocity.y + motion_factor
	var speed = (body.velocity.y/200) + motion_factor
	emit_signal("splash", index, speed)
