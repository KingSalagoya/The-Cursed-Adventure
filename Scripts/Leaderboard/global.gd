extends Node

func _ready() -> void:
  SilentWolf.configure({
	"api_key": "QmGgyWOmgY8ugeh3yXkwK3qRX92p1EGo396XthC2",
	"game_id": "cursedadventure",
	"log_level": 1
  })

  SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/MainPage.tscn"
  })
