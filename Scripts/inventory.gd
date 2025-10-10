extends Control

func _ready() -> void:
	$"Control/Dash Label".visible = true
	$"Control/Double Jump Label".visible = false
	$"Control/Invisibility Label".visible = false
	

#hover

func _on_shadow_step_mouse_entered() -> void:
	$"Control/Dash Label".visible = true
	$"Control/Double Jump Label".visible = false
	$"Control/Invisibility Label".visible = false
	
func _on_high_leap_mouse_entered() -> void:
	$"Control/Dash Label".visible = false
	$"Control/Double Jump Label".visible = true
	$"Control/Invisibility Label".visible = false

func _on_fade_mouse_entered() -> void:
	$"Control/Dash Label".visible = false
	$"Control/Double Jump Label".visible = false
	$"Control/Invisibility Label".visible = true


#usability

func _usability():
	if GameManager.dash_unlocked == true:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = false
	else:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = true
	
	if GameManager.double_jump_unlocked == true:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = false
	else:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = true
	
	if GameManager.invisibility == true:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = false
	else:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = true
	
