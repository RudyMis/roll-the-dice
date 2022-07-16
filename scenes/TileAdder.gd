extends Spatial

export var transition_speed = 0.1

var tiles = []
var current_tile = null
var last_pos = Vector3(0, 0, 0)
var plane = Plane(Vector3(0, 1, 0), 0)

onready var camera = $Camera
onready var tween = $Tween

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var mouse_pos = get_viewport().get_mouse_position();
		var pos = plane.intersects_ray(
			camera.project_ray_origin(mouse_pos),
			camera.project_ray_normal(mouse_pos)
			)
		if (pos != null):
			pos.x = round(pos.x)
			pos.z = round(pos.z)
			if tiles.find(Vector2(pos.x, pos.z)) == -1 and current_tile != null:
				current_tile.translation = pos
				add_child(current_tile)
				tiles.append(Vector2(pos.x, pos.z))
				current_tile = null

func _process(_delta):
	var pos2d = get_viewport().get_mouse_position()
	var pos3d = plane.intersects_ray(camera.project_ray_origin(pos2d), camera.project_ray_normal(pos2d))
	if (pos3d != null):
		pos3d.x = round(pos3d.x)
		pos3d.z = round(pos3d.z)
		if last_pos != pos3d and current_tile:
			# animate movement
			if tween.is_active():
				tween.stop_all()
				tween.remove_all()
				last_pos = translation
			tween.interpolate_property(current_tile, "translation",
				last_pos, pos3d, transition_speed,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			last_pos = pos3d
