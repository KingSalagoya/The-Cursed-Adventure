extends AnimatedSprite2D

var target : Player
var speed = 10

func _ready() -> void:
	target = GameManager.player

func _physics_process(delta) -> void:
	var direction = (target.global_position-global_position).normalized()
	position += direction * speed * delta 
	
