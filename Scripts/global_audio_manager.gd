extends Node



var music_audio_player_count         := 2
var current_music_player             := 0

var music_player: Array[AudioStreamPlayer] = []

var music_bus                        := "Music"
var music_fade_duration              := 0.5

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in music_audio_player_count:
		var audio_player             := AudioStreamPlayer.new()
		add_child(audio_player)

		audio_player.bus = music_bus
		music_player.append(audio_player)
		audio_player.volume_db = -40



func play_music(_audio: AudioStream) -> void:
	if _audio == music_player[current_music_player].stream: return

	current_music_player += 1
	if current_music_player > 1: current_music_player = 0
	
	var current_player               := music_player[current_music_player]
	current_player.stream = _audio
	play_and_fade_in(current_player)

	var old_music_player             := music_player[1]
	if current_music_player == 1:
		old_music_player = music_player[0]

	fade_out_and_stop(old_music_player)


func play_and_fade_in(music_player: AudioStreamPlayer) -> void:
	music_player.play(0)

	var tween                        := create_tween()
	tween.tween_property(music_player, 'volume_db', 0, music_fade_duration)

func fade_out_and_stop(music_player: AudioStreamPlayer) -> void:
	var tween                        := create_tween()
	tween.tween_property(music_player, 'volume_db', -40, music_fade_duration)
	await tween.finished
	music_player.stop()
	
