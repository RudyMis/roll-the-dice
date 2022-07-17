extends Spatial

export (float) var transition_speed = 0.1
export (float) var rotation_time = 0.4

var tiles = []
var current_tile = null
var last_pos = Vector3(0, 0, 0)

onready var camera = get_viewport().get_camera()
onready var target_transform = transform
onready var start_transform = transform

onready var move_tween = $MoveTween
onready var rotate_tween = $RotateTween
onready var nice_grid = $nice_grid

func _ready():
	tiles.append( Vector2(0, 0) )

func position_on_map():
	var plane = Plane(Vector3(0, 1, 0), 0)
	var mouse_pos = get_viewport().get_mouse_position()
	return plane.intersects_ray(camera.project_ray_origin(mouse_pos), camera.project_ray_normal(mouse_pos))

func has_tile_near(pos: Vector2):
	if len(tiles) == 0: return true
	return (tiles.find(pos + Vector2(1, 0)) != -1 or
		tiles.find(pos + Vector2(-1, 0)) != -1 or
		tiles.find(pos + Vector2(0, 1)) != -1 or
		tiles.find(pos + Vector2(0, -1)) != -1)

func approved_position():
	var pos = position_on_map()
	if pos == null:
		return null
	pos.x = round(pos.x)
	pos.z = round(pos.z)
	if tiles.find(Vector2(pos.x, pos.z)) != -1:
		return null
	
	return pos


func call_interpolation(weight):
	if current_tile:
		target_transform.origin = current_tile.transform.origin
		current_tile.transform = start_transform.interpolate_with(target_transform, weight)

func _input(_event):
	if Input.is_action_just_pressed("left") and current_tile:
		start_transform = current_tile.transform
		target_transform = target_transform.rotated(Vector3.UP, -PI / 2)
		rotate_tween.remove_all()
		rotate_tween.interpolate_method(self, "call_interpolation", 0, 1, rotation_time, Tween.TRANS_BACK, Tween.EASE_IN)
		rotate_tween.start()
	
	if Input.is_action_just_pressed("right") and current_tile:
		start_transform = current_tile.transform
		target_transform = target_transform.rotated(Vector3.UP, PI / 2)
		rotate_tween.remove_all()
		rotate_tween.interpolate_method(self, "call_interpolation", 0, 1, rotation_time, Tween.TRANS_BACK, Tween.EASE_IN)
		rotate_tween.start()

func _unhandled_input(event):
	if event is InputEventMouseButton and Input.is_action_pressed("mouse_left"):
		var pos = approved_position()
		if pos and current_tile and has_tile_near(Vector2(pos.x, pos.z)):
			current_tile.translation = pos
			tiles.append(Vector2(pos.x, pos.z))
			current_tile = null
			if nice_grid:
				nice_grid.enable_main_tile()

func _process(_delta):
	var pos = approved_position()
	if pos and current_tile:
		# animate movement
		move_tween.stop_all()
		move_tween.remove_all()
		last_pos = current_tile.translation
		move_tween.interpolate_property(current_tile, "translation",
			last_pos, pos, transition_speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		move_tween.start()
		last_pos = pos


func _on_roll(tile: Spatial):
	if current_tile != null:
		print("Rolled before we placed previous tile")
		return
	if nice_grid:
		nice_grid.disable_main_tile()
	current_tile = tile
	add_child(current_tile)
	start_transform = current_tile.transform
	target_transform = current_tile.transform
	tile.into_tile()
