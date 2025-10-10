extends Area2D
class_name HiddenAreaTrigger #YEAH I SUCK AT MAKING NAMES


@export_group("data")
@export var TRIGGER_DATA        : Dictionary[Node2D, AreaTriggerResource]
@export var NORMAL_COLOR          : Color = Color(1,1,1,1)
@export var HIDDEN_COLOR        : Color = Color(1,1,1,0)

func _enter_tree() -> void:
	body_exited.connect(_on_body_exited)

func _on_body_exited(player: Node2D) -> void:
	print("PLAYTER HERER")
	if player.is_in_group("Player"):
		print("INTHEFRIKINGROUP")
		for i in TRIGGER_DATA.keys():
			var image           = i
			var exiting_in_right = TRIGGER_DATA[i].EXITING_IN_RIGHT
			var fade_time       = TRIGGER_DATA[i].FADE_TIME
			var tween = get_tree().create_tween()

			if (player.global_position.x - global_position.x) < 0:
				if exiting_in_right: tween.tween_property(image, "modulate", HIDDEN_COLOR, fade_time)
				else: tween.tween_property(image, "modulate", NORMAL_COLOR, fade_time)
			else:
				if not exiting_in_right: tween.tween_property(image, "modulate", HIDDEN_COLOR, fade_time)
				else: tween.tween_property(image, "modulate", NORMAL_COLOR, fade_time)
