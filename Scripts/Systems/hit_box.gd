class_name HitBox
extends Area2D

#@export_category("Main")
#@export var damage                        := 1
@export var respawn_to_checkpoint         := true

func _enter_tree() -> void:
	collision_layer = 4
	collision_mask = 0
