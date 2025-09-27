extends CanvasLayer

func _ready() -> void:
	GameManager.toggle_hud.connect(toggle_hud)

func toggle_hud(toggle: bool) -> void:
	visible = toggle
