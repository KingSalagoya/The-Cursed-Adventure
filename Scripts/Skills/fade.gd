class_name Fade extends Skills

@onready var player: Player = $"../.."
@onready var graphics: AnimatedSprite2D = $"../../Graphics"
@onready var hurt_box: HurtBox = $"../../HurtBox"

@export var INVINSIBLE_TIME    := 2.0
@export var COOL_DOWN          := 4.0

var used                       := false

func use() -> void:
	if Input.is_action_just_pressed("fade") and not used:
		invinsibility()
		cooldown()
  
func invinsibility() -> void:
	hurt_box.monitoring = false
	hurt_box.monitorable = false
	$"../../AdvancedGraphics".play("fade_in")
	await(get_tree().create_timer(INVINSIBLE_TIME).timeout)
	$"../../AdvancedGraphics".play("fade_out")
	hurt_box.monitoring = true
	hurt_box.monitorable = true

func cooldown() -> void:
		used = true
		await(get_tree().create_timer(COOL_DOWN).timeout)
		used = false
