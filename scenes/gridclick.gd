extends GridMap

func _ready():
	pass # Replace with function body.

func _process(delta):
	var position2D = get_viewport().get_mouse_position()
	var position3D = $"../Camera".viewport_to_map(position2D)
	if (position3D != null):
		position3D.x = round(position3D.x)
		position3D.z = round(position3D.z)
		$"../MeshInstance".translation = position3D
