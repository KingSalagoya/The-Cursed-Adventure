extends Node2D

var player                  : Player
@export var home_position   : Vector2
@export var follow_speed            := 10
@export var return_speed            := 5
@export var follow_distance         := 220   # Distance at which the enemy will start following the player
var navigation : NavigationRegion2D  # Reference to Navigation2D

func _ready() -> void:
	player = GameManager.player
	if home_position == Vector2.ZERO:
		home_position = global_position
	# Set the navigation reference (assuming Navigation2D is available in the scene)
	navigation = get_parent().get_parent().get_node("NavigationRegion2D")  # Adjust according to the actual structure
	if navigation == null:
		print("Navigation2D node not found!")
	else:
		print("Navigation2D node found!")

func _physics_process(delta) -> void:
	if player:
		var direction       := player.global_position - global_position
		var distance_to_player := direction.length()

		if distance_to_player <= follow_distance:
			# Use Navigation2D to calculate a path to the player
			if navigation == null:
				direction = direction.normalized()
				position += direction * follow_speed * delta
			else:
				var path = navigation.get_simple_path(global_position, player.global_position)
				
				if path.size() > 1:
					# Move along the path (approaching the next point)
					var next_point = path[1]  # Get the next point in the path
					var move_direction = (next_point - global_position).normalized()
					position += move_direction * follow_speed * delta
		else:
			# If outside follow distance, move back to home position
			var return_direction = home_position - global_position
			if return_direction.length() > 1:
				return_direction = return_direction.normalized()
				position += return_direction * return_speed * delta

		if distance_to_player <= 50:
			$AnimatedSprite2D.play("attack")
			await get_tree().create_timer(0.5).timeout
		else:
			$AnimatedSprite2D.play("idle")
