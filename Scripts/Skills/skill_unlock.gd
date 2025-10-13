class_name SkillUnlocker
extends Area2D

@export_enum("DASH", "DOUBLE_JUMP", "FADE") var SKILL_TYPE: String = "DASH"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		match SKILL_TYPE:
			"DASH": 
				GameManager.dash_unlocked = true
				GameManager.skill_unlock.emit("ShadowStep")
				GameManager.skill_ui.enable_shadow_step()
				
			"DOUBLE_JUMP":
				GameManager.double_jump_unlocked = true
				GameManager.skill_unlock.emit("HighLeap")
				GameManager.skill_ui.enable_high_leap()
				
			"FADE": 
				GameManager.inviibity_unlocked = true
				GameManager.skill_unlock.emit("Fade")
				GameManager.skill_ui.enable_fade()
				
		queue_free()
