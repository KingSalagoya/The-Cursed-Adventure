extends Control


@onready var holder: VBoxContainer = $MarginContainer/HBoxContainer/Holder


const NORMAL_COLOR         : Color = Color(1,1,1,1)
const HIDDEN_COLOR         : Color = Color(1,1,1,0)
const DARK_COLOR           : Color = Color(0.191, 0.191, 0.191, 1.0)

var unlocked_abilities: Array[String]
var current_ability: int

func _enter_tree() -> void:
	GameManager.skill_unlock.connect(unlock)
	GameManager.skill_ui = self


func _ready() -> void:
	pass
	#GameManager.sacrifice_skill.emit("ShadowStep")
	#GameManager.update_info.emit("Press 'C' to Dash")
	sacrifice("ShadowStep")
	#label.text = "Press 'C' while moving to Dash"


func enable_shadow_step() -> void:
	GameManager.sacrifice_skill.emit("ShadowStep")
	sacrifice("ShadowStep")
	GameManager.info_label.text = "Press 'C' to Dash"

func enable_high_leap() -> void:
	GameManager.sacrifice_skill.emit("HighLeap")
	sacrifice("HighLeap")
	GameManager.info_label.text = "Press 'jump' in mid air to DoubleJump"

func enable_fade() -> void:
	GameManager.sacrifice_skill.emit("Fade")
	sacrifice("Fade")
	GameManager.info_label.text = "Press 'X' to become invinsible"

func sacrifice(_name: String) -> void:
	for i in holder.get_children():
		var tween = get_tree().create_tween()
		if i.name == _name and not unlocked_abilities.find(_name) == -1:
			tween.tween_property(i.get_child(0), "modulate", HIDDEN_COLOR, 0.2)
			#holder.move_child(i, 0)
		else: 
			if unlocked_abilities.find(_name) == -1:
				tween.tween_property(i.get_child(0), "modulate", HIDDEN_COLOR, 0.2)
			else:
				tween.tween_property(i.get_child(0), "modulate", NORMAL_COLOR, 0.2)


func unlock(_name: String) -> void:
	for i in holder.get_children():
		if i.name == _name:
			unlocked_abilities.append(_name)
			var tween = get_tree().create_tween()
			var tween2 = get_tree().create_tween()
			tween.tween_property(i.get_child(1), "modulate", HIDDEN_COLOR, 0.4)
			tween2.tween_property(i.get_child(1), "scale", Vector2.ZERO, 0.4)

			await(tween.finished)
			i.get_child(1).set_z_index(-1)

			var tween3 = get_tree().create_tween()
			var tween4 = get_tree().create_tween()
			tween3.tween_property(i.get_child(1), "modulate", DARK_COLOR, 0.4)
			tween4.tween_property(i.get_child(1), "scale", Vector2.ONE, 0.4)
			i.get_child(0).visible = true
