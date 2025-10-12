extends Control

var dash_hover = false
var double_jump_hover = false
var invisibility_hover = false


func _ready() -> void:
	$"Control/Dash Label".visible = false
	$"Control/Double Jump Label".visible = false
	$"Control/Invisibility Label".visible = false
	$Control/msg.visible = true
	
	if GameManager.dash_unlocked == true:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = false
	else:
		$Control/VBoxContainer/SkillUI/ShadowStep/TextureRect.visible = true
	
	if GameManager.double_jump_unlocked == true:
		$Control/VBoxContainer/SkillUI/HighLeap/TextureRect2.visible = false
	else:
		$Control/VBoxContainer/SkillUI/HighLeap/TextureRect2.visible = true
	
	if GameManager.invisibity_unlocked == true:
		$Control/VBoxContainer/SkillUI/Fade/TextureRect3.visible = false
	else:
		$Control/VBoxContainer/SkillUI/Fade/TextureRect3.visible = true


#hover

func _on_shadow_step_mouse_entered() -> void:
	$"Control/Dash Label".visible = true
	$"Control/Double Jump Label".visible = false
	$"Control/Invisibility Label".visible = false
	$Control/msg.visible = false
	
	
func _on_high_leap_mouse_entered() -> void:
	$"Control/Double Jump Label".visible = true
	$"Control/Dash Label".visible = false
	$"Control/Invisibility Label".visible = false
	$Control/msg.visible = false

func _on_fade_mouse_entered() -> void:
	$"Control/Invisibility Label".visible = true
	$"Control/Dash Label".visible = false
	$"Control/Double Jump Label".visible = false
	$Control/msg.visible = false

#mouse exit

func _on_shadow_step_mouse_exited() -> void:
	$"Control/Dash Label".visible = false
	$Control/msg.visible = true


func _on_high_leap_mouse_exited() -> void:
	$"Control/Double Jump Label".visible = false
	$Control/msg.visible = true


func _on_fade_mouse_exited() -> void:
	$"Control/Invisibility Label".visible = false
	$Control/msg.visible = true
