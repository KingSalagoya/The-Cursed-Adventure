extends Area2D

@onready var player: Node2D = GameManager.player
@export var home_position   : Vector2
@export var follow_speed            := 80
@export var follow_distance         := 20
var is_collected : bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
enum shard {SHARD_1, SHARD_2, SHARD_3, SHARD_4, SHARD_5}

@export var show_shard : shard

func _ready() -> void:
	if home_position == Vector2.ZERO:
		home_position = global_position
	animated_sprite_2d.play(str(show_shard))
	visible = true

func _physics_process(delta) -> void:
	if player:
		if  is_collected == false:
			var direction       := player.global_position - global_position
			var distance_to_player := direction.length()
			
			# If the player is within the follow distance, move towards them
			if distance_to_player <= follow_distance:
				direction = direction.normalized()
				position += direction * follow_speed * delta
			
			if distance_to_player <= 5:
				GameManager.invisibility_shards += 1
				is_collected = true
				visible = false
				print("Invisibility Shards = " + str(GameManager.invisibility_shards))
