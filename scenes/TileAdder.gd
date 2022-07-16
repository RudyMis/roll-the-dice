extends Spatial

var tiles = []

var tileset = { "factory" : load("res://scenes/tiles/factory.tscn"),
				"tree" : load("res://scenes/tiles/tree.tscn"),
				"house" : load("res://scenes/tiles/house.tscn"), }

export var current_tile = "house"

var plane = Plane(Vector3(0, 1, 0), 0)

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var mouse_pos = get_viewport().get_mouse_position();
		var pos = plane.intersects_ray(
			$"../Camera".project_ray_origin(mouse_pos),
			$"../Camera".project_ray_normal(mouse_pos)
			)
		if (pos != null):
			pos.x = round(pos.x)
			pos.z = round(pos.z)
			if tiles.find(Vector2(pos.x, pos.z)) == -1:
				var tile_to_add = tileset[current_tile].instance()
				tile_to_add.translation = pos
				add_child(tile_to_add)
				tiles.append(Vector2(pos.x, pos.z))
				print("Dodano")
