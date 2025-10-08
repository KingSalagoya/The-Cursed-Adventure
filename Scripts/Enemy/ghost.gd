extends Node2D

var player                  : Player
@export var home_position   : Vector2
@export var follow_speed            := 10
@export var return_speed            := 5
@export var follow_distance         := 220   # Distance at which the enemy will start following the player

func _ready() -> void:
	player = GameManager.player
	if home_position == Vector2.ZERO:
		home_position = global_position


func _physics_process(delta) -> void:
	if player:
		var direction       := player.global_position - global_position
		var distance_to_player := direction.length()

		# If the player is within the follow distance, move towards them
		if distance_to_player <= follow_distance:
			direction = direction.normalized()
			position += direction * follow_speed * delta
		else:
			# Otherwise, return to home position
			var return_direction = home_position - global_position
			if return_direction.length() > 1:  # Optional check to prevent jittering when close
				return_direction = return_direction.normalized()
				position += return_direction * return_speed * delta
		
		if distance_to_player <= 50:
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.5).timeout
			$AnimatedSprite2D.play("idle")
			await get_tree().create_timer(0.5).timeout
		
		if distance_to_player <= 40:
			$AnimatedSprite2D.play("attack")
			
			
		else:
			$AnimatedSprite2D.play("idle")
