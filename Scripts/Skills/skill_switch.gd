class_name SkillSwitch extends Area2D

var enable: bool
var previous_info_text: String

func _enter_tree() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		previous_info_text = GameManager.info_label.text
		GameManager.info_label.text = "Press '1,2,3' to switch Abilities!"
		enable = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.info_label.text = previous_info_text
		enable = false


func _unhandled_input(event: InputEvent) -> void:
	if not enable: return
	if event.is_action_pressed("num1") and GameManager.dash_unlocked:
		GameManager.skill_ui.enable_shadow_step()
	elif event.is_action_pressed("num2") and GameManager.double_jump_unlocked:
		GameManager.skill_ui.enable_high_leap()
	elif event.is_action_pressed("num3") and GameManager.inviibity_unlocked:
		GameManager.skill_ui.enable_fade()
