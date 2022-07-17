extends Spatial

class_name Tile
func is_class(name): return name == "Tile" || .is_class(name)
func get_class(): return "Tile"

export (String) var type = ""
export (Array, bool) var occupied_sides = [false, false, false, false]

onready var mesh = $mesh
onready var sprite = $sprite

func into_tile():
	mesh.visible = true
	sprite.visible = false

func is_side_occupied(side: int):
	return occupied_sides[side % len(occupied_sides)]

func _ready():
	mesh.visible = false
	sprite.visible = true
