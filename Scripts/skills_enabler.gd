extends Node

@onready var shadow_step: ShadowStep = $ShadowStep
@onready var high_leap: HighLeap = $HighLeap
@onready var fade: Fade = $Fade
#@onready var quick_slash: QuickSlash = $QuickSlash

var sacrifice_amount       := 1
var ability_size           := 3

func _ready() -> void:
	GameManager.sacrifice_skill.connect(sacrifice)

func _physics_process(_delta: float) -> void:
	if shadow_step.visible:
		shadow_step.use()
	if high_leap.visible:
		high_leap.use()
	if fade.visible:
		fade.use()


func sacrifice(_name: String) -> void:
	for i in get_children():
		if i.name == _name:
			i.visible = true
			print_debug(i.name)
		else:
			i.visible = false
