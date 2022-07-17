extends Spatial

func set_field(nr: String, field: Spatial):
	var node : Spatial = get_node("dummies/" + nr)
	if node:
		field.transform = node.transform
		add_child(field)

func into_tile():
	for child in get_children():
		if not child is Tile:
			continue
		child.into_tile()

func _ready():
	pass # Replace with function body.
