extends Camera2D

const SCREEN_SIZE    := Vector2(360, 180)
var cur_Screen       := Vector2.ZERO


func _ready() -> void:
	top_level = true
	global_position = get_parent().global_position
	update_screen(cur_Screen)

func _physics_process(_delta: float) -> void:
	var parent_screen = Vector2(get_parent().global_position / SCREEN_SIZE).floor()
	if not parent_screen.is_equal_approx(cur_Screen):
		update_screen(cur_Screen)


func update_screen(new_screen: Vector2) -> void:
	cur_Screen = new_screen
	global_position = cur_Screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
