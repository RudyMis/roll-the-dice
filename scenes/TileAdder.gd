extends Spatial

export var transition_speed = 0.1

var tiles = []
var current_tile = null
var last_pos = Vector3(0, 0, 0)

onready var camera = get_viewport().get_camera()
onready var tween = $Tween

func _ready():
	pass

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

func _unhandled_input(event):
	if event is InputEventMouseButton and Input.is_action_pressed("mouse_left"):
		var pos = approved_position()
		if pos and current_tile and has_tile_near(Vector2(pos.x, pos.z)):
			current_tile.translation = pos
			current_tile.deactivate()
			tiles.append(Vector2(pos.x, pos.z))
			current_tile = null

func _process(_delta):
	var pos = approved_position()
	if pos and current_tile:
		# animate movement
		if tween.is_active():
			tween.stop_all()
			tween.remove_all()
			last_pos = current_tile.translation
		tween.interpolate_property(current_tile, "translation",
			last_pos, pos, transition_speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		last_pos = pos


func _on_roll(tile: Spatial):
	if current_tile != null:
		print("Rolled before we placed previous tile")
		return
	current_tile = tile
	add_child(current_tile)
