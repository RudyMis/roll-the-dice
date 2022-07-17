extends Spatial

func set_field(nr: String, field: Spatial):
	var node : Spatial = get_node("dummies" + nr)
	if node:
		field.transform = node.transform
		add_child(field)

func _ready():
	pass # Replace with function body.
