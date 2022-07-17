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

func get_corner(nr: int):
	pass

func get_side(nr: int):
	var rot = rotation_degrees.y / 90
	for child in get_children():
		if child.is_in_group("road"):
			var child_rot = child.rotation_degrees.y / 90
#			print("	Rot: ", rot, child_rot)
			var target_side = nr + child_rot + rot
#			print("	", target_side)
			while target_side >= 4: target_side -= 4
			while target_side < 0: target_side += 4
#			target_side = target_side % 4
#			print("	", target_side)
			if child.is_side_occupied(target_side):
				return child.type
	return null

func _ready():
	pass # Replace with function body.
