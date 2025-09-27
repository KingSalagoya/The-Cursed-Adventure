extends HBoxContainer

@onready var shadow_step: TextureButton = $ShadowStep
@onready var high_leap: TextureButton = $HighLeap
@onready var fade: TextureButton = $Fade

func _ready() -> void:
	shadow_step.pressed.connect(enable_shadow_step)
	high_leap.pressed.connect(enable_high_leap)
	fade.pressed.connect(enable_fade)

func enable_shadow_step() -> void:
	GameManager.sacrifice_skill.emit("ShadowStep")
	sacrifice("ShadowStep")

func enable_high_leap() -> void:
	GameManager.sacrifice_skill.emit("HighLeap")
	sacrifice("HighLeap")

func enable_fade() -> void:
	GameManager.sacrifice_skill.emit("Fade")
	sacrifice("Fade")

func sacrifice(_name: String) -> void:
	for i in get_children():
		if i.name == _name:
			i.get_child(0).visible = false
			print_debug(i.name)
		else:
			i.get_child(0).visible = true
