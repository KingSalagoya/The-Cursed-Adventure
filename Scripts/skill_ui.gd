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
	label.text = "Press 'D' while moving to Dash"

func enable_shadow_step() -> void:
	GameManager.sacrifice_skill.emit("ShadowStep")
	sacrifice("ShadowStep")
	label.text = "Press 'D' while moving to Dash"

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
			i.get_child(0).visible = false
			print_debug(i.name)
		else:
			i.get_child(0).visible = true
