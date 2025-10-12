extends Area2D

@onready var player: Node2D = GameManager.player
@export var home_position   : Vector2
@export var follow_speed            := 80
@export var follow_distance         := 20
var is_collected : bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
enum shard {SHARD_1, SHARD_2, SHARD_3}

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
				GameManager.dash_shards += 1
				if GameManager.dash_shards >= 3:
					GameManager.dash_unlocked = true
					$"../../../../../../../UI/HUD/Main/MarginContainer/Control/Progress/HBoxContainer2/Label3".text = "3/3"
					is_collected = true
					visible = false
					print("Dash Shards = " + str(GameManager.dash_shards))
				else:
					GameManager.dash_unlocked = false
					$"../../../../../../../UI/HUD/Main/MarginContainer/Control/Progress/HBoxContainer2/Label3".text = ":   " + str(GameManager.dash_shards) + "/3"
					is_collected = true
					visible = false
					print("Dash Shards = " + str(GameManager.dash_shards))

func dash_unlock() -> void:
	if GameManager.dash_shards >= 3:
		GameManager.dash_unlocked = true
	else:
		GameManager.dash_unlocked = false
