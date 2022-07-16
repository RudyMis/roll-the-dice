extends Spatial

const plane = Plane(Vector3(0, 1, 0), 0)

func _process(delta):
	var pos2d = get_viewport().get_mouse_position()
	var pos3d = plane.intersects_ray($"../Camera".project_ray_origin(pos2d),$"../Camera".project_ray_normal(pos2d))
	if (pos3d != null):
		$light.translation = pos3d * 2
		pos3d.x = round(pos3d.x)
		pos3d.z = round(pos3d.z)
		$movable_segment.translation = pos3d * 2
