extends Spatial

class_name Tile
func is_class(name): return name == "Tile" || .is_class(name)
func get_class(): return "Tile"

export (bool) var b_random_sprite = false
export (String) var sprite_prefix = ""

onready var mesh = $mesh
onready var sprite = $sprite

func into_tile():
	mesh.visible = true
	sprite.visible = false

func randomize_sprite():
	pass

func _ready():
	if b_random_sprite:
		randomize_sprite()
	mesh.visible = false
	sprite.visible = true
