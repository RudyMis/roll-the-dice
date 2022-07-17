extends Spatial

const plane = Plane(Vector3(0, 1, 0), 0)

onready var cam = get_viewport().get_camera()

func _process(delta):
	get_viewport().get_m
	var pos2d = get_viewport().get_mouse_position()
	var pos3d = plane.intersects_ray(cam.project_ray_origin(pos2d),cam.project_ray_normal(pos2d))
	for child in get_children():
		var vec = child.translation
		vec.y = 0
		child.translation.y = -(
			vec.norm() +
			translation.distance_squared_to($Pointer.translation) / 100
			)
