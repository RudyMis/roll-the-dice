extends MeshInstance

var last_pos = Vector3(0, 0, 0)
var plane  = Plane(Vector3(0, 1, 0), 0)

export var transition_speed = 0.1

func _process(_delta):
	var pos2d = get_viewport().get_mouse_position()
	var pos3d = plane.intersects_ray($"../Camera".project_ray_origin(pos2d),$"../Camera".project_ray_normal(pos2d))
	if (pos3d != null):
		pos3d.x = round(pos3d.x)
		pos3d.z = round(pos3d.z)
		if last_pos != pos3d and $"../TileAdder".tiles.find(Vector2(pos3d.x, pos3d.z)) == -1:
			# animate movement
			if $Tween.is_active():
				$Tween.stop_all()
				$Tween.remove_all()
				last_pos = translation
			$Tween.interpolate_property(self, "translation",
				last_pos, pos3d, transition_speed,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			last_pos = pos3d
