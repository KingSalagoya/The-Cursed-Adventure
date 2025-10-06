extends HBoxContainer

@onready var shadow_step: TextureButton = $ShadowStep
@onready var high_leap: TextureButton = $HighLeap
@onready var fade: TextureButton = $Fade
@onready var label: Label = $"../Label"

func _ready() -> void:
	shadow_step.pressed.connect(enable_shadow_step)
	high_leap.pressed.connect(enable_high_leap)
	fade.pressed.connect(enable_fade)
	GameManager.sacrifice_skill.emit("ShadowStep")
	sacrifice("ShadowStep")
	label.text = "Press 'C' while moving to Dash"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("num1"):
		enable_shadow_step()
	elif event.is_action_pressed("num2"):
		enable_high_leap()
	elif event.is_action_pressed("num3"):
		enable_fade()

func enable_shadow_step() -> void:
	GameManager.sacrifice_skill.emit("ShadowStep")
	sacrifice("ShadowStep")
	label.text = "Press 'C' while moving to Dash"

func enable_high_leap() -> void:
	GameManager.sacrifice_skill.emit("HighLeap")
	sacrifice("HighLeap")
	label.text = "Press jump in mid air to Double Jump"

func enable_fade() -> void:
	GameManager.sacrifice_skill.emit("Fade")
	sacrifice("Fade")
	label.text = "Press X to become invinsible for an short period of time"

func sacrifice(_name: String) -> void:
	for i in get_children():
		if i.name == _name:
			#var tween = Tween.new()
			#tween.tween_property(i, "scale", 0.0, 0.2)
			i.get_child(0).visible = false
			print_debug(i.name)
		else:
			#var tween = Tween.new()
			#tween.tween_property(i, "scale", 1, 0.2)
			i.get_child(0).visible = true
