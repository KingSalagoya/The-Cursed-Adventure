class_name Fade extends Skills

@onready var player: Player = $"../.."
@onready var hurt_box: HurtBox = $"../../HurtBox"

@export var INVINSIBLE_TIME    := 2.0
@export var COOL_DOWN          := 8.0

func use() -> void:
	hurt_box.monitoring = false
	hurt_box.monitorable = false
	await(get_tree().create_timer(INVINSIBLE_TIME).timeout)
  
