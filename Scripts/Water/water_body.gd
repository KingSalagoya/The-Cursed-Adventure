extends Node2D

@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0004

var springs = []
var visible_springs = []
var passes = 16

@export var distance_between_springs = 32
@export var spring_number = 6

var water_length = distance_between_springs * spring_number
var cam

const water_spring = preload("res://Scenes/water/water_spring.tscn")

@export var depth: float = 20

var target_height = global_position.y
var bottom = target_height + depth

@onready var water_polygon: Polygon2D = $WaterPolygon


#SOUNDS
@export var water_splash_sfx: AudioStream

func _ready() -> void:
	visible = true
	for i in range(spring_number):
		cam = get_viewport().get_camera_2d()
		var x_position = distance_between_springs * i
		var w = water_spring.instantiate()
		
		call_deferred("add_child", w)
		springs.append(w)
		w.initialize(x_position, i)
		w.call_deferred("set_collision_width", distance_between_springs)
		w.connect("splash", splash)
		w.cam = cam
	update_visible_springs()
	
func update_visible_springs() -> void:
	visible_springs = []
	for i in springs:
		if i.check_viewport_visible():
			visible_springs.append(i)
	#cam.global_position.distance_to(global_position) >= 300:

func _physics_process(_delta: float) -> void:
	for i in visible_springs:
		i.water_update(k, d)
	
	var left_deltas = []
	var right_deltas = []
	
	for i in range(visible_springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
	
	for j in range(passes):
		for i in range(visible_springs.size()):
			if i > 0:
				left_deltas[i] = spread * (visible_springs[i].height - visible_springs[i-1].height)
				visible_springs[i-1].velocity += left_deltas[i]
			if i < visible_springs.size()-1:
				right_deltas[i] = spread * (visible_springs[i].height - visible_springs[i+1].height)
				visible_springs[i+1].velocity += right_deltas[i]
	draw_water_body()

func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
		if (int(index) % 2) == 0:
			GlobalAudioManager.play_audio_oneshot(water_splash_sfx)

func draw_water_body() -> void:
	if not visible_springs: return
	var surface_points = []
	
	surface_points.append(springs[1].position)
	for i in range(visible_springs.size()):
		surface_points.append(visible_springs[i].position)
	surface_points.append(springs[springs.size()-1].position)
	
	var first_index = 0
	var last_index = surface_points.size()-1
	
	var water_polygon_points = surface_points
	
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	water_polygon.set_polygon(water_polygon_points)


func _on_timer_timeout() -> void:
	for i in get_children():
		if i.has_method("unload_collisions"):
			i.unload_collisions()
	update_visible_springs()
