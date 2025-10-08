extends HitBox

var player                  : Player
@export var follow_distance := 50

func _ready() -> void:
	player = GameManager.player
	

func _physics_process(delta) -> void:
	if player:
		var direction       := player.global_position - global_position
		var distance_to_player := direction.length()

		# If the player is within the follow distance, move towards them
		if distance_to_player <= follow_distance:
			if player.visible == true :
				$AnimatedSprite2D.play("laser")
		else:
			$AnimatedSprite2D.play("idle")

func _visibility_process(delta: float) -> void:
	if $AnimatedSprite2D.is_playing("idle"):
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
