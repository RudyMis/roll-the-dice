extends Spatial

func set_field(nr: String, texture: Texture):
	var node = get_node(nr)
	if node and node is Sprite3D:
		node.set_texture(texture)

func _ready():
	pass # Replace with function body.
